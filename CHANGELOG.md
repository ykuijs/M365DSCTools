# Changelog for M365DSCTools

The format is based on and uses the types of changes according to [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.5] - 2023-12-11

### Fixed

- Fixed bug in hashtable merge. Corrected Identity typo to Id.
- Added a folder deletion section to Add-ModulesToBlobStorage.ps1 to avoid packaging issues on self-hosted VMs.

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
