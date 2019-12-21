#Requires -RunAsAdministrator

<# Install LLVM --------------------------------------------------------------#>


<# Configure VSCode for C/C++ ------------------------------------------------#>
function VSCode_C_Cpp_Config() {
	Write-Host -NoNewline " ==> Config "
	Write-Host -ForegroundColor YELLOW "vscode (C/C++)"

	If (Get-Command code -errorAction SilentlyContinue) {
		<# Extention - C/C++ #>
		Write-Host -NoNewline "  => Config "
		Write-Host -NoNewline -ForegroundColor DARKYELLOW "C/C++"
		Write-Host " extension"
		If ($null -eq (code --list-extensions | Select-String ms-vscode.cpptools)) {
			code --install-extension ms-vscode.cpptools
		}

		<# Config C/C++ Environment #>
		If (!(Test-Path ".vscode")) {
			New-Item -Path . -Name ".vscode" -ItemType "directory"
		}
		Copy-Item $PSScriptRoot/settings.json -Destination "./.vscode"
		Copy-Item $PSScriptRoot/tasks.json -Destination "./.vscode"
		Copy-Item $PSScriptRoot/.clang-format -Destination "."

		<# Config C/C++ Snippets #>
		If (Test-Path "$env:APPDATA\Code\User\snippets") {
			Remove-Item "$env:APPDATA\Code\User\snippets\c.json"
		} Else {
			New-Item -ItemType Directory -Path "$env:APPDATA\Code\User\snippets"
		}
		cmd /c mklink /H "$env:APPDATA\Code\User\snippets\c.json" "$PSScriptRoot\c.json"
	} Else {
		Write-Host "     Not installed."
	}
}

<# Run Script ----------------------------------------------------------------#>
VSCode_C_Cpp_Config
