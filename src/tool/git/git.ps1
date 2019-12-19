#Requires -RunAsAdministrator

<# Install Git ---------------------------------------------------------------#>
function Git_Install() {
	Write-Host -NoNewline " ==> Install "
	Write-Host -ForegroundColor Yellow "Git"
	If (Get-Command git -ErrorAction SilentlyContinue) {
		Write-Host -NoNewline "  => Upgrade "
		Write-Host -ForegroundColor DarkYellow "Git"
		choco upgrade -y git
	} Else {
		choco install -y git
	}
}

<# Configure Git -------------------------------------------------------------#>
function Git_Config() {
	Write-Host -NoNewline " ==> Config "
	Write-Host -ForegroundColor Yellow "Git"

	# color.ui
	git config --global color.ui auto

	# help.autocorrect
	git config --global help.autocorrect 1

	# pull.rebase
	git config --global pull.rebase true

	# push.default
	git config --global push.default simple

	# rerere.enabled
	git config --global rerere.enabled true

	# merge.tool
	If (Get-Command meld -ErrorAction SilentlyContinue) {
		git config --global merge.tool meld
		git config --global mergetool.meld.cmd "'C:/Program Files (x86)/Meld/Meld.exe' `$LOCAL `$REMOTE `$BASE `$MERGED"
		git config --global mergetool.meld.trustExitCode true
	} ElseIf (Get-Command BComp -ErrorAction SilentlyContinue) {
		git config --global merge.tool bc4
		git config --global mergetool.bc4.cmd "'C:/Program Files/Beyond Compare 4/BComp.exe' `$LOCAL `$REMOTE `$BASE `$MERGED"
		git config --global mergetool.bc4.trustExitCode true
	}

	# diff.tool
	If (Get-Command meld -ErrorAction SilentlyContinue) {
		git config --global diff.tool meld
		git config --global difftool.meld.cmd "'C:/Program Files (x86)/Meld/Meld.exe' `$LOCAL `$REMOTE"
		git config --global difftool.meld.prompt false
	} ElseIf (Get-Command BComp -ErrorAction SilentlyContinue) {
		git config --global diff.tool bc4
		git config --global difftool.bc4.cmd "'C:/Program Files/Beyond Compare 4/BComp.exe' `$LOCAL `$REMOTE"
		git config --global difftool.bc4.prompt false
	}
}

<# Run Script ----------------------------------------------------------------#>
Git_Install
Git_Config
