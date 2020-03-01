@echo off

:: Install PowerShell ----------------------------------------------------------
echo | set /p=". ==> Install "
echo [33mPowershell[0m

where powershell-preview >nul 2>nul
IF NOT ERRORLEVEL 0 (
	choco install -y powershell-preview
) ELSE (
	echo | set /p=".  => Upgrade "
	echo [33mPowershell[0m
  choco upgrade -y powershell-preview
)
