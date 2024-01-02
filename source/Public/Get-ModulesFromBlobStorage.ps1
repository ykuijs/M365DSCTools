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

    $script:level++
    Write-LogEntry -Message "Download dependencies from storage container for Microsoft365DSC v$Version." -Level $script:level

    $script:level++
    Write-LogEntry -Message "Connecting to storage account '$StorageAccountName'" -Level $script:level
    $storageAcc = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName

    Write-LogEntry -Message 'Retrieving storage account context' -Level $script:level
    $context = $storageAcc.Context

    Write-LogEntry -Message 'Checking download folder existence' -Level $script:level
    $destination = Join-Path -Path $env:TEMP -ChildPath 'M365DSCModules'
    if ((Test-Path -Path $destination) -eq $false)
    {
        $script:level++
        Write-LogEntry -Message "Creating destination folder: '$destination'" -Level $script:level
        $null = New-Item -ItemType Directory -Path $destination
        $script:level--
    }

    Write-LogEntry -Message 'Downloading blob contents from the container' -Level $script:level
    $prefix = 'M365DSCDependencies-' + ($Version -replace '\.', '_')
    $blobContent = Get-AzStorageBlob -Container $ContainerName -Context $context -Prefix $prefix

    $script:level++
    if ($null -eq $blobContent)
    {
        Write-LogEntry -Message "[ERROR] No files found that match the pattern: '$prefix'" -Level $script:level
    }
    else
    {
        Write-LogEntry -Message "Downloading $($blobContent.Name) to $destination" -Level $script:level
        $downloadFile = Join-Path -Path $destination -ChildPath $blobContent.Name
        if (Test-Path -Path $downloadFile)
        {
            $script:level++
            Write-LogEntry -Message "$downloadFile already exists. Removing!" -Level $script:level
            Remove-Item -Path $downloadFile -Confirm:$false
            $script:level--
        }
        $null = Get-AzStorageBlobContent -Container $ContainerName -Context $context -Blob $blobContent.Name -Destination $destination -Force

        Write-LogEntry -Message "Extracting $($blobContent.Name)" -Level $script:level
        $extractPath = Join-Path -Path $destination -ChildPath $Version.ToString()
        if (Test-Path -Path $extractPath)
        {
            $script:level++
            Write-LogEntry -Message "$extractPath already exists. Removing!" -Level $script:level
            Remove-Item -Path $extractPath -Recurse -Confirm:$false
            $script:level--
        }
        Expand-Archive -Path $downloadFile -DestinationPath $extractPath

        Write-LogEntry -Message "Copying modules in $extractPath to 'C:\Program Files\WindowsPowerShell\Modules'" -Level $script:level
        $downloadedModules = Get-ChildItem -Path $extractPath -Directory -ErrorAction SilentlyContinue
        foreach ($module in $downloadedModules)
        {
            $script:level++
            $PSModulePath = Join-Path -Path "$($env:ProgramFiles)/WindowsPowerShell/Modules" -ChildPath $module.Name
            if (Test-Path -Path $PSModulePath)
            {
                Write-LogEntry "Removing existing module $($module.Name)" -Level $script:level
                Remove-Item -Include '*' -Path $PSModulePath -Recurse -Force
            }

            Write-LogEntry "Deploying module $($module.Name)" -Level $script:level
            $modulePath = Join-Path -Path $extractPath -ChildPath $module.Name
            $PSModulesPath = Join-Path -Path "$($env:ProgramFiles)/WindowsPowerShell" -ChildPath 'Modules'
            Copy-Item -Path $modulePath -Destination $PSModulesPath -Recurse -Container -Force
            $script:level--
        }

        Write-LogEntry -Message 'Removing temporary components' -Level $script:level
        Remove-Item -Path $extractPath -Recurse -Confirm:$false
        Remove-Item -Path $destination -Recurse -Confirm:$false
    }
    $script:level--
    $script:level--
    $script:level--
}
