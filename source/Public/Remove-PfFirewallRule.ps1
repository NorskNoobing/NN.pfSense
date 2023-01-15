function Remove-PfFirewallRule {
    [CmdletBinding()]
    param (
        [int]$tracker,
        [ValidateSet("true","false")][string]$apply
    )

    process {
        $Uri = "$(Get-PfEndpoint)/api/v1/firewall/rule"
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
            "Method" = "DELETE"
            "Headers" = @{
                "Accept" = "application/json"
                "Content-Type" = "application/json"
                "Authorization" = "Basic $(Get-PfAccessToken)"
            }
        }
        Invoke-RestMethod @Splat
    }
}