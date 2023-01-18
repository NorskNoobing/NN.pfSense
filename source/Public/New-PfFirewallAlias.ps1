function New-PfFirewallAlias {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][string]$name,
        [Parameter(Mandatory)][ValidateSet("host","network","port")][string]$type,
        [Parameter(Mandatory)][array]$address,
        [string]$descr,
        [array]$detail,
        [ValidateSet("true","false")][string]$apply
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
            "Uri" = "$(Get-PfEndpoint)/api/v1/firewall/alias"
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