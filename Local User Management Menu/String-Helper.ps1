<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}


function checkPassword($password) {
    
    # Convert SecureString to plain text for validation
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
    $plain_password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)

    # Checks if the given string is at least 6 characters
    if ($plain_password.Length -lt 6) {
        Write-Host "Your password is invalid. It needs to be atleast 6 characters" -ForegroundColor Red
        return $false
    }

    # Checks if the given string contains at least 1 special character
    if ($plain_password -notmatch '[^a-zA-Z0-9]') {
        Write-Host "Your password is invalid. It needs atleast one special character" -ForegroundColor Red
        return $false
    }

    # Check if password contains at least 1 number
    if ($plain_password -notmatch '\d') {
        Write-Host "Your password is invalid. It needs atleast one number" -ForegroundColor Red
        return $false
    }

    # Check if password contains at least 1 letter
    if ($plain_password -notmatch '[a-zA-Z]') {
        Write-Host "Your password is invalid. It needs atleast one letter" -ForegroundColor Red
        return $false
    }
    
    # All conditions satisfied
    Write-Host "Password is valid" -ForegroundColor Green
    return $true
}