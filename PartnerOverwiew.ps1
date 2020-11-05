function Get-TechnicalNotificationEmails {
    [CmdletBinding()]
    param (
    )
    $Tenants = Get-MsolPartnerContract -All -ErrorAction SilentlyContinue

    foreach ($Tenant in $Tenants) {
    $CompanyInfo = Get-MsolCompanyInformation -TenantId $Tenant.TenantId -ErrorAction SilentlyContinue
    [PSCustomObject]@{
    'Name'              = $Tenant.Name
    'TenantId'          = $Tenant.TenantId
    'Technical Email'   = $CompanyInfo.TechnicalNotificationEmails
    }
}
}
function Set-TechnicalNotificationEmails {
    [CmdletBinding()]
    param (
    [Parameter(Mandatory = $true)]
    $TechnicalEmail
    )
    $Tenants = Get-TechincalNotificationEmails
    foreach ($tenant in $Tenants){
    Set-MsolCompanyContactInformation -TenantId $Tenant.TenantId  -TechnicalNotificationEmails $TechincalEmail
    }
}