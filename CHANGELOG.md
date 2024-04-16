# Changelog for M365DSCTools

The format is based on and uses the types of changes according to [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.2.8] - 2024-04-05

### Changed

- Updated code to support ObjectGraphTools v0.1.0 and higher

### Fixed

- Fixed issue with importing data file in Convert-M365DSCExportToPowerShellDataFile

## [0.2.7] - 2024-03-26

### Changed

- Updated Set-ADOEnvironment to make the approval settings configurable

## [0.2.6] - 2024-03-26

- Corrected typo in logging in Set-ADOEnvironment
- Improved logging in Set-ADOEnvironment
- Fixed issue in Convert-M365DSCExportToPowerShellDataFile where resources with "Profile" in the
  name wasn't converted properly
- Fixed issue in Convert-M365DSCExportToPowerShellDataFile where multiple versions of
  M365DSC.CompositeResources being installed caused errors
- Fixed issue in Set-ADOEnvironment where the checks weren't updating due to missing
  check id parameter
- Fixed issue with diacritic characters in Set-ADOEnvironment

## [0.2.5] - 2024-03-19

- Added required version range for ObjectGraphTools

## [0.2.4] - 2024-03-19

- Updated logging to new function in Add-ModulesToBlobStorage and Get-ModulesFromBlobStorage
- Updated Add-ModulesToBlobStorage and Get-ModulesFromBlobStorage to return a boolean with
  the result of the operation

## [0.2.3] - 2024-03-05

- Fixed issue in Set-PipelineYaml where an exception was thrown when the Defaults
  parameter was empty [Fixes #8](https://github.com/ykuijs/M365DSCTools/issues/8)

## [0.2.2] - 2024-02-29

- Fixed bug in Test-M365PowerShellDataFile where an incorrect path was generated.
- Converted the required parameter test in Test-M365PowerShellDataFile to an actual Pester
  test, so Pester will fail if the parameter is missing.
- Fixed issue in Test-M365PowerShellDataFile where errors were displayed when the example
  file did not contain a property that was specified in the data file.
- Fixed issue with correctly loading the ObjectGraphTools module, making
  sure the PSNode classes are available.
- Corrected location of generic information files in the Get-EnvironmentsGenericInfo function.
- Corrected issue in Set-PipelineYaml where the dependsOn property was written as an empty
  string instead of null.

## [0.2.1] - 2024-02-23

### Added

- Added new more advanced Write-Log function.
- Added Convert-M365DSCExportToPowerShellDataFile function to convert a Microsoft365DSC export
  to a PowerShell data file that complies with the format specified in the M365DSC.CompositeResources
  module.
- Added Copy-Object function to copy hashtable objects by value instead of by reference.
- Added Get-EnvironmentsGenericInfo function to retrieve generic information on the CICD
  config from the Generic data files.
- Added Import-PSDataFile function that fixes the limitation of the default
  Import-PowerShellDataFile function.
- Added Set-ADOEnvironment function to configure Azure DevOps environments correctly.
- Added Set-PipelineYaml function to configure Azure DevOps pipeline YAML files correctly.
- Added Test-M365PowerShellDataFile function to test if the merged data file complies with the
  Microsoft365DSC schema, as specified in the ExampleData file of the CompositeResources module.

### Changed

- Updated information in the Readme file

### Remove

- Rollback of the new DataObject functions. These will be replaced by the [ObjectGraphTools module](https://www.powershellgallery.com/packages/ObjectGraphTools)

## [0.2.0] - 2024-01-02

### Added

- Added new Compare-DataObject, Copy-DataObject, Merg-DataObject and Sort-DataObject functions.
  These new functions can be used to manipulate various data objects, such as arrays and hashtables,
  so they can be used in PowerShell DSC configurations.

### Fixed

- Added a folder deletion section to Add-ModulesToBlobStorage.ps1 to avoid packaging issues on self-hosted VMs.

## [0.1.5] - 2023-12-11

### Fixed

- Fixed bug in hashtable merge. Corrected Identity typo to Id.

## [0.1.4] - 2023-11-24

### Changed

- Added Id as a new value to merge items in an array, in addition to UniqueId, NodeName and Identity
- Updated package information in the module manifest file
- Added the caching of the Microsoft365DSC module itself to Azure Blob storage
- Extended the Get-ModulesFromBlobStorage function with the clear-out of existing modules
- Corrected certain log strings and function descriptions

## [0.1.2] - 2023-10-06

### Added

- First version of this module
