<# Install Windows Terminal --------------------------------------------------#>
Write-Host -NoNewline " ==> Install "
Write-Host -ForegroundColor Yellow "WindowsTerminal"
If (Get-Command wt -errorAction SilentlyContinue) {
	Write-Host "     Already installed."
} Else {
  choco install -y microsoft-windows-terminal
}

<# Configure Windows Terminal ------------------------------------------------#>
Write-Host -NoNewline " ==> Config "
Write-Host -ForegroundColor YELLOW "WindowsTerminal"
If (!(Get-Command wt -errorAction SilentlyContinue)) {
  Write-Host "     Not installed."
  Break
}

<# Windows Terminal Settings #>
Write-Host -NoNewline "  => Config "
Write-Host -ForegroundColor DarkYellow "WindowsTerminal: Settings"
If (Test-Path $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\profiles.json) {
  Remove-Item $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\profiles.json
}
New-Item -ItemType HardLink -Path $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\profiles.json -Value $PSScriptRoot\profiles.json
