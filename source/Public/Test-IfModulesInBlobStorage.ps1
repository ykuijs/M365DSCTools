function Test-IfModulesInBlobStorage
{
<#
.SYNOPSIS
    Tests if a package with Microsoft365DSC dependencies exists in an Azure Blob Storage

.DESCRIPTION
    This function tests if the zipped dependency modules corresponding to the
    required Microsoft365DSC version exists in the provided Azure Blob Storage.

.PARAMETER ResourceGroupName
    The Azure Resource Group Name where the Storage Account is located

.PARAMETER StorageAccountName
    The name of the Storage Account where the zip file will be downloaded from

.PARAMETER ContainerName
    The name of the Container where the zip file will be downloaded from

.PARAMETER Version
    The version of the Microsoft365DSC module for which the prerequisites should be tested

.EXAMPLE
    Test-IfModulesInBlobStorage -ResourceGroupName 'MyResourceGroup' -StorageAccountName 'MyStorageAccount' -ContainerName 'MyContainer' -Version 1.23.530.1
#>
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $StorageAccountName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $ContainerName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Version
    )

    Write-Log -Object "Test if dependencies exist in storage container for Microsoft365DSC v$Version."

    Write-Log -Object "Connecting to storage account '$StorageAccountName'"
    $storageAcc = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName

    Write-Log -Object 'Retrieving storage account context'
    $context = $storageAcc.Context

    Write-Log -Object 'Downloading blob contents from the container'
    $prefix = 'M365DSCDependencies-' + ($Version -replace '\.', '_')
    $blobContent = Get-AzStorageBlob -Container $ContainerName -Context $context -Prefix $prefix

    if ($null -eq $blobContent)
    {
        Write-Log -Object "[ERROR] No files found that match the pattern: '$prefix'"
        return $false
    }
    else
    {
        Write-Log -Object "[ERROR] No files found that match the pattern: '$prefix'" -Failure
        return $true
    }
}
