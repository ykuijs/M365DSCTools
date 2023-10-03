<#
 .Synopsis
  Downloads all Microsoft365DSC dependencies and uploads these to an Azure Blob Storage

 .Description
  This function checks which dependencies the used version of Microsoft365DSC
  requires and downloads these from the PowerShell Gallery. The dependencies
  are then packaged into a zip file and uploaded to an Azure Blob Storage.

 .Parameter ResourceGroupName
  The Azure Resource Group Name where the Storage Account is located

 .Parameter StorageAccountName
  The name of the Storage Account where the zip file will be uploaded to

  .Parameter ContainerName
  The name of the Container where the zip file will be uploaded to

  .Parameter Version
  The version of Microsoft365DSC for which the prerequisites should be retrieved

  .Example
   Get-ModulesFromBlobStorage -ResourceGroupName 'MyResourceGroup' -StorageAccountName 'MyStorageAccount' -ContainerName 'MyContainer' -Version 1.23.530.1
#>
function Get-ModulesFromBlobStorage
{
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

    Write-LogEntry -Message "Download dependencies from storage container. M365DSC Version $Version." -Level 2

    Write-LogEntry -Message "Connecting to storage account '$StorageAccountName'" -Level 3
    $storageAcc = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName

    Write-LogEntry -Message 'Retrieving storage account context' -Level 3
    $context = $storageAcc.Context

    Write-LogEntry -Message 'Checking download folder existence' -Level 3
    $destination = Join-Path -Path $env:TEMP -ChildPath 'M365DSCModules'
    if ((Test-Path -Path $destination) -eq $false)
    {
        Write-LogEntry -Message "Creating destination folder: '$destination'" -Level 4
        $null = New-Item -ItemType Directory -Path $destination
    }

    Write-LogEntry -Message 'Downloading the blob contents from the container' -Level 2
    $prefix = 'M365DSCDependencies-' + ($version -replace '\.', '_')
    $blobContent = Get-AzStorageBlob -Container $ContainerName -Context $context -Prefix $prefix

    if ($null -eq $blobContent)
    {
        Write-LogEntry -Message "[ERROR] No files found that match the pattern: '$prefix'" -Level 2
    }
    else
    {
        Write-LogEntry -Message "Downloading $($blobContent.Name) to $destination" -Level 3
        $downloadFile = Join-Path -Path $destination -ChildPath $blobContent.Name
        if (Test-Path -Path $downloadFile)
        {
            Write-LogEntry -Message "$downloadFile already exists. Removing!" -Level 3
            Remove-Item -Path $downloadFile -Confirm:$false
        }
        $null = Get-AzStorageBlobContent -Container $ContainerName -Context $context -Blob $blobContent.Name -Destination $destination -Force

        Write-LogEntry -Message "Extracting $($blobContent.Name)" -Level 2
        $extractPath = Join-Path -Path $destination -ChildPath $Version.ToString()
        if (Test-Path -Path $extractPath)
        {
            Write-LogEntry -Message "$extractPath already exists. Removing!" -Level 3
            Remove-Item -Path $extractPath -Recurse -Confirm:$false
        }
        Expand-Archive -Path $downloadFile -DestinationPath $extractPath

        Write-LogEntry -Message "Copying folders in $extractPath to 'C:\Program Files\WindowsPowerShell\Modules'" -Level 2
        Copy-Item -Path "$extractPath\*" -Destination 'C:\Program Files\WindowsPowerShell\Modules' -Recurse -Container -Force

        Write-LogEntry -Message 'Removing temporary components' -Level 2
        Remove-Item -Path $extractPath -Recurse -Confirm:$false
        Remove-Item -Path $destination -Recurse -Confirm:$false
    }
}
