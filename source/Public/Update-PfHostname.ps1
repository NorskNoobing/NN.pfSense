function Update-PfHostname {
    [CmdletBinding()]
    param (
        [string]$domain,
        [Parameter(Mandatory)][string]$hostname
    )

    process {
        $Uri = "$(Get-PfEndpoint)/api/v1/system/hostname"
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