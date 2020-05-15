#Requires -RunAsAdministrator

<# Configure Windows Terminal ------------------------------------------------#>
function WindowsTerminal_Config_HoYa() {
  Write-Host -NoNewline " ==> Config "
  Write-Host -NoNewline -ForegroundColor Yellow "WindowsTerminal"
	Write-Host " (HoYa)"

  # Windows Terminal Settings
  If (Test-Path $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json) {
    Remove-Item $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
  }
  New-Item -ItemType HardLink -Path $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -Value $PSScriptRoot\settings_hoya.json
}

function WindowsTerminal_Config_WDC() {
  Write-Host -NoNewline " ==> Config "
  Write-Host -NoNewline -ForegroundColor Yellow "WindowsTerminal"
	Write-Host " (WDC)"

  # Windows Terminal Settings
  If (Test-Path $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json) {
    Remove-Item $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
  }
  New-Item -ItemType HardLink -Path $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -Value $PSScriptRoot\settings_wdc.json
}
