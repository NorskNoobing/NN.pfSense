function Invoke-PfInterfaceApply {
    [CmdletBinding()]
    param (
        [ValidateSet("true","false")][string]$async
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
            "Uri" = "$(Get-PfEndpoint)/api/v1/interface/apply"
            "Method" = "POST"
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