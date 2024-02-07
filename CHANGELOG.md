# Changelog for M365DSCTools

The format is based on and uses the types of changes according to [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Added new internal Write-Log function
- Added Copy-Object function to copy hashtable objects by value instead of by reference
- Added Import-PSDataFile function that fixes the limitation of the default Import-PowerShellDataFile function.

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
