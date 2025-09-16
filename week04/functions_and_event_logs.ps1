# Get login and logoff records from Windows Events
Get-EventLog system -Source Microsoft-Windows-Winlogon

function Get-Loginouts($numdays) {
    # Get login and logoff records from Windows Events and save to a variable
    $loginouts = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-($numdays))

    $loginoutsTable = @() # Empty array to fill customly
    
    for($i=0; $i -lt $loginouts.Count; $i++) {

        # Creating event property value
        $event = ""
        if($loginouts[$i].InstanceId -eq 7001) {$event="Logon"}
        if($loginouts[$i].InstanceId -eq 7002) {$event="Logoff"}

        #Creating user property value
        $SID = $loginouts[$i].ReplacementStrings[1]
        $SecurityIdentifier = New-Object System.Security.Principal.SecurityIdentifier($SID)
        $username = $SecurityIdentifier.Translate([System.Security.Principal.NTAccount])

        # Adding each new line (in form of a custom object) to our empty array
        $loginoutsTable += [PSCustomObject]@{"Time" = $loginouts[$i].TimeGenerated;
                                             "Id" = $loginouts[$i].InstanceId;
                                             "Event" = $event;
                                             "User" = $username;
                                             }
    }
    return $loginoutsTable
}


function Get-Startups($numdays) {
    # Get login and logoff records from Windows Events and save to a variable
    $startups = Get-EventLog System -After (Get-Date).AddDays(-($numdays)) -Source "EventLog" | Where-Object {$_.EventID -eq 6005}

    $startupsTable = @() # Empty array to fill customly
    
    for($i=0; $i -lt $startups.Count; $i++) {
        # Adding each new line (in form of a custom object) to our empty array
        $startupsTable += [PSCustomObject]@{"Time" = $startups[$i].TimeGenerated;
                                            "Id" = $startups[$i].InstanceId;
                                            "Event" = "Startup";
                                            "User" = "System";
                                            }
    }
    return $startupsTable
}


function Get-Shutdowns($numdays) {
    # Get login and logoff records from Windows Events and save to a variable
    $shutdowns = Get-EventLog System -After (Get-Date).AddDays(-($numdays)) -Source "EventLog" | Where-Object {$_.EventID -eq 6006}

    $shutdownsTable = @() # Empty array to fill customly
    
    for($i=0; $i -lt $shutdowns.Count; $i++) {
        # Adding each new line (in form of a custom object) to our empty array
        $shutdownsTable += [PSCustomObject]@{"Time" = $shutdowns[$i].TimeGenerated;
                                             "Id" = $shutdowns[$i].InstanceId;
                                             "Event" = "Shutdown";
                                             "User" = "System";
                                             }
    }
    return $shutdownsTable
}
