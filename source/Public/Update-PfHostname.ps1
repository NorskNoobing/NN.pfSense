function Update-PfHostname {
    [CmdletBinding()]
    param (
        [string]$domain,
        [Parameter(Mandatory)][string]$hostname
    )

    process {
        $ParameterExclusion = @()
        $Body = $null
        $PSBoundParameters.Keys.ForEach({
            [string]$Key = $_
            $Value = $PSBoundParameters.$key
        
            if ($ParameterExclusion -contains $Key) {
                return
            }
        
            $Body = $Body + @{
                $Key = $Value
            }
        })

        $Splat = @{
            "Uri" = "$(Get-PfEndpoint)/api/v1/system/hostname"
            "Method" = "PUT"
            "Headers" = @{
                "Accept" = "application/json"
                "Content-Type" = "application/json"
                "Authorization" = "Basic $(Get-PfAccessToken)"
            }
            "Body" = $Body | ConvertTo-Json -Depth 99
        }
        Invoke-RestMethod @Splat
    }
}