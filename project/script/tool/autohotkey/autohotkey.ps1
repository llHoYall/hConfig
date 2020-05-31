#Requires -RunAsAdministrator

<# Configure AutoHotKey ------------------------------------------------------#>
function AutoHotKey_Config($keymap) {
	Write-Host -NoNewline " ==> Config "
	Write-Host -ForegroundColor Yellow "AutoHotkey"

	# Create Shortcut Link #
	if ($keymap -eq "gtune") {
		$FolderPath = $env:APPDATA + "\Microsoft\Windows\Start Menu\Programs\Startup"
		$FilePath = $FolderPath + "\hKeymap.lnk"
		If ((Test-Path $FilePath) -eq $True) {
			Remove-Item -Path $FilePath
		}
		New-Item -ItemType SymbolicLink -Path $FolderPath -Name "hKeymap.lnk" -Value $PSScriptRoot\hKeymap.ahk
	}
}
