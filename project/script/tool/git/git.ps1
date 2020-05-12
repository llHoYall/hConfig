#Requires -RunAsAdministrator

<# Configure Git -------------------------------------------------------------#>
function Git_Config_Global() {
	Write-Host -NoNewline " ==> Config "
	Write-Host -NoNewline -ForegroundColor Yellow "Git"
	Write-Host " (Global)"

	# color.ui
	Write-Host "  => color.ui"
	git config --global color.ui auto

	# help.autocorrect
	Write-Host "  => help.autocorrect"
	git config --global help.autocorrect 1

	# pull.rebase
	Write-Host "  => pull.rebase"
	git config --global pull.rebase true

	# push.default
	Write-Host "  => push.default"
	git config --global push.default simple

	# rerere.enabled
	Write-Host "  => rerere.enabled"
	git config --global rerere.enabled true

	# merge.tool
	Write-Host "  => merge.tool"
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
	Write-Host "  => diff.tool"
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

function Git_Config_Local_HoYa() {
	Write-Host -NoNewline " ==> Config "
	Write-Host -NoNewline -ForegroundColor Yellow "Git"
	Write-Host " (Local)"
	Write-Host -NoNewline "  => Config "
	Write-Host -NoNewline -ForegroundColor DarkYellow "HoYa"
	Write-Host ": llHoYall <hoya128@gmail.com>"

	# user.name
	Write-Host "  => user.name"
	git config --local user.name "llHoYall"

	# user.email
	Write-Host "  => user.email"
	git config --local user.email "hoya128@gmail.com"
}
