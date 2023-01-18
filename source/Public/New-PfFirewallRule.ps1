function New-PfFirewallRule {
    [CmdletBinding()]
    param (
        [string]$ackqueue,
        [ValidateSet("true","false")][string]$apply,
        [string]$defaultqueue,
        [string]$descr,
        [string]$direction,
        [ValidateSet("true","false")][string]$disabled,
        [string]$dnpipe,
        [string]$dst,
        [string]$dstport,
        [ValidateSet("true","false")][string]$floating,
        [string]$gateway,
        [array]$icmptype,
        [array]$interface,
        [string]$ipprotocol,
        [ValidateSet("true","false")][string]$log,
        [string]$pdnpipe,
        [string]$protocol,
        [ValidateSet("true","false")][string]$quick,
        [string]$sched,
        [string]$src,
        [string]$srcport,
        [string]$statetype,
        [ValidateSet("true","false")][string]$tcpflags_any,
        [array]$tcpflags1,
        [array]$tcpflags2,
        [ValidateSet("true","false")][string]$top,
        [string]$type
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
            "Uri" = "$(Get-PfEndpoint)/api/v1/firewall/rule"
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