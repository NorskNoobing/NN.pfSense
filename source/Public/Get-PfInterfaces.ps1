function Get-PfInterfaces {
    [CmdletBinding()]
    param (
        
    )

    process {
        $Splat = @{
            "Uri" = "$(Get-PfEndpoint)/api/v1/interface"
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