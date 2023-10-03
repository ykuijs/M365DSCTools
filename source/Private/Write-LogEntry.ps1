<#
 .Synopsis
  Writes a log entry to the console, including a timestamp

 .Description
  This function writes a log entry to the console, including a
  timestamp of the current time.

 .Parameter Message
  The message that has to be written to the console.

 .Parameter Level
  The number of spaces the message has to be indented.

 .Example
  Write-LogEntry -Message 'This is a log entry'

 .Example
  Write-LogEntry -Message 'This is an indented log entry' -Level 1
#>
function Write-LogEntry
{
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Justification = 'Using Write-Host to force output to the screen instead of into the pipeline.')]
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Message,

        [Parameter()]
        [System.Int32]
        $Level = 0
    )

    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    $indentation = '  ' * $Level
    $output = '[{0}] - {1}{2}' -f $timestamp, $indentation, $Message

    Write-Host -Object $output
}
