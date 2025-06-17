$DSC_Workloads = @{
    'AzureAD'            = 'AAD'
    'AzureDevOps'        = 'ADO'
    'Azure'              = 'Azure'
    'Commerce'           = 'Commerce'
    'Defender'           = 'Defender'
    'Exchange'           = 'EXO'
    'Fabric'             = 'Fabric'
    'Intune'             = 'Intune'
    'Office365'          = 'O365'
    'OneDrive'           = 'OD'
    'Planner'            = 'Planner'
    'PowerPlatform'      = 'PP'
    'SecurityCompliance' = 'SC'
    'Sentinel'           = 'Sentinel'
    'ServicesHub'        = 'SH'
    'SharePoint'         = 'SPO'
    'Teams'              = 'Teams'
    'Viva'               = 'Viva'
}

function Convert-M365WorkloadName
{
<#
 .Synopsis
  Converts a M365 workload name to a short name

 .Description
  This function converts a M365 workload name to a short name.
  For example AzureAD to AAD.

 .Parameter Name
  The Name that needs to be converted

 .Example
   Convert-M365WorkloadName -Name 'AzureAD'
#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeLine = $True)]
        [string]
        $Name
    )

    process
    {
        if ($DSC_Workloads.keys -contains $Name)
        {
            return ($DSC_Workloads[$Name])
        }
    }
}
