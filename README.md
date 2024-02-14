# M365DSCTools

This module contains various tools and functions that are used in the Microsoft365DSC whitepaper ["Managing Microsoft 365 in true DevOps style with Microsoft365DSC and Azure DevOps"](https://aka.ms/m365dscwhitepaper).

This whitepaper describes how to manage Microsoft 365 using DevOps practices, by using tools like Azure DevOps and [Microsoft365DSC](https://microsoft365dsc.com/).

Of course you can use this module in your own projects as well.

This module can be found in the [PowerShell Gallery](https://www.powershellgallery.com/packages/M365DSCTools).

## Available functions

This module contains the following functions:

| Function | Description |
|----------|-------------|
| Add-ModulesToBlobStorage | Add blob to an Azure Blob Storage |
| Copy-Object | Clone an object, e.g. hashtables, making sure no references between the source and destination objects exist anymore |
| Get-ModulesFromBlobStorage | Get a blob from an Azure Blob Storage |
| Import-PSDataFile | Updated function to import PowerShell data files but without the size limitation |
| Merge-DataObject | Function to merge data objects [Deprecated] |
| Set-ADOEnvironment | Creates and configures environments in Azure DevOps pipelines |
| Write-Log | Logging function used by other functions |
