# AURELIA FC — ASP.NET Web Forms site

.NET Framework 4.8 Web Forms implementation of the AURELIA FC design
(`.aspx` pages with C# code-behind, ADO.NET against MySQL 8).

The original React + .NET 9 project at the repository root is untouched; this
folder is a separate, self-contained web application.

## Open and run (Visual Studio)

1. Open **`AureliaFc.sln`** (this folder) in Visual Studio.
2. Wait for NuGet restore to finish (status bar / `Build > Restore NuGet Packages`).
3. Press **Ctrl+F5** (Start Without Debugging).

The site starts under IIS Express at **http://localhost:5120/** and opens
`Default.aspx`. The solution has one project, `AureliaFc.Web`, configured with
`UseIIS=True` and that fixed URL, so no extra setup is required in the IDE.

Port 5120 must be free. If another process holds it, stop it
(`taskkill /F /IM iisexpress.exe`) or change `IISUrl` in the *Web* tab of the
project properties.

## Database

The site reads the `Aurelia` connection string from `AureliaFc.Web/Web.config`,
which points at the `aurelia_fc_v2` database. Create it once with:

```bat
cd database
setup.cmd "C:\path\to\mysql.exe"
```

The script drops and recreates `aurelia_fc_v2`, creates every table/index/view
and loads the seed data. See [`database/README.md`](database/README.md) for the
schema documentation, ERD and reset instructions.

Connection-string override order (see `DAL/AureliaDatabase.cs`):

1. `ConnectionStrings__Aurelia`
2. `AURELIA_CONNECTION_STRING`
3. `Web.config`

## Project layout

| Path | Contents |
| --- | --- |
| `Default.aspx` | Home page. |
| `Club/` | About, Contact, Gallery, NotFound. |
| `Squad/` | Teams, Players, PlayerProfile. |
| `Matches/` | Matches, MatchDetail, LeagueTable. |
| `Shop/` | Shop + basket, Tickets. |
| `News/` | News index, Article. |
| `Account/` | SignIn, SignUp, Account, SignOut. |
| `Site.Master`, `Auth.Master` | Public chrome and the minimal auth layout. |
| `AureliaPage.cs` | Shared page base class (encoding/URL helpers). |
| `DAL/` | Repositories (ADO.NET, parameterised SQL). |
| `Services/` | Auth (JWT cookie), basket, formatting, validation, hashing. |
| `Models/` | View models passed to the markup. |
| `Content/` | `site.css` (design tokens) and `pages.css` (per-page styles). |
| `assets/images/` | Photography and artwork used by the pages. |
| `tools/` (repo root) | `generate-designers.ps1`, the `*.designer.cs` generator. |

## Notes

- Authentication uses HS256 JWTs issued by `Services/AuthService.cs`, stored in
  the HttpOnly `aurelia_auth` cookie, with BCrypt password hashes.
- Basket lines are never trusted from the client: every checkout re-reads and
  re-prices each item from the catalogue tables inside a transaction.
- Google/Apple sign-in buttons are rendered disabled — no OAuth provider is
  configured.
- `App_Data/logs/errors.log` receives unhandled server errors (created on first
  error; excluded from Git).
- If you edit `.aspx` or `.Master` markup, re-run
  `powershell -NoProfile -ExecutionPolicy Bypass -File tools\generate-designers.ps1`
  so the designer partials stay in sync.
