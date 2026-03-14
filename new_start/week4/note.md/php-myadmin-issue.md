## Fix: MySQL connection refused in Docker

**1. Stop and remove all containers:**
```bash
docker compose down
```

**2. Delete the database folder:**
```powershell
Remove-Item -Recurse -Force db
```

**3. Start everything back up:**
```bash
docker compose up -d
```

**4. Wait about 10 seconds, then open phpMyAdmin:**
```
http://localhost:8081
```

---

> **When to use this:** Any time you see an error like `Host '172.x.x.x' is not allowed to connect to this MySQL server`
> 
> **Warning:** This deletes all data in the database. Only use it if you don't need the data inside it.