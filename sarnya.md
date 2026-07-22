sarnya.md

Basic instructions to run SQL Server code

Prerequisites
- Docker (recommended) or a local Microsoft SQL Server installation
- sqlcmd (optional) or a DB client (Azure Data Studio, SSMS)
- Runtime for your code (e.g., .NET, Node.js, Python) and its SQL Server driver

1) Start a SQL Server container (Docker)
PowerShell:
```powershell
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Your_password123" -p 1433:1433 --name sqlserver -d mcr.microsoft.com/mssql/server:2019-latest
```
Wait ~10–20s for startup.

2) Run SQL scripts inside the container
```powershell
docker exec -it sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "Your_password123" -i /path/in/container/your-script.sql
```
(Or mount a host folder and reference the mounted path.)

3) Connection strings (examples)
- .NET (System.Data.SqlClient / Microsoft.Data.SqlClient):
  Server=localhost,1433;Database=MyDb;User Id=sa;Password=Your_password123;
- Node (mssql):
  const config = { server: 'localhost', port: 1433, user: 'sa', password: 'Your_password123', database: 'MyDb', options: { encrypt: false } };
- Python (pyodbc):
  conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER=localhost,1433;DATABASE=MyDb;UID=sa;PWD=Your_password123')

4) Running app code
- Ensure the DB is initialized (create DB, run migrations or execute schema SQL).
- Set the connection string in env vars (e.g., DATABASE_URL or connection-specific env).
- Start your app as usual (dotnet run, node index.js, python app.py).

5) Troubleshooting
- "Login failed for user 'sa'": check SA_PASSWORD meets complexity and container logs.
- Port conflicts: ensure 1433 is free or map to another host port (e.g., -p 14330:1433) and update connection string.
- Use `docker logs sqlserver` to inspect container errors.

Notes
- For production, do NOT use SA or weak passwords; use managed instances or secure credentials.
- Adjust driver options (encrypt/trustServerCertificate) per environment.

