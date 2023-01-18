function New-PfEndpoint {
    [CmdletBinding()]
    param (
        $EndpointPath = "$env:USERPROFILE\.creds\pfSense\pfSenseEndpoint.xml"
    )

    process {
        #Create parent folders for the endpoint file
        $EndpointDir = $EndpointPath.Substring(0, $EndpointPath.lastIndexOf('\'))
        if (!(Test-Path $EndpointDir)) {
            $null = New-Item -ItemType Directory $EndpointDir
        }

        $IP = Read-Host "Enter the IP of your pfSense install (including http:// or https://)" -AsSecureString
        $IP | Export-Clixml $EndpointPath
    }
}