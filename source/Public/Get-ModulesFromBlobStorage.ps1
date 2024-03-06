function Get-ModulesFromBlobStorage
{
<#
.SYNOPSIS
    Downloads all Microsoft365DSC dependencies from an Azure Blob Storage

.DESCRIPTION
    This function downloads the zipped dependency modules corresponding to the
    required Microsoft365DSC version from an Azure Blob Storage, if available.
    The dependencies are then unzipped and copied to the PowerShell Modules folder.

.PARAMETER ResourceGroupName
    The Azure Resource Group Name where the Storage Account is located

.PARAMETER StorageAccountName
    The name of the Storage Account where the zip file will be downloaded from

.PARAMETER ContainerName
    The name of the Container where the zip file will be downloaded from

.PARAMETER Version
    The version of the Microsoft365DSC module for which the prerequisites should be retrieved

.EXAMPLE
    Get-ModulesFromBlobStorage -ResourceGroupName 'MyResourceGroup' -StorageAccountName 'MyStorageAccount' -ContainerName 'MyContainer' -Version 1.23.530.1
#>
    [CmdletBinding()]
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

    Write-Log -Object "Download dependencies from storage container for Microsoft365DSC v$Version."

    Write-Log -Object "Connecting to storage account '$StorageAccountName'"
    $storageAcc = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName

    Write-Log -Object 'Retrieving storage account context'
    $context = $storageAcc.Context

    Write-Log -Object 'Checking download folder existence'
    $destination = Join-Path -Path $env:TEMP -ChildPath 'M365DSCModules'
    if ((Test-Path -Path $destination) -eq $false)
    {
        Write-Log -Object "Creating destination folder: '$destination'"
        $null = New-Item -ItemType Directory -Path $destination
    }

    Write-Log -Object 'Downloading blob contents from the container'
    $prefix = 'M365DSCDependencies-' + ($Version -replace '\.', '_')
    $blobContent = Get-AzStorageBlob -Container $ContainerName -Context $context -Prefix $prefix

    if ($null -eq $blobContent)
    {
        Write-Log -Object "[ERROR] No files found that match the pattern: '$prefix'"
    }
    else
    {
        Write-Log -Object "Downloading $($blobContent.Name) to $destination"
        $downloadFile = Join-Path -Path $destination -ChildPath $blobContent.Name
        if (Test-Path -Path $downloadFile)
        {
            Write-Log -Object "$downloadFile already exists. Removing!"
            Remove-Item -Path $downloadFile -Confirm:$false
        }
        $null = Get-AzStorageBlobContent -Container $ContainerName -Context $context -Blob $blobContent.Name -Destination $destination -Force

        Write-Log -Object "Extracting $($blobContent.Name)"
        $extractPath = Join-Path -Path $destination -ChildPath $Version.ToString()
        if (Test-Path -Path $extractPath)
        {
            Write-Log -Object "$extractPath already exists. Removing!"
            Remove-Item -Path $extractPath -Recurse -Confirm:$false
        }
        Expand-Archive -Path $downloadFile -DestinationPath $extractPath

        Write-Log -Object "Copying modules in $extractPath to 'C:\Program Files\WindowsPowerShell\Modules'"
        $downloadedModules = Get-ChildItem -Path $extractPath -Directory -ErrorAction SilentlyContinue
        foreach ($module in $downloadedModules)
        {
            $PSModulePath = Join-Path -Path "$($env:ProgramFiles)/WindowsPowerShell/Modules" -ChildPath $module.Name
            if (Test-Path -Path $PSModulePath)
            {
                Write-Log -Object "Removing existing module $($module.Name)"
                Remove-Item -Include '*' -Path $PSModulePath -Recurse -Force
            }

            Write-Log -Object "Deploying module $($module.Name)"
            $modulePath = Join-Path -Path $extractPath -ChildPath $module.Name
            $PSModulesPath = Join-Path -Path "$($env:ProgramFiles)/WindowsPowerShell" -ChildPath 'Modules'
            Copy-Item -Path $modulePath -Destination $PSModulesPath -Recurse -Container -Force
        }

        Write-Log -Object 'Removing temporary components'
        Remove-Item -Path $extractPath -Recurse -Confirm:$false
        Remove-Item -Path $destination -Recurse -Confirm:$false
    }
}
