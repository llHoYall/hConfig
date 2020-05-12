#Requires -RunAsAdministrator

<# Configure Powershell ------------------------------------------------------#>
function Powershell_Config() {
  Write-Host -NoNewline " ==> Config "
  Write-Host -ForegroundColor Yellow "PowerShell"

  <# NuGet PackageProvider #>
  Write-Host -NoNewline "  => Install "
  Write-Host -NoNewline -ForegroundColor DarkYellow "NuGet"
  Write-Host " PackageProvider"
  If (!(Get-PackageProvider -ListAvailable -Name NuGet -ErrorAction SilentlyContinue)) {
    Install-PackageProvider -Name NuGet -Force
  }

  <# Posh-Git Module #>
  Write-Host -NoNewline "  => Install "
  Write-Host -NoNewline -ForegroundColor DarkYellow "posh-git"
  Write-Host " Module"
  If (Get-Module -ListAvailable -Name posh-git) {
    Update-Module -Name posh-git -Force
  } Else {
    Install-Module -Name posh-git -Scope CurrentUser -Force
  }

  <# PSColor Module #>
  Write-Host -NoNewline "  => Install "
  Write-Host -NoNewline -ForegroundColor DarkYellow "PSColor"
  Write-Host " Module"
  If (Get-Module -ListAvailable -Name PSColor) {
    Update-Module -Name PSColor -Force
  } Else {
    Install-Module -Name PSColor -Scope CurrentUser -Force
  }

  <# PSReadLine Module - Default installed #>
  # Write-Host -NoNewline "  => Install "
  # Write-Host -NoNewline -ForegroundColor DarkYellow "PSReadLine"
  # Write-Host -NoNewLine " Module"
  # If (Get-Module -ListAvailable -Name PSReadLine) {
  #   Update-Module -Name PSReadLine -Scope CurrentUser -Force
  # } Else {
  #   Install-Module -Name PSReadLine -Scope CurrentUser -Force
  # }

  <# PowerShell Profile #>
  Write-Host -NoNewline "  => Config "
  Write-Host -ForegroundColor DarkYellow "PowerShell: Profile"
  If (Test-Path $PROFILE) {
    Remove-Item $PROFILE
  }
  New-Item -ItemType HardLink -Path $PROFILE -Value $PSScriptRoot\Microsoft.Powershell_profile.ps1
}
