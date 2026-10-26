using System;
using System.Collections.Generic;
using System.Configuration;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System.Web;
using AureliaFc.Web.DAL;
using AureliaFc.Web.Models;
using Microsoft.IdentityModel.Tokens;

namespace AureliaFc.Web.Services
{
    /// <summary>
    /// Issues and validates the JWT used to identify a signed-in supporter, and keeps it
    /// in an HttpOnly cookie so page code never handles the raw token.
    ///
    /// The claims issued are identical to the JSON API's (sub / email / nameidentifier /
    /// name / role), so both hosts recognise each other's tokens when they share a key.
    /// </summary>
    public static class AuthService
    {
        public const string CookieName = "aurelia_auth";

        private static string Key
        {
            get
            {
                var fromEnvironment = Environment.GetEnvironmentVariable("Jwt__Key");
                if (!string.IsNullOrWhiteSpace(fromEnvironment)) return fromEnvironment;
                return ConfigurationManager.AppSettings["Aurelia:JwtKey"];
            }
        }

        private static string Issuer { get { return ConfigurationManager.AppSettings["Aurelia:JwtIssuer"]; } }
        private static string Audience { get { return ConfigurationManager.AppSettings["Aurelia:JwtAudience"]; } }

        private static int TimeoutMinutes
        {
            get
            {
                int minutes;
                return int.TryParse(ConfigurationManager.AppSettings["Aurelia:AuthTimeoutMinutes"], out minutes)
                    ? minutes : 45;
            }
        }

        /// <summary>Issues a signed token for the given account.</summary>
        public static string CreateToken(User user)
        {
            if (string.IsNullOrWhiteSpace(Key) || Key.Length < 32)
                throw new InvalidOperationException(
                    "JWT signing key is not configured. Set the Jwt__Key environment variable " +
                    "(see Services/AuthService.cs) to a value of at least 32 characters.");

            var claims = new[]
            {
                new Claim(JwtRegisteredClaimNames.Sub, user.Id.ToString()),
                new Claim(JwtRegisteredClaimNames.Email, user.Email),
                new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
                new Claim(ClaimTypes.Name, user.FullName),
                new Claim(ClaimTypes.Role, user.Role)
            };

            var credentials = new SigningCredentials(
                new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Key)),
                SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                issuer: Issuer,
                audience: Audience,
                claims: claims,
                expires: DateTime.UtcNow.AddMinutes(TimeoutMinutes),
                signingCredentials: credentials);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        /// <summary>Validates a token and returns its principal, or null when invalid.</summary>
        public static ClaimsPrincipal ValidateToken(string token)
        {
            if (string.IsNullOrWhiteSpace(token) || string.IsNullOrWhiteSpace(Key) || Key.Length < 32) return null;
            try
            {
                var handler = new JwtSecurityTokenHandler();
                return handler.ValidateToken(token, new TokenValidationParameters
                {
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidateLifetime = true,
                    ValidateIssuerSigningKey = true,
                    ValidIssuer = Issuer,
                    ValidAudience = Audience,
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Key)),
                    ClockSkew = TimeSpan.FromMinutes(1)
                }, out _);
            }
            catch (SecurityTokenException)
            {
                return null;
            }
            catch (ArgumentException)
            {
                return null;
            }
        }

        /// <summary>Writes the auth cookie for the supplied account.</summary>
        public static void SignIn(User user, bool persistent)
        {
            var cookie = new HttpCookie(CookieName, CreateToken(user))
            {
                HttpOnly = true,
                Secure = HttpContext.Current.Request.IsSecureConnection,
                Path = "/"
            };
            if (persistent) cookie.Expires = DateTime.UtcNow.AddMinutes(TimeoutMinutes);
            HttpContext.Current.Response.Cookies.Set(cookie);
        }

        public static void SignOut()
        {
            var cookie = new HttpCookie(CookieName, string.Empty)
            {
                HttpOnly = true,
                Expires = DateTime.UtcNow.AddDays(-1),
                Path = "/"
            };
            HttpContext.Current.Response.Cookies.Set(cookie);
        }

        /// <summary>The account id carried by the auth cookie, or null when signed out.</summary>
        public static int? CurrentUserId
        {
            get
            {
                var principal = CurrentPrincipal;
                if (principal == null) return null;
                var claim = principal.FindFirst(ClaimTypes.NameIdentifier);
                int id;
                return claim != null && int.TryParse(claim.Value, out id) ? id : (int?)null;
            }
        }

        public static ClaimsPrincipal CurrentPrincipal
        {
            get
            {
                var context = HttpContext.Current;
                if (context == null) return null;

                // Cache per request so a page issuing many lookups validates the token once.
                const string cacheKey = "__aurelia_principal";
                if (context.Items.Contains(cacheKey)) return (ClaimsPrincipal)context.Items[cacheKey];

                var cookie = context.Request.Cookies[CookieName];
                var principal = cookie == null ? null : ValidateToken(cookie.Value);
                context.Items[cacheKey] = principal;
                return principal;
            }
        }

        public static bool IsAuthenticated { get { return CurrentUserId.HasValue; } }

        /// <summary>The signed-in account, or null. Reads the database on each call.</summary>
        public static User CurrentUser
        {
            get
            {
                var id = CurrentUserId;
                return id.HasValue ? new UserRepository().FindById(id.Value) : null;
            }
        }

        public static bool IsAdmin
        {
            get
            {
                var principal = CurrentPrincipal;
                return principal != null && principal.IsInRole("Admin");
            }
        }
    }
}
