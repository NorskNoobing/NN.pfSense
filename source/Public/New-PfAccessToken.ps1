function New-PfAccessToken {
    param (
        [string]$AccessTokenPath = "$env:USERPROFILE\.creds\pfSense\pfSenseAccessToken.xml"
    )

    process {
        while (!$Username) {
            $Username = Read-Host "Enter pfSense username"
        }
    
        while (!$Passwd) {
            $Passwd = Read-Host "Enter pfSense password" -AsSecureString
        }
    
        $AccessTokenDir = $AccessTokenPath.Substring(0, $AccessTokenPath.LastIndexOf('\'))
        if (!(Test-Path $AccessTokenDir)) {
            #Create parent folders of the access token file
            $null = New-Item -ItemType Directory $AccessTokenDir
        }
    
        #Create access token file
        New-Object PSCredential($Username,$Passwd) | Export-Clixml $AccessTokenPath
    }
}