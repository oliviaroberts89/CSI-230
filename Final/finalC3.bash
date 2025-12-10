#!/bin/bash
{ echo "<html><body><h2>Logs with IOC</h2>"
  echo "<tr><th>IP</td><th>Date-Time</th><th>Page</th></tr>"
  while read -r line; do
  ip=$(echo "$line" | awk '{print $1}')
  datetime=$(echo "$line" |awk '{print $2}')
  page=$(echo "$line" | awk '{print $3}')
  echo "<tr><td>$ip</td><td>$datetime</td><td>$page</td></tr>"
  done < report.txt
  echo "</table></body></html>"
} > report.html
sudo mv report.html /var/www/html
