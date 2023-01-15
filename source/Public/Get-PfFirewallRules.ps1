function Get-PfFirewallRules {
    [CmdletBinding()]
    param (
        
    )

    process {
        $Uri = "$(Get-PfEndpoint)/api/v1/firewall/rule"
        $Splat = @{
            "Uri" = $Uri
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