#Requires -RunAsAdministrator

<# Configure Python ----------------------------------------------------------#>
function Python_Config() {
	Write-Host -NoNewline " ==> Config "
	Write-Host -ForegroundColor Yellow "Python"

	# Configure pyenv
	Write-Host -NoNewline "  => Config "
	Write-Host -ForegroundColor DarkYellow "pyenv"
	if (Test-Path $env:USERPROFILE/.pyenv) {
		[System.Environment]::SetEnvironmentVariable('PYENV', $env:USERPROFILE + "\.pyenv\pyenv-win", [System.EnvironmentVariableTarget]::Machine)

		$env:PYENV = [System.Environment]::GetEnvironmentVariable('PYENV', [System.EnvironmentVariableTarget]::Machine)
		$AddingPath = $env:PYENV + "\bin;" + $env:PYENV + "\shims"
		$RegPath = "Registry::HKLM\System\CurrentControlSet\Control\Session Manager\Environment"
		$OldPath = (Get-ItemProperty -Path $RegPath -Name PATH).Path

		if (!($OldPath -match ".pyenv")) {
			if ($OldPath[-1] -eq ';') {
				$NewPath = $OldPath + $AddingPath
			} else {
				$NewPath = $OldPath + ";" + $AddingPath
			}
			Set-ItemProperty -Path $RegPath -Name PATH -Value $NewPath
		}
	}
}

function Python_Config_VSCode($version, $requirements) {
	Write-Host -NoNewline " ==> Config "
	Write-Host -ForegroundColor YELLOW "Python (vscode)"

	If (Get-Command code -errorAction SilentlyContinue) {
		If (Get-Command pyenv -errorAction SilentlyContinue) {
			If ($null -eq $version) {
				pyenv install -s 3.8.1-amd64
				pyenv local 3.8.1-amd64
			} Else {
				pyenv install -s $version
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
