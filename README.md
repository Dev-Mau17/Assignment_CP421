# Assignment_CP421
This project based on creating api that fetch students data and subject data from the database 
#Setup instructions 
for project to run successfully you must install xampp server,php ,IDE(VS Code) 
#configuration on php file change it from php init.development to php.ini

#BASH SCRIPT
# AWS Server Management Scripts for API Deployment

This repository contains Bash scripts for monitoring, maintaining, and backing up an API deployed on an AWS Ubuntu EC2 instance (t2.micro or t3.micro). These scripts support automation of server health checks, backups, and update processes.

---

## 🔧 Scripts Overview

### 1. `health_check.sh`
**Purpose:**  
Monitors system health and ensures the API is operational.

**Functionality:**
- Checks CPU usage, memory usage, and disk space.
- Verifies that the web server (Apache/Nginx) is running.
- Sends `curl` requests to `/students` and `/subjects` endpoints and checks for HTTP 200 response.
- Logs results with timestamps to `/var/log/server_health.log`.
- Adds warnings to the log if disk space is <10% or an endpoint is unreachable.

---

### 2. `backup_api.sh`
**Purpose:**  
Creates daily backups of the API code and database.

**Functionality:**
- Archives the API directory (e.g., `/var/www/your_api`) into `/home/ubuntu/backups/api_backup_$(date +%F).tar.gz`.
- Dumps the database (MySQL/PostgreSQL) into `/home/ubuntu/backups/db_backup_$(date +%F).sql`.
- Deletes backup files older than 7 days.
- Logs backup results to `/var/log/backup.log`.

---

### 3. `update_server.sh`
**Purpose:**  
Automates server updates and API deployment from GitHub.

**Functionality:**
- Updates system packages (`apt update && apt upgrade -y`).
- Pulls the latest API changes from GitHub.
- Restarts the web server.
- Logs the process to `/var/log/update.log`.
- If `git pull` fails, logs the error and skips the restart.

---

## 📦 Dependencies

Make sure the following tools and services are installed and running on your AWS Ubuntu EC2 instance:

- `curl`
- `tar`
- `gzip`
- `cron`
- `git` OR 'web interface'
- `mysql-client` or `postgresql-client` 
- `apache2` or `nginx` 

**Install using:**

```bash
sudo apt update
sudo apt install curl git cron tar gzip apache2 mysql-client -y

