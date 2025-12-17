# Open Control UI LVGL CLI Tools - Install script (Windows PowerShell)
# Adds ui-lvgl-cli-tools/bin to user PATH

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BinDir = Join-Path $ScriptDir "bin"

Write-Host "Open Control UI LVGL CLI Tools Installer"
Write-Host "========================================="
Write-Host ""
Write-Host "Bin directory: $BinDir"
Write-Host ""

# Get current user PATH
$UserPath = [Environment]::GetEnvironmentVariable("Path", "User")

# Check if already in PATH
if ($UserPath -like "*$BinDir*") {
    Write-Host "Already in PATH. Nothing to do."
    exit 0
}

# Add to PATH
$NewPath = "$UserPath;$BinDir"
[Environment]::SetEnvironmentVariable("Path", $NewPath, "User")

Write-Host "Added to user PATH."
Write-Host ""
Write-Host "IMPORTANT: Restart your terminal or run:"
Write-Host "  `$env:Path = [Environment]::GetEnvironmentVariable('Path', 'User')"
Write-Host ""
Write-Host "Commands available (via Git Bash):"
Write-Host "  oc-icons  - Build icon fonts from SVG"
Write-Host "  oc-font   - Convert TTF/OTF to LVGL binary"
Write-Host "  oc-img    - Convert images to LVGL format"
Write-Host ""
Write-Host "Prerequisites:"
Write-Host "  - Python 3"
Write-Host "  - Inkscape (for SVG processing)"
Write-Host "  - FontForge (for TTF generation)"
Write-Host "  - Node.js + npm (for lv_font_conv)"
