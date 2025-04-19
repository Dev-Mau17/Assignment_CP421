#!/bin/bash

LOG_FILE="/var/log/server_health.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

echo "----- Health Check at $TIMESTAMP -----" >> "$LOG_FILE"

### CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "CPU Usage: $CPU_USAGE%" >> "$LOG_FILE"

### Memory usage
MEM_USAGE=$(free -m | awk '/Mem:/ { printf("%.2f"), $3/$2 * 100.0 }')
echo "Memory Usage: $MEM_USAGE%" >> "$LOG_FILE"

### Disk usage
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
echo "Disk Usage: $DISK_USAGE%" >> "$LOG_FILE"

### Disk space warning
if [ "$DISK_USAGE" -gt 90 ]; then
  echo "WARNING: Disk usage is above 90%" >> "$LOG_FILE"
fi

### Check if web server is running
if pgrep apache2 > /dev/null || pgrep nginx > /dev/null; then
  echo "Web Server Status: Running" >> "$LOG_FILE"
else
  echo "WARNING: Web Server is NOT running" >> "$LOG_FILE"
fi

###Check API endpoints
STUDENTS_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://51.20.142.171/students.php)
SUBJECTS_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://51.20.142.171/subjects.php)

echo "/students.php endpoint status: $STUDENTS_STATUS" >> "$LOG_FILE"
echo "/subjects.php endpoint status: $SUBJECTS_STATUS" >> "$LOG_FILE"

###Endpoint warnings
if [ "$STUDENTS_STATUS" -ne 200 ]; then
  echo "WARNING: /students.php endpoint returned $STUDENTS_STATUS" >> "$LOG_FILE"
fi

if [ "$SUBJECTS_STATUS" -ne 200 ]; then
  echo "WARNING: /subjects.php endpoint returned $SUBJECTS_STATUS" >> "$LOG_FILE"
fi

echo "----------------------------------------" >> "$LOG_FILE"
