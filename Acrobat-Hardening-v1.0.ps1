# Version 1.0
# Author - https://github.com/JordanCollinsNZ/Intune-Acrobat-Hardening

# Start logging
Start-Transcript -Path "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\Adobe_Acrobat_Security_Hardening_Script.log"

# Define the registry path for Adobe Acrobat's JavaScript setting
$regPath = "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown\"

# Check if the registry path exists; if not, create it
if (!(Test-Path -Path $regPath)) {
    try {
        Write-Information "Registry path does not exist, Acrobat likely not installed yet"
        New-Item -Path $regPath -Force | Out-Null
        Write-Information "Created registry path"
    } catch {
        Write-Error "Failed to create path"
        Stop-Transcript
        exit -1
    }
} else {
    Write-Information "Registry path already exists"
}

# Set registry keys for Acrobat hardening
try {
    Write-Information "Creating registry keys..."

    Set-ItemProperty -Path $regPath -Name "bDisableJavaScript" -Value 1
    Write-Information "Disabled JavaScript - Set bDisableJavaScript: 1"

    Set-ItemProperty -Path $regPath -Name "bEnhancedSecurityStandalone" -Value 1
    Write-Information "Forced Enhanced Security (Standalone) - Set bEnhancedSecurityStandalone: 1"

    Set-ItemProperty -Path $regPath -Name "bEnhancedSecurityInBrowser" -Value 1
    Write-Information "Forced Enhanced Security (Browser) - Set bEnhancedSecurityInBrowser: 1"

    Set-ItemProperty -Path $regPath -Name "bProtectedMode" -Value 1
    Write-Information "Forced Protected Mode - Set bProtectedMode: 1"

    Set-ItemProperty -Path $regPath -Name "iProtectedView" -Value 2
    Write-Information "Forced Protected View - Set iProtectedView: 2"

    Set-ItemProperty -Path $regPath -Name "bEnableProtectedModeAppContainer" -Value 1
    Write-Information "Forced Protected App Container - Set bEnableProtectedModeAppContainer: 1"

    Write-Information "Done!"
} catch {
    Write-Error "Failed to create registry keys"
    Stop-Transcript
    exit -1
}

Stop-Transcript
exit 0