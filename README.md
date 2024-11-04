# Adobe Acrobat Security Hardening Script

## Overview

This PowerShell script configures security settings for Adobe Acrobat DC to enforce enhanced security protocols through Windows registry modifications. It disables JavaScript and enforces security features such as Protected Mode, Enhanced Security, and Protected View. It is designed for deployment via Microsoft Intune but will work if run manually with appropriate permissions.

## Features

- **Registry Path Check**: Verifies the existence of the required registry path for Adobe Acrobat security settings.
- **Path Creation**: Creates the registry path if it does not exist, ensuring compatibility even on systems where Acrobat is not yet installed.
- **Security Settings**:
  - Disables JavaScript execution.
  - Enforces Enhanced Security for standalone and browser modes.
  - Enables Protected Mode and Protected View for documents.
  - Enforces an App Container for enhanced isolation.

## Requirements

- **Adobe Acrobat DC** installed on the system (if not present, the registry path will be created, but settings may only apply once Acrobat is installed).
- **Windows** with PowerShell capabilities.
- **Administrative privileges** to modify registry keys. Intune will trigger this script with SYSTEM permissions by default.
- **Microsoft Intune (optional)** for deployment across managed devices.

## Script Details

### Registry Path

The script modifies the following registry path: `HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown\`

### Security Settings Applied

The script sets the following registry keys:

- `bDisableJavaScript`: Disables JavaScript in Acrobat. (Value `1`).
- `bEnhancedSecurityStandalone`: Enforces Enhanced Security in standalone mode. (Value `1`).
- `bEnhancedSecurityInBrowser`: Enforces Enhanced Security when viewing PDFs in a browser. (Value `1`).
- `bProtectedMode`: Enables Protected Mode for added security. (Value `1`).
- `iProtectedView`: Sets Protected View mode (Value `2`, enforces Protected View for all files).
- `bEnableProtectedModeAppContainer`: Forces Acrobat to run in an isolated App Container. (Value `1`).

### Logging

The script logs its activities to: `C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\Adobe_Acrobat_Security_Hardening_Script.log`

## Exit Codes

- **0**: Success - The script completed without errors.
- **-1**: Failure - There was an error creating registry paths or setting registry keys.

## Error Handling

The script includes try-catch blocks to handle potential errors during registry modification. If an error occurs:

- The script logs the error and stops the logging session.
- The script exits with an error code (`-1`), indicating that the registry modifications did not complete successfully.

## Version Information

- **Version**: 1.0
- **Author**: [Jordan Collins](https://github.com/JordanCollinsNZ/Intune-Acrobat-Hardening)
