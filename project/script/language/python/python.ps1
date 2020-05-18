#Requires -RunAsAdministrator

<# Configure Python ----------------------------------------------------------#>
function Python_Config() {
	Write-Host -NoNewline " ==> Config "
	Write-Host -ForegroundColor Yellow "Python"

	<# Configure pyenv#>
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
