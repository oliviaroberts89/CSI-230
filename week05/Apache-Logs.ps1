# Write a function that will take 3 inputs: 
# The page visited or referred from, HTTP code returned, and the name of the web browser.

# It will give 1 output:
# IP addresses that have visited the given page or referred from, with the given web browser, 
# and got the fiven HTTP response

$LogPath = "C:\xampp\apache\logs\access.log"

function Get-IPs(){
    
    #$logEntries = Get-Content $LogPath
    #$currentLogs = .\.\parsing_apache_logs.ps1

    #return $currentLogs | Where-Object { $_.IP -ilike "10.*" }


    #matchingIPs = @()
    
    #foreach ($entry in $logEntries) {
       # for ($i = 0; $i -lt $entry.Length; $i++){
$currentLogs = ApacheLogs1
#Write-Output($currentLogs)
return $currentLogs | Where-Object 
    { 
      $_.Response -ilike "200" }
    
}

$currentLogs = Get-IPs
$currentLogs | Format-Table -AutoSize -Wrap
