<# Configure VSCode for Python -----------------------------------------------#>
function VSCode_Python_Config($version, $requirements) {
	Write-Host -NoNewline " ==> Config "
	Write-Host -ForegroundColor YELLOW "vscode (Python)"

	If (Get-Command code -errorAction SilentlyContinue) {
		<# Extention - Insert Unicode #>
		Write-Host -NoNewline "  => Config "
		Write-Host -NoNewline -ForegroundColor DARKYELLOW "Python"
		Write-Host " extension"
		If ($null -eq (code --list-extensions | Select-String ms-python.python)) {
			code --install-extension ms-python.python
		}

		<# Config Python Environment #>
		If (Get-Command pyenv -errorAction SilentlyContinue) {
			If ($null -eq $version) {
				pyenv install 3.8.0-amd64
				pyenv local 3.8.0-amd64
			} Else {
				pyenv install $version
				pyenv local $version
			}
			pyenv rehash

			If ((Test-Path ./.venv) -eq $False) {
				python -m venv .venv
			}
			.\.venv\Scripts\activate

			If ($null -eq $requirements) {
				pip install -r $PSScriptRoot/requirements.txt
			} Else {
				pip install -r $requirements
			}
		}

		New-Item -Path . -Name ".vscode" -ItemType "directory"
		Copy-Item $PSScriptRoot/*.json -Destination "./.vscode"
	} Else {
		Write-Host "     Not installed."
	}
}

<# Run Script ----------------------------------------------------------------#>
VSCode_Python_Config $args[0] $args[1]
