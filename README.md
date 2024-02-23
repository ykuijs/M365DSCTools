# M365DSCTools

![Build Status](https://img.shields.io/github/actions/workflow/status/ykuijs/M365DSCTools/ModuleBuildTestRelease.yml)
[![PowerShell Gallery (with prereleases)](https://img.shields.io/powershellgallery/v/M365DSCTools.svg?include_prereleases&label=M365DSCTools%20Preview)](https://www.powershellgallery.com/packages/M365DSCTools)
[![PowerShell Gallery](https://img.shields.io/powershellgallery/v/M365DSCTools.svg?&label=M365DSCTools)](https://www.powershellgallery.com/packages/M365DSCTools)
![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/M365DSCTools)

This module contains various tools and functions that are used in the Microsoft365DSC whitepaper ["Managing Microsoft 365 in true DevOps style with Microsoft365DSC and Azure DevOps"](https://aka.ms/m365dscwhitepaper).

This whitepaper describes how to manage Microsoft 365 using DevOps practices, by using tools like Azure DevOps and [Microsoft365DSC](https://microsoft365dsc.com/).

Of course you can use this module in your own projects as well.

This module can be found in the [PowerShell Gallery](https://www.powershellgallery.com/packages/M365DSCTools).

## Available functions

This module contains the following functions:

| Function | Description |
|----------|-------------|
| Add-ModulesToBlobStorage | Add blob to an Azure Blob Storage |
| Convert-M365DSCExportToPowerShellDataFile | Convert a Microsoft365DSC export to a PowerShell data file |
| Copy-Object | Clone an object, e.g. hashtables, making sure no references between the source and destination objects exist anymore |
| Get-EnvironmentsGenericInfo | Collects all CICD information from the '<Environment>#Generic.psd1' data files and returns this as one hashtable |
| Get-ModulesFromBlobStorage | Get a blob from an Azure Blob Storage |
| Import-PSDataFile | Updated function to import PowerShell data files but without the size limitation |
| Merge-DataObject | Function to merge data objects [Deprecated] |
| Set-ADOEnvironment | Creates and configures environments in Azure DevOps pipelines |
| Set-PipelineYaml | Updates the Environments parameter in the specified Yaml file |
| Test-M365PowerShellDataFile | Test if the merged data file complies with the Microsoft365DSC schema |
| Write-Log | Logging function used by other functions |

## Changelog

The changelog can be found [here](CHANGELOG.md).
