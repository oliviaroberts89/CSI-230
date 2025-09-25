# List all of the apache logs of xampp
Get-Content C:\xampp\apache\logs\access.log

clear

# List only the last 5 apache logs
Get-Content C:\xampp\apache\logs\access.log -Head 5

clear

# Display only logs that contain 404 (Not Found) or 400 (Bad Request)
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ', ' 400 '

clear

# Display only logs that contain 404 (Not Found) or 400 (Bad Request)
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 ' -NotMatch

clear

# From every .log file in the directory, only get logs that contain the word 'error'
$A = Get-ChildItem -Path C:\xampp\apache\logs\*.log | Select-String -Pattern 'error'
# Display last 5 elements of the result array
$A[-5..-1] # I ONLY HAVE 4 ERRORS TOTAL SO

clear

#####################################################################################

# Get only logs that contain 404, save into $notfounds
$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 '
$notfounds

# Define a regex for for IP addresses
$regex = [regex] "\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b"
$regex

# Get $notfounds records that match to the regex
$ipsUnorganized = $regex.Matches($notfounds)
$ipsUnorganized

# Get ips as pscustomobject
$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++){
    $ips += [PSCustomObject]@{ "IP" = $ipsUnorganized[$i].Value; }
}
$ips | where-Object { $_.IP -ilike "10.*" }

clear

# Count ips from number 8
$ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
$counts = $ipsoftens | Group-Object -Property IP
$counts | Select-Object Count, Name
