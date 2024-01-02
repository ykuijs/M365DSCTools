function Add-ModulesToBlobStorage
{
    <#
.SYNOPSIS
    Downloads all Microsoft365DSC dependencies and uploads these to an Azure Blob Storage

.DESCRIPTION
    This function checks which dependencies the used version of Microsoft365DSC
    requires and downloads these from the PowerShell Gallery. The dependencies
    are then packaged into a zip file and uploaded to an Azure Blob Storage.

.PARAMETER ResourceGroupName
    The Azure Resource Group Name where the Storage Account is located

.PARAMETER StorageAccountName
    The name of the Storage Account where the zip file will be uploaded to

.PARAMETER ContainerName
    The name of the Container where the zip file will be uploaded to

.EXAMPLE
    Add-ModulesToBlobStorage -ResourceGroupName 'MyResourceGroup' -StorageAccountName 'MyStorageAccount' -ContainerName 'MyContainer'
#>
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

    $script:level++
    Write-LogEntry -Message 'Upload Microsoft365DSC module dependencies to storage container' -Level $script:level

    $script:level++
    Write-LogEntry -Message "Connecting to storage account '$StorageAccountName'" -Level $script:level
    $storageAcc = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName

    Write-LogEntry -Message 'Retrieving storage account context' -Level $script:level
    $context = $storageAcc.Context

    Write-LogEntry -Message 'Checking dependencies' -Level $script:level
    $m365Module = Get-Module -Name Microsoft365DSC -ListAvailable | Sort-Object -Property Version -Descending | Select-Object -First 1
    $modulePath = Split-Path -Path $m365Module.Path -Parent

    $versionString = $m365Module.Version.ToString() -replace '\.', '_'

    $dependenciesPath = Join-Path -Path $modulePath -ChildPath 'Dependencies\Manifest.psd1'

    if (Test-Path -Path $dependenciesPath)
    {
        Write-LogEntry -Message 'Downloading dependencies' -Level $script:level
        $script:level++

        $destination = Join-Path -Path $env:TEMP -ChildPath 'M365DSCModules'
        $savePath = Join-Path -Path $destination -ChildPath $m365Module.Version.ToString()
        if (Test-Path -Path $savePath)
        {
            Write-LogEntry -Message "$savePath already exists. Removing!" -Level $script:level
            Remove-Item -Path $savePath -Recurse -Confirm:$false
        }
        $null = New-Item -Path $savePath -ItemType 'Directory'

        Write-LogEntry -Message ('Saving module {0} (v{1})' -f $m365Module.Name, $m365Module.Version.ToString()) -Level $script:level
        Save-Module -Name $m365Module.Name -RequiredVersion $m365Module.Version.ToString() -Path $savePath

        $data = Import-PowerShellDataFile -Path $dependenciesPath
        foreach ($dependency in $data.Dependencies)
        {
            Write-LogEntry -Message ('Saving module {0} (v{1})' -f $dependency.ModuleName, $dependency.RequiredVersion) -Level $script:level
            Save-Module -Name $dependency.ModuleName -RequiredVersion $dependency.RequiredVersion -Path $savePath
        }
        $script:level--

        Write-LogEntry -Message 'Packaging Zip file' -Level $script:level
        $zipFileName = "M365DSCDependencies-$versionString.zip"
        $zipFilePath = Join-Path -Path $env:TEMP -ChildPath $zipFileName
        if ((Test-Path -Path $zipFilePath))
        {
            $script:level++
            Write-LogEntry -Message "$zipFileName already exist on disk. Removing!" -Level $script:level
            Remove-Item -Path $zipFilePath -Confirm:$false
            $script:level--
        }
        Compress-Archive -Path $savePath\* -DestinationPath $zipFilePath

        Write-LogEntry -Message 'Uploading Zip file' -Level $script:level
        $blobContent = Get-AzStorageBlob -Container $ContainerName -Context $context -Prefix $zipFileName
        if ($null -ne $blobContent)
        {
            $script:level++
            Write-LogEntry -Message "$zipFileName already exist in the Blob Storage. Removing!" -Level $script:level
            $blobContent | Remove-AzStorageBlob
            $script:level--
        }
        $null = Set-AzStorageBlobContent -Container $ContainerName -File $zipFilePath -Context $context -Force

        Write-LogEntry -Message 'Removing temporary components' -Level $script:level
        Remove-Item -Path $savePath -Recurse -Confirm:$false -Force
        Remove-Item -Path $zipFilePath -Confirm:$false
    }
    else
    {
        Write-LogEntry -Message '[ERROR] Dependencies\Manifest.psd1 file not found' -Level $script:level
    }
    $script:level--
    $script:level--
}
