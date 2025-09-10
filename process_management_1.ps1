# Lists every process for which ProcessName starts with "C"
Get-Process | Where-Object {$_.ProcessName -ilike "C*"}

# Lists every process for which the path does not include the string "system32"
Get-Process | Where-Object {$_.ProcessName -notlike "*system32*"}

# Lists every stopped service, orders it alphabetically, and saves it to a csv file
Get-Service | Where-Object {$_.Status -eq "Stopped"} | Sort-Object Name | 
Export-Csv -Path "C:\Users\Olivia\Desktop\stopped_services.csv"

# If not running already, starts Google Chrome web browser and directs it to Champlain.edu
# If an instance is already running, stops it
if (Get-Process -Name "chrome.exe") {
    Stop-Process -Name "chrome.exe" -Force
}
else {
    Start-Process "chrome.exe" "https://champlain.edu"}