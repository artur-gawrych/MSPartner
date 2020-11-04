function Get-TechincalNotificationEmails {
    [CmdletBinding()]
    param (
    )
    $Tenants = Get-MsolPartnerContract -All -ErrorAction SilentlyContinue

    foreach ($Tenant in $Tenants) {
    $CompanyInfo = Get-MsolCompanyInformation -TenantId $Tenant.TenantId -ErrorAction SilentlyContinue
    [PSCustomObject]@{
    'Name'              = $Tenant.Name
    'TenantId'         = $Tenant.TenantId
    'Technical Email'   = $CompanyInfo.TechnicalNotificationEmails
    }
}
}
function Set-TechincalNotificationEmails {
    [CmdletBinding()]
    param (
    [Parameter(Mandatory = $true)]
    $TechincalEmail
    )
    $Tenants = Get-TechincalNotificationEmails
    foreach ($tenant in $Tenants){
    Set-MsolCompanyContactInformation -TenantId $Tenant.TenantId  -TechnicalNotificationEmails $TechincalEmail
    }
}