function Get-EnvironmentsGenericInfo
{
<#
.SYNOPSIS
    Returns an overview of the CICD sections of all Generic data files.

.DESCRIPTION
    This function inventories all '<Environment>#Generic.psd1' data files
    and returns this as one hashtable.

    It can be used to generate the pipeline yaml and Azure DevOps
    environments.

.PARAMETER Path
    The path to the environments data files.

.EXAMPLE
    Get-EnvironmentsGenericInfo -Path 'C:\Data\Environments'
#>
    [CmdletBinding()]
    [OutputType([System.Collections.HashTable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Path
    )

    $result = @{}

    if (Test-Path -Path $Path)
    {
        $pattern = '*#Generic.psd1'

        $genericFiles = Get-ChildItem -Path $Path -Filter $pattern -Recurse

        if ($genericFiles.Count -ne 0)
        {
            foreach ($genericFile in $genericFiles)
            {
                $environment = $genericFile.Directory.BaseName
                $genericInfo = Import-PowerShellDataFile -Path $genericFile.FullName
                $result.$environment += @{
                    DependsOn = $genericInfo.NonNodeData.CICD.DependsOn
                    Branch    = $genericInfo.NonNodeData.CICD.UseCodeBranch
                    Approvers = $genericInfo.NonNodeData.CICD.Approvers
                }
            }
        }
        else
        {
            Write-Log -Object "No files found in '$Path' that match the pattern '$pattern'." -Failure
        }
    }
    else
    {
        Write-Log -Object "The path '$Path' does not exist." -Failure
    }

    return $result
}
