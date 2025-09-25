# Write a function that will take 3 inputs: 
# The page visited or referred from, HTTP code returned, and the name of the web browser.

# It will give 1 output:
# IP addresses that have visited the given page or referred from, with the given web browser, 
# and got the fiven HTTP response

$LogPath = "C:\xampp\apache\logs\access.log"

parsing_apache_logs.ps1.ApacheLogs1()

function Get-IPs(page; http; browser){
    $logEntries = Get-Content $LogPath
    
    matchingIPs = @()
    
    foreach ($entry in $logEntries) {
        for ($i = 0; $i -lt $entry.Length; $i++){

        }
    }
}