function Update-PfUser {
    [CmdletBinding()]
    param (
        [string]$authorizedkeys,
        [array]$cert,
        [string]$decr,
        [string][ValidateSet("true","false")]$disabled,
        [string]$expires,
        [string]$ipsecpsk,
        [string]$password,
        [array]$priv,
        [Parameter(Mandatory)][string]$username
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
            "Uri" = "$(Get-PfEndpoint)/api/v1/user"
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