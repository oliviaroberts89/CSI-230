# If not running already, starts Google Chrome web browser and directs it to Champlain.edu
# If an instance is already running, stops it
if (Get-Process -Name "chrome.exe") {
    Stop-Process -Name "chrome.exe" -Force
}
else {
    Start-Process "chrome.exe" "https://champlain.edu"}