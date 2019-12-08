<# Install PowerShell --------------------------------------------------------#>
Write-Host -NoNewline " ==> Install "
Write-Host -ForegroundColor Yellow "AutoHotkey"
$result = choco list -lo autohotkey
If ($result.Split(' ').Count -eq 7) {
	choco upgrade -y autohotkey
} Else {
	choco install -y autohotkey
}

<# Configure AutoHotKey ------------------------------------------------------#>
Write-Host -NoNewline " ==> Config "
Write-Host -ForegroundColor Yellow "AutoHotkey"

<# Create Shortcut Link #>
Write-Host "  => Create shortcut link "
New-Item -ItemType SymbolicLink -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup" -Name "hKeymap.lnk" -Value $PSScriptRoot\hKeymap.ahk
