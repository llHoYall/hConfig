#Requires -RunAsAdministrator

<# Configure VSCode ----------------------------------------------------------#>
function VSCode_Config() {
	Write-Host -NoNewline " ==> Config "
	Write-Host -ForegroundColor Yellow "vscode"

	# Extention - C/C++
	Write-Host -NoNewline "  => Config "
	Write-Host -NoNewline -ForegroundColor DarkYellow "C/C++"
	Write-Host " extension"
	If ($null -eq (code --list-extensions | Select-String ms-vscode.cpptools)) {
		code --install-extension ms-vscode.cpptools
	}

	# Extention - Python
	Write-Host -NoNewline "  => Config "
	Write-Host -NoNewline -ForegroundColor DarkYellow "Python"
	Write-Host " extension"
	If ($null -eq (code --list-extensions | Select-String ms-python.python)) {
		code --install-extension ms-python.python
	}

	# Extention - PowerShell
	Write-Host -NoNewline "  => Config "
	Write-Host -NoNewline -ForegroundColor DarkYellow "PowerShell"
	Write-Host " extension"
	If ($null -eq (code --list-extensions | Select-String ms-vscode.powershell)) {
		code --install-extension ms-vscode.powershell
	}

	# Extention - Git Lens
	Write-Host -NoNewline "  => Config "
	Write-Host -NoNewline -ForegroundColor DarkYellow "Git Lens"
	Write-Host " extension"
	If ($null -eq (code --list-extensions | Select-String eamodio.gitlens)) {
		code --install-extension eamodio.gitlens
	}

	# Extention - Git History
	Write-Host -NoNewline "  => Config "
	Write-Host -NoNewline -ForegroundColor DarkYellow "Git History"
	Write-Host " extension"
	If ($null -eq (code --list-extensions | Select-String donjayamanne.githistory)) {
		code --install-extension donjayamanne.githistory
	}

	# Extention - Highlight Words
	Write-Host -NoNewline "  => Config "
	Write-Host -NoNewline -ForegroundColor DarkYellow "Highlight Words"
	Write-Host " extension"
	If ($null -eq (code --list-extensions | Select-String rsbondi.highlight-words)) {
		code --install-extension rsbondi.highlight-words
	}

	# Extention - Material Icon Theme
	Write-Host -NoNewline "  => Config "
	Write-Host -NoNewline -ForegroundColor DarkYellow "Material Icon Theme"
	Write-Host " extension"
	If ($null -eq (code --list-extensions | Select-String pkief.material-icon-theme)) {
		code --install-extension pkief.material-icon-theme
	}

	<# VSCode Configuration File #>
	Copy-Item $PSScriptRoot/*.json -Destination "$env:APPDATA/Code/User"
}