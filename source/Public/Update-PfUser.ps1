function Update-PfUser {
    [CmdletBinding()]
    param (
        [string]$authorizedkeys,
        [array]$cert,
        [string]$decr,
        [string][ValidateSet("true","false")]$disabled = "false",
        [string]$expires,
        [string]$ipsecpsk,
        [string]$password,
        [array]$priv,
        [string]$username
    )

    process {
        $Uri = "$(Get-PfEndpoint)/api/v1/user"
        #Parameters to exclude in Uri build
        $ParameterExclusion = @()
        #Build request Uri
        $PSBoundParameters.Keys.ForEach({
            [string]$Key = $_
            [string]$Value = $PSBoundParameters.$key
        
            #Check if parameter is excluded
            if ($ParameterExclusion -contains $Key) {
                return
            }
        
            #Check for "?" in Uri and set delimiter
            if (!($Uri -replace "[^?]+")) {
                $Delimiter = "?"
            } else {
                $Delimiter = "&"
            }
        
            $Uri = "$Uri$Delimiter$Key=$Value"
        })

        $Splat = @{
            "Uri" = $Uri
            "Method" = "POST"
            "Headers" = @{
                "Accept" = "application/json"
                "Content-Type" = "application/json"
                "Authorization" = "Basic $(Get-PfAccessToken)"
            }
        }
        Invoke-RestMethod @Splat
    }
}