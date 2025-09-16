.(Join-Path $PSScriptRoot "functions_and_event_logs.ps1")

clear

# Get Login and Logoffs from the last 25 days
$loginoutsTable = Get-Loginouts(25)

# Get Shutdowns from the last 25 days
$shutdownsTable = Get-Shutdowns(25)

# Get Startups from the last 25 days
$startupsTable = Get-Startups(25)

$eventsTable = $loginoutsTable + $shutdownsTable + $startupsTable
$eventsTable | Sort-Object Time -Descending | Format-Table