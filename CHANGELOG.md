# Changelog for M365DSCTools

The format is based on and uses the types of changes according to [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.4.8] - 2025-07-15

### Fixed

- Corrected reversed checks for SInt (Signed Int) and UInt (Unsigned Int). SInt
  is now checking for an Int and UInt only for positive characters.

## [0.4.7] - 2025-06-17

### Changed

- Updated the convert export function to:
  - Check the schema for which type is expected for a specific resource, an array or
    an hashtable, and uses the correct type.
  - Generates UniqueId properties for the collections that require it. For DSC resources,
    this includes the resource instance name and for subproperties a counter is used.
  - Runs a Pester test to test if the exported values are of the right type and if
    all required properties are present.
  - Add possibility to use PowerShell v7+, where some code is proxying requests via
    PowerShell v5.1.

### Fixed

- Fixed issue in the Test function where DateTime objects are stored in string
  format, but the Test really checks for the DateTime type. Now testing if the
  string is in a correct DateTime format.
- Added support for ObjectGraphTools v0.3, which contains some important changes.

## [0.4.6] - 2025-03-18

### Added

- Added support for new ServicesHub workload

## [0.4.5] - 2025-02-11

### Added

- Added support for new Commerce workload

## [0.4.4] - 2025-02-04

### Added

- Added new IncludeRequired parameter for the TypeValue check. This because at TypeValue level,
  we need the possibility to check the individual files for a required parameter. Specifically
  the UniqueID parameter and the full required check cannot be executed yet.

### Fixed

- Fixed bug in Test-M365DSCPowershellDataFile where the code would throw an error when
  multiple versions of M365DSC.CompositeResources exist

## [0.4.3] - 2024-10-15

### Changed

- Added SettingDefinitionId as a new value to merge items in an array, in addition to UniqueId,
  NodeName, Id and Identity
- Added support for the new Azure, Azure DevOps and Defender workloads
- Corrected issue in Required test in Test-M365DSCPowershellDataFile, where array
  values were not checked properly.

## [0.4.2] - 2024-10-01

### Fixed

- Fixed bug in Test datafiles function to correctly test required parameters

## [0.4.1] - 2024-09-18

### Added

- Added Sentinel workload support
- Added code to only install dependencies that are needed for the used PowerShell version

## [0.4.0] - 2024-09-10

### Added

- Added CIMInstance key to the exclusion list for Convert-M365DSCExportToPowerShellDataFile

### Changed

- Updated ObjectGraphTools requirement to v0.2 and higher
- Updated Test-M365DSCPowershellDataFile to allow four scenarios: Test for type values, required parameters,
  mandatory has to be present and mandatory has to be absent

### Removed

- Removed two old and obsolete functions Test-M365MandatoryPowerShellDataFile and
  Test-M365PowerShellDataFile. These are replaced with Test-M365DSCPowerShellDataFile

## [0.3.0] - 2024-07-09

### Added
- Function Test-M365DSCPowershellDataFile added as replacement for Test-M365PowershellDataFile

## [0.2.12] - 2024-07-03

### Fixed

- Fixed issue in Convert-M365DSCExportToPowerShellDataFile where the created data file
  was in ASCII format, causing special characters to be displayed incorrectly.


## [0.2.11] - 2024-06-19

### Changed

- Updated Test-M365MandatoryPowershellDataFile to filter key parameters for testing.
  This is to make sure you can specify some properties of an object without tests
  failing because the key parameter exists
- Updated Test-M365PowershellDataFile to make sure warning are suppressed from Get-ChildNode
- Updated Set-ADOEnvironment to skip configuring checks on environments that are not
  specified in the TargetEnvironments parameter

## [0.2.10] - 2024-05-07

### Fixed

- Fixed several issues in Test-M365MandatoryPowershellDataFile, which caused the NotAllowedMandatory
  parameter not to work

## [0.2.9] - 2024-05-07

### Added

- New Test-IfModulesInBlobStorage that tests if a package exists in the Azure Blob
  Storage for the specified Microsoft365DSC version
- New Test-M365MandatoryPowershellDataFile function to test a data object for
  mandatory values

### Changed

- Updated the Test-M365PowerShellDataFile function to allow specifying to disable checking
  for Required parameters. This is specifically useful for individual, not yet merged, data
  files. There required parameters could not exist, because they are coming from a different file.
- Optimized unit tests for Test-M365PowershellDataFile

### Fixed

- Fixed issue in Convert-M365DSCExportToPowerShellDataFile where parameter in ConvertTo-Expression
  has been removed
- Corrected pipeline yaml output where the file was encoded as UTF8 instead of UTF8 with BOM. Now
  code always outputs UTF8 with BOM

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
