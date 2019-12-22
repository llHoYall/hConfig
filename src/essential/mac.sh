#!/bin/bash

# Include Scripts -------------------------------------------------------------#
cd $(dirname $0)
. ../misc/hcolor.sh

# Install homebrew ------------------------------------------------------------#
function MAC_Install_Homebrew() {
	echo -e " ==> Install ${YELLOW}homebrew${END}"
	if [ -z "$(command -v brew)" ]; then
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	else
		echo "     Already installed"
	fi
}

# Install Fonts ---------------------------------------------------------------#
function MAC_Install_Fonts() {
	echo -e " ==> Install ${YELLOW}Fonts${END}"
	# Cascadia Code #
	if [ -d /usr/local/Caskroom/font-cascadia ]; then
		echo "    Already installed"
	else
		echo -e "  => Install ${BR_YELLOW}Fonts${END}"
		brew cask install homebrew/cask-fonts/font-cascadia
	fi
}

# Run Script ------------------------------------------------------------------#
MAC_Install_Homebrew
MAC_Install_Fonts
