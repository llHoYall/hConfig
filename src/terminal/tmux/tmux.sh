#!/bin/bash

# Include Scripts -------------------------------------------------------------#
. ../../misc/hcolor.sh

# Install tmux ----------------------------------------------------------------#
echo -e " ==> Install ${YELLOW}tmux${END}"
if [ -z "$(command -v tmux)" ]; then
	if [ "$(uname -s)" == "Darwin" ]; then
		brew install tmux
	elif [ "$(uname -s)" == "Linux" ]; then
		sudo apt install -y tmux
	fi
else
	echo "     Already installed"
fi

# Tmuxinator
echo -e "  => Install ${BR_YELLOW}tmuxinator${END}"
if [ -z "$(command -v tmuxinator)" ]; then
	if [ "$(uname -s)" == "Darwin" ]; then
		brew install tmuxinator
	elif [ "$(uname -s)" == "Linux" ]; then
		sudo apt install -y tmuxinator
	fi
else
	echo "    Already installed"
fi

# Configure tmux --------------------------------------------------------------#
echo -e " ==> Config ${YELLOW}tmux${END}"
if [ ! -z "$(command -v tmux)" ]; then
	rm -rf ~/.tmux ~/.tmux.conf
	mkdir -p ~/.tmux
	ln tmux_statusbar.sh ~/.tmux
	ln .tmux.conf ~
	echo -e "    Press ${GREEN}<CTRL-b> + r${END} in tmux"
else
	echo "    Not installed."
fi
