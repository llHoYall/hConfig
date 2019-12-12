#Requires -RunAsAdministrator

<# Install Python ------------------------------------------------------------#>
Write-Host -NoNewline " ==> Install "
Write-Host -ForegroundColor YELLOW "Python"

<# Install pyenv#>
Write-Host -NoNewline "  => Install "
Write-Host -ForegroundColor DARKYELLOW "pyenv"
If ((Test-Path $env:USERPROFILE/.pyenv) -eq $False) {
	git clone https://github.com/pyenv-win/pyenv-win.git $env:USERPROFILE/.pyenv
}

<# Configure Python ----------------------------------------------------------#>
Write-Host -NoNewline " ==> Config "
Write-Host -ForegroundColor YELLOW "Python"

<# Configure pyenv#>
Write-Host -NoNewline "  => Config "
Write-Host -ForegroundColor DARKYELLOW "pyenv"
If (Test-Path $env:USERPROFILE/.pyenv) {
	[System.Environment]::SetEnvironmentVariable('PYENV', $env:USERPROFILE + "\.pyenv\pyenv-win", [System.EnvironmentVariableTarget]::Machine)
}
$AddingPath = $env:PYENV + "\bin"
$RegPath = "Registry::HKLM\System\CurrentControlSet\Control\Session Manager\Environment"
$OldPath = (Get-ItemProperty -Path $RegPath -Name PATH).Path
$NewPath= $OldPath + ";" + $AddingPath
Set-ItemProperty -Path $RegPath -Name PATH –Value $NewPath
