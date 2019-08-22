<# Install PowerShell --------------------------------------------------------#>
Write-Host -NoNewline " ==> Install "
Write-Host -ForegroundColor Yellow "PowerShell"
If (Get-Command pwsh-preview -errorAction SilentlyContinue) {
	Write-Host "     Already installed."
} Else {
  choco install -y powershell-preview
}

<# Posh-Git Module #>
Write-Host -NoNewline "  => Install "
Write-Host -NoNewline -ForegroundColor DarkYellow "posh-git"
Write-Host " Module"
If (Get-Module -ListAvailable -Name posh-git) {
  Write-Host "     Already installed."
} Else {
	Install-Module -Name posh-git -Scope CurrentUser -Force
}

<# PSColor Module #>
Write-Host -NoNewline "  => Install "
Write-Host -NoNewline -ForegroundColor DarkYellow "PSColor"
Write-Host " Module"
If (Get-Module -ListAvailable -Name PSColor) {
  Write-Host "     Already installed."
} Else {
	Install-Module -Name PSColor -Scope CurrentUser -Force
}

<# PSReadLine Module #>
Write-Host -NoNewline "  => Install "
Write-Host -NoNewline -ForegroundColor DarkYellow "PSReadLine"
Write-Host " Module"
If (Get-Module -ListAvailable -Name PSReadLine) {
  Write-Host "     Already installed."
} Else {
	Install-Module -Name PSReadLine -Scope CurrentUser -Force
}

<# Configure PowerShell ------------------------------------------------------#>
Write-Host -NoNewline " ==> Config "
Write-Host -ForegroundColor YELLOW "PowerShell"
If (!(Get-Command pwsh-preview -errorAction SilentlyContinue)) {
  Write-Host "     Not installed."
  Break
}

<# PowerShell Profile #>
Write-Host -NoNewline "  => Config "
Write-Host -ForegroundColor DarkYellow "PowerShell: Profile"
If (Test-Path $PROFILE) {
  Remove-Item $PROFILE
}
New-Item -ItemType HardLink -Path $PROFILE -Value $PSScriptRoot\Microsoft.Powershell_profile.ps1