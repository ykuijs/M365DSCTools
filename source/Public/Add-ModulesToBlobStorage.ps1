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
    [OutputType([System.Boolean])]
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

    Write-Log -Object 'Upload Microsoft365DSC module dependencies to storage container'

    Write-Log -Object "Connecting to storage account '$StorageAccountName'"
    $storageAcc = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName

    Write-Log -Object 'Retrieving storage account context'
    $context = $storageAcc.Context

    Write-Log -Object 'Checking dependencies'
    $m365Module = Get-Module -Name Microsoft365DSC -ListAvailable | Sort-Object -Property Version -Descending | Select-Object -First 1
    $modulePath = Split-Path -Path $m365Module.Path -Parent

    $versionString = $m365Module.Version.ToString() -replace '\.', '_'

    $dependenciesPath = Join-Path -Path $modulePath -ChildPath 'Dependencies\Manifest.psd1'

    if (Test-Path -Path $dependenciesPath)
    {
        Write-Log -Object 'Downloading dependencies'

        $destination = Join-Path -Path $env:TEMP -ChildPath 'M365DSCModules'
        $savePath = Join-Path -Path $destination -ChildPath $m365Module.Version.ToString()
        if (Test-Path -Path $savePath)
        {
            Write-Log -Object "$savePath already exists. Removing!"
            Remove-Item -Path $savePath -Recurse -Confirm:$false
        }
        $null = New-Item -Path $savePath -ItemType 'Directory'

        Write-Log -Object ('Saving module {0} (v{1})' -f $m365Module.Name, $m365Module.Version.ToString())
        Save-Module -Name $m365Module.Name -RequiredVersion $m365Module.Version.ToString() -Path $savePath

        $data = Import-PowerShellDataFile -Path $dependenciesPath
        foreach ($dependency in $data.Dependencies)
        {
            Write-Log -Object ('Saving module {0} (v{1})' -f $dependency.ModuleName, $dependency.RequiredVersion)
            Save-Module -Name $dependency.ModuleName -RequiredVersion $dependency.RequiredVersion -Path $savePath
        }

        Write-Log -Object 'Packaging Zip file'
        $zipFileName = "M365DSCDependencies-$versionString.zip"
        $zipFilePath = Join-Path -Path $env:TEMP -ChildPath $zipFileName
        if ((Test-Path -Path $zipFilePath))
        {
            Write-Log -Object "$zipFileName already exist on disk. Removing!"
            Remove-Item -Path $zipFilePath -Confirm:$false
        }
        Compress-Archive -Path $savePath\* -DestinationPath $zipFilePath

        Write-Log -Object 'Uploading Zip file'
        $blobContent = Get-AzStorageBlob -Container $ContainerName -Context $context -Prefix $zipFileName
        if ($null -ne $blobContent)
        {
            Write-Log -Object "$zipFileName already exist in the Blob Storage. Removing!"
            $blobContent | Remove-AzStorageBlob
        }
        $null = Set-AzStorageBlobContent -Container $ContainerName -File $zipFilePath -Context $context -Force

        Write-Log -Object 'Removing temporary components'
        Remove-Item -Path $savePath -Recurse -Confirm:$false -Force
        Remove-Item -Path $zipFilePath -Confirm:$false
    }
    else
    {
        Write-Log -Object '[ERROR] Dependencies\Manifest.psd1 file not found' -Failure
        return $false
    }

    return $true
}
