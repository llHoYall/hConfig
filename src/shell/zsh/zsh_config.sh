#!/bin/bash

# Include Scripts -------------------------------------------------------------#
. ../../misc/hcolor.sh

# Install Zsh -----------------------------------------------------------------#
echo -e " ==> Install ${YELLOW}zsh${END}"
if [ -z "$(command -v zsh)" ]; then
	if [ "$(uname -s)" == "Darwin" ]; then
		brew install zsh
	elif [ "$(uname -s)" == "Linux" ]; then
		sudo apt install -y zsh
	fi
else
	echo "     Already installed"
fi

# oh-my-zsh
echo -e "  => Install ${YELLOW}oh-my-zsh${END}"
if [ ! -d ~/.oh-my-zsh ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
	echo "     Already installed"
fi

# zsh-syntax-highlighting plugin
echo -e "  => Install ${YELLOW}zsh-syntax-highlighting${END}"
if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
	echo "     Already installed"
fi

# zsh-autosuggestions
echo -e "  => Install ${YELLOW}zsh-autosuggestions${END}"
if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
	echo "     Already installed"
fi

# Configure Zsh ---------------------------------------------------------------#
echo -e " ==> Config ${YELLOW}zsh${END}"
if [ ! -z "$(command -v zsh)" ]; then
	rm -rf ~/.zshrc
	ln .zshrc ~
else
	echo "     Not installed."
fi

# oh-my-zsh
echo -e "  => Config ${YELLOW}oh-my-zsh${END}"
if [ -d ~/.oh-my-zsh ]; then
	rm -rf ~/.oh-my-zsh/themes/hoya.zsh-theme
	sudo ln hoya.zsh-theme ~/.oh-my-zsh/themes/
else
	echo "     Not installed."
fi

chsh -s $(which zsh)
echo -e "     ${RED}Please, reopen the shell${END}"

