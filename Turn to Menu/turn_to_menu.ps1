. (Join-Path $PSScriptRoot parsing_apache_logs.ps1)  # For ApacheLogs1
. (Join-Path $PSScriptRoot Event-Logs.ps1)           # For getFailedLogins
. (Join-Path $PSScriptRoot Users.ps1)                # For getAtRiskUsers
. (Join-Path $PSScriptRoot process_management_1.ps1) # For startChrome

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display last 10 apache logs`n"
$Prompt += "2 - Display last 10 failed logins for all users`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Start Chrome web browser and navigate it to champlain.edu`n"
$Prompt += "5 - Exit`n"


$operation = $true


while($operation) {
    
    Write-Host $Prompt
    $choice = Read-Host

    # Exit
    if($choice -eq 5) {
        
        Write-Host "Exiting"
        exit
        $operation = $false 
    
    }


    # Display last 10 apache logs
    elseif($choice -eq 1) {
        
        $tableRecords = ApacheLogs1 | Select-Object -Last 10
        $tableRecords | Format-Table -AutoSize -Wrap

    }


    # Display last 10 failed logins for all users
    elseif($choice -eq 2) {
        
        $userLogins = getFailedLogins 30 | Select-Object -Last 10
        $userLogins | Format-Table -AutoSize -Wrap
        

    }


    # Display at risk users
    elseif($choice -eq 3) { 
        
        getAtRiskUsers 30

    }


    # Start Chrome web browser and navigate it to champlain.edu
    elseif($choice -eq 4) {
        
        startChrome

    }


    # Invalid menu selection
    else {
    
        Write-Host "$choice is not a valid menu selection"
        Write-Host "Please select a number 1-10 from the menu"
    
    }
}
