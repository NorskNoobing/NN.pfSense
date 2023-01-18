function Update-PfInterface {
    [CmdletBinding()]
    param (
        [ValidateSet("true","false")][string]$adv_dhcp_config_advanced,
        [ValidateSet("true","false")][string]$adv_dhcp_config_file_override,
        [string]$adv_dhcp_config_file_override_file,
        [string]$adv_dhcp_option_modifiers,
        [int]$adv_dhcp_pt_backoff_cutoff,
        [int]$adv_dhcp_pt_initial_interval,
        [int]$adv_dhcp_pt_reboot,
        [int]$adv_dhcp_pt_retry,
        [int]$adv_dhcp_pt_select_timeout,
        [int]$adv_dhcp_pt_timeout,
        [string]$adv_dhcp_request_options,
        [string]$adv_dhcp_required_options,
        [string]$adv_dhcp_send_options,
        [string]$alias_address,
        [string]$alias_subnet,
        [ValidateSet("true","false")][string]$apply,
        [ValidateSet("true","false")][string]$blockbogons,
        [ValidateSet("true","false")][string]$blockpriv,
        [string]$descr,
        [int]$dhcpcvpt,
        [string]$dhcphostname,
        [array]$dhcprejectfrom,
        [ValidateSet("true","false")][string]$dhcpvlanenable,
        [ValidateSet("true","false")][string]$enable,
        [string]$gateway,
        [string]$gateway_6rd,
        [string]$gatewayv6,
        [Parameter(Mandatory)][string]$id,
        [string]$if,
        [string]$ipaddr,
        [string]$ipaddrv6,
        [ValidateSet("true","false")][string]$ipv6usev4iface,
        [string]$media,
        [string]$mss,
        [int]$mtu,
        [string]$prefix_6rd,
        [string]$prefix_6rd_v4plen,
        [string]$spoofmac,
        [int]$subnet,
        [string]$subnetv6,
        [string]$track6_interface,
        [int]$track6_prefix_id_hex,
        [string]$type,
        [string]$type6
    )

    process {
        #Parameters to convert with dashes
        $DashParameters = @(
            "alias_address","alias_subnet","gateway_6rd","prefix_6rd",
            "prefix_6rd_v4plen","track6_interface","track6_prefix_id_hex"
        )

        $ParameterExclusion = @()
        $Body = $null
        $PSBoundParameters.Keys.ForEach({
            [string]$Key = $_
            $Value = $PSBoundParameters.$key

            if ($ParameterExclusion -contains $Key) {
                return
            }

            if ($DashParameters -contains $Key) {
                $Key = $Key -replace "_","-"
            }

            $Body = $Body + @{
                $Key = $Value
            }
        })

        $Splat = @{
            "Uri" = "$(Get-PfEndpoint)/api/v1/interface"
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