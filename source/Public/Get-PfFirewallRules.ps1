function Get-PfFirewallRules {
    [CmdletBinding()]
    param (
        
    )

    process {
        $Splat = @{
            "Uri" = "$(Get-PfEndpoint)/api/v1/firewall/rule"
            "Method" = "GET"
            "Headers" = @{
                "Accept" = "application/json"
                "Content-Type" = "application/json"
                "Authorization" = "Basic $(Get-PfAccessToken)"
            }
        }
        Invoke-RestMethod @Splat
    }
}