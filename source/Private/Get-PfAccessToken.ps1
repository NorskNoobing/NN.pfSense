function Get-PfAccessToken {
    [CmdletBinding()]
    param (
        [string]$AccessTokenPath = "$env:USERPROFILE\.creds\pfSense\pfSenseAccessToken.xml"
    )

    process {
        if (!(Test-Path $AccessTokenPath)) {
            New-PfAccessToken
        }
        
        $Cred = (Import-Clixml $AccessTokenPath).GetNetworkCredential()

        #Encode credentials to Base64
        $Text = "$($Cred.Username):$($Cred.Password)"
        $Bytes = [Text.Encoding]::UTF8.GetBytes($Text)
        [Convert]::ToBase64String($Bytes)
    }
}