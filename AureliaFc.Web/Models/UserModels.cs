namespace AureliaFc.Web.Models
{
    /// <summary>Registered supporter account (table: users).</summary>
    public class User
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string PasswordHash { get; set; }
        public string Role { get; set; }
        public System.DateTime CreatedAt { get; set; }
        public System.DateTime UpdatedAt { get; set; }

        public string FullName { get { return (FirstName + " " + LastName).Trim(); } }
        public bool IsAdmin { get { return Role == "Admin"; } }
    }
}
