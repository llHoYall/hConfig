<# Configure VSCode for Python -----------------------------------------------#>
function VSCode_Python_Config($version, $requirements) {
	Write-Host -NoNewline " ==> Config "
	Write-Host -ForegroundColor YELLOW "vscode (Python)"

	Write-Host $version

	<# Config Python Environment#>
	If (Get-Command pyenv -errorAction SilentlyContinue) {
		If ($version -eq $null) {
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

		If ($requirements -eq $null) {
			pip install -r $PSScriptRoot/requirements.txt
		} Else {
			pip install -r $requirements
		}
	}
}

<# Run Script ----------------------------------------------------------------#>
VSCode_Python_Config $args[0], $args[1]
