# TailorPosh
Tail Utility for Powershell

## Purpose
This utility will allow you to tail multiple files at the same time.  Setting can be configured with the Tailor.json file.

Each line of the file can be checked against a regular expression to add optional highlighting or to be filtered out.
The default rules will highlight the following lines in a different color:

  * DEBUG
  * INFO
  * WARNING
  * FATAL

To exclude lines that don't match any rules, set the default.enabled setting to false in the Tailor.json file.

## Use

Dot source the file in a session of Powershell:

    . ".\Get-Tailor.ps1"

Call the command with a parameter array of file names:

    Get-Tailor -files one.txt, two.txt
