function Get-PfEndpoint {
    [CmdletBinding()]
    param (
        $EndpointPath = "$env:USERPROFILE\.creds\pfSense\pfSenseEndpoint.xml"
    )

    process {
        if (!(Test-Path $EndpointPath)) {
            New-PfEndpoint
        }

        $Endpoint = Import-Clixml $EndpointPath
        [System.Runtime.InteropServices.marshal]::PtrToStringAuto([System.Runtime.InteropServices.marshal]::SecureStringToBSTR($Endpoint))
    }
}