<# Configure VSCode for Python -----------------------------------------------#>
Write-Host -NoNewline " ==> Config "
Write-Host -ForegroundColor YELLOW "vscode (Python)"

<# Config Python Environment#>
If (Get-Command python -errorAction SilentlyContinue) {
	pyenv install 3.8.0-amd64
}
pyenv local 3.8.0-amd64
pyenv rehash

If ((Test-Path ./.venv) -eq $False) {
	python -m venv .venv
}
.\.venv\Scripts\activate
pip install -r $PSScriptRoot/requirements.txt
