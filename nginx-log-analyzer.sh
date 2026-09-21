#!/usr/bin/env bash

LOG_FILE="${1:-"/var/log/nginx/nginx.log"}"

if [[ ! -f "$LOG_FILE" ]]; then
        echo "$LOG_FILE is not a file"
	exit 1
fi	

# Top 5 IP adresses with the most requests
echo "Top 5 IP adresses with the most requests: "
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 5| awk '{printf "%s - %d requests\n", $2, $1}'

echo 

# Top 5 most requested paths
echo "Top 5 most requested paths:"
awk -F'"' '{print $2}' "$LOG_FILE" | awk '{print $2}' | sort | uniq -c | sort -nr | head -n 5 | awk '{printf "%s - %d requests\n", $2, $1}'

echo

# Top 5 response status codes
echo "Top 5 response status codes:"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 5 | awk '{printf "%d - %d requests\n", $2, $1}'

echo

# Top 5 user agents
echo "Top 5 user agents:"
awk -F'"' '{split($6, a, " "); print a[1]}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 5 | awk '{printf "%s - %d requests\n", ($2 == "-" ? "Unknown" : $2), $1}'

echo

