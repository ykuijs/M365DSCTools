# Changelog for M365DSCTools

The format is based on and uses the types of changes according to [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Added Id as a new value to merge items in an array, in addition to UniqueId, NodeName and Identity
- Updated package information in the module manifest file
- Added the caching of the Microsoft365DSC module itself to Azure Blob storage
- Extended the Get-ModulesFromBlobStorage function with the clear-out of existing modules
- Corrected certain log strings and function descriptions

## [0.1.2] - 2023-10-06

### Added

- First version of this module
