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

  .Example
   Add-ModulesToBlobStorage -ResourceGroupName 'MyResourceGroup' -StorageAccountName 'MyStorageAccount' -ContainerName 'MyContainer'
#>
function Add-ModulesToBlobStorage
{
    [CmdletBinding()]
    param
    (
        # [Parameter(Mandatory = $true)]
        # [System.String]
        # $SubscriptionName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $StorageAccountName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $ContainerName
    )

    Write-LogEntry -Message 'Upload Microsoft365DSC module dependencies to storage container'

    Write-LogEntry -Message "Connecting to storage account '$StorageAccountName'" -Level 1
    $storageAcc = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName

    Write-LogEntry -Message 'Retrieving storage account context' -Level 1
    $context = $storageAcc.Context

    Write-LogEntry -Message 'Checking dependencies'
    $m365Module = Get-Module -Name Microsoft365DSC -ListAvailable | Sort-Object -Property Version -Descending | Select-Object -First 1
    $modulePath = Split-Path -Path $m365Module.Path -Parent

    $versionString = $m365Module.Version.ToString() -replace '\.', '_'

    $dependenciesPath = Join-Path -Path $modulePath -ChildPath 'Dependencies\Manifest.psd1'

    if (Test-Path -Path $dependenciesPath)
    {
        Write-LogEntry -Message 'Downloading dependencies' -Level 1

        $savePath = Join-Path -Path $env:TEMP -ChildPath 'M365DSCModules'
        if ((Test-Path -Path $savePath) -eq $false)
        {
            $null = New-Item -Path $savePath -ItemType 'Directory'
        }

        Write-LogEntry -Message ('Saving module {0} (v{1})' -f $m365Module.Name, $m365Module.Version.ToString()) -Level 1
        Save-Module -Name $m365Module.Name -RequiredVersion $m365Module.Version.ToString() -Path $savePath

        $data = Import-PowerShellDataFile -Path $dependenciesPath
        foreach ($dependency in $data.Dependencies)
        {
            Write-LogEntry -Message ('Saving module {0} (v{1})' -f $dependency.ModuleName, $dependency.RequiredVersion) -Level 1
            Save-Module -Name $dependency.ModuleName -RequiredVersion $dependency.RequiredVersion -Path $savePath
        }

        Write-LogEntry -Message 'Packaging Zip file' -Level 1
        $zipFileName = "M365DSCDependencies-$versionString.zip"
        $zipFilePath = Join-Path -Path $env:TEMP -ChildPath $zipFileName
        if ((Test-Path -Path $zipFilePath))
        {
            Write-LogEntry -Message "$zipFileName already exist on disk. Removing!" -Level 1
            Remove-Item -Path $zipFilePath -Confirm:$false
        }
        Compress-Archive -Path $savePath\* -DestinationPath $zipFilePath

        Write-LogEntry -Message 'Uploading Zip file' -Level 1
        $blobContent = Get-AzStorageBlob -Container $ContainerName -Context $context -Prefix $zipFileName
        if ($null -ne $blobContent)
        {
            Write-LogEntry -Message "$zipFileName already exist in the Blob Storage. Removing!" -Level 2
            $blobContent | Remove-AzStorageBlob
        }
        $null = Set-AzStorageBlobContent -Container $ContainerName -File $zipFilePath -Context $context -Force

        Write-LogEntry -Message 'Removing temporary components'
        Remove-Item -Path $savePath -Recurse -Confirm:$false -Force
        Remove-Item -Path $zipFilePath -Confirm:$false
    }
    else
    {
        Write-LogEntry -Message '[ERROR] Dependencies\Manifest.psd1 file not found'
    }
}
