. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1  - List Enabled Users`n"
$Prompt += "2  - List Disabled Users`n"
$Prompt += "3  - Create a User`n"
$Prompt += "4  - Remove a User`n"
$Prompt += "5  - Enable a User`n"
$Prompt += "6  - Disable a User`n"
$Prompt += "7  - Get Log-In Logs`n"
$Prompt += "8  - Get Failed Log-In Logs`n"
$Prompt += "9  - List at Risk Users `n"
$Prompt += "10 - Exit`n"


$operation = $true


while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }


    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }


    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3) { 
        
        $name = Read-Host -Prompt "Please enter the username for the new user"
        
        if(checkUser $name) {
            
            Write-Host "That user already exists"
            Write-Host "Please try again with a different username"

        } else {

            $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"

            if(-not (checkPassword $password)) {

                Write-Host "Please try again with a different password"

            } else {

                createAUser $name $password
                Write-Host "User: $name is created" -ForegroundColor Green
            }
        }
    }


    # Remove a user
    elseif($choice -eq 4) {

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"
        
        if(-not (checkUser $name)) {
            
            Write-Host "That user does not exist"
            Write-Host "Please try again with a different username"

        } else {

            removeAUser $name
            Write-Host "User: $name removed" 
        
        }
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        if(-not (checkUser $name)) {
            
            Write-Host "That user does not exist"
            Write-Host "Please try again with a different username"

        } else {
            
            enableAUser $name
            Write-Host "User: $name Enabled" 
            
        }
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        if(-not (checkUser $name)) {
            
            Write-Host "That user does not exist"
            Write-Host "Please try again with a different username"

        } else {
            
            disableAUser $name
            Write-Host "User: $name Disabled" 
            
        }
    }


    # Get login logs
    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        # TODO: Check the given username with the checkUser function.

        if(-not (checkUser $name)) {
            
            Write-Host "That user does not exist"
            Write-Host "Please try again with a different username"

        } else {
            
            $days = Read-Host "Enter number of days"
            $userLogins = getLogInAndOffs $days

            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)

        }
    }


    # Get failed login logs
    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        if(-not (checkUser $name)) {
            
            Write-Host "That user does not exist"
            Write-Host "Please try again with a different username"

        } else {
            
            $days = Read-Host "Enter number of days"
            $userLogins = getFailedLogins $days

            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)

        }
    }


    # List at-risk users
    elseif($choice -eq 9) {
        
        $days = Read-Host "Enter number of days to check for failed logins"

        $days = [int]$days

        $startDate = (Get-Date).AddDays(-$days)

        $failedLogins = Get-WinEvent -FilterHashtable @{LogName = 'Security'
                                                        ID = 4625
                                                        StartTime = $startDate
                                                        } -ErrorAction SilentlyContinue

        $userLogins = $failedLogins | 
                      ForEach-Object {$xml = [xml]$_.ToXml()
                                      $username = $xml.Event.EventData.Data | 
                                                  Where-Object {$_.Name -eq 'TargetUserName'} | 
                                                  Select-Object -ExpandProperty '#text'
                                      [PSCustomObject]@{Username = $username}
                                      } | 
                      Group-Object Username | Select-Object Name, Count

        # Identify users with more than 10 failed logins
        $atRiskUsers = $userLogins | Where-Object {$_.Count -gt 10} | Sort-Object Count -Descending

        # Show results
        if ($atRiskUsers.Count -eq 0) {
            Write-Host "No users found with more than 10 failed logins in the last $days days." -ForegroundColor Green
        } else {
            Write-Host "Users with more than 10 failed logins in the last $days days:" -ForegroundColor Red
            $atRiskUsers | Format-Table @{Label="Username";Expression={$_.Name}}, @{Label="Failed Login Count";Expression={$_.Count}} -AutoSize
        }
    }


    # Invalid menu selection
    else {
    
        Write-Host "$choice is not a valid menu selection"
        Write-Host "Please select a number 1-10 from the menu"
    
    }
}
