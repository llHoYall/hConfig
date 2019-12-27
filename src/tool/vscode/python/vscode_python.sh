#!/bin/bash

# Include Scripts -------------------------------------------------------------#
cd $(dirname $0)
. ../../../misc/hcolor.sh
cd - > /dev/null

# Configure VSCode for Python -------------------------------------------------#
function VSCode_Python_Config() {
	echo -e " ==> Config ${YELLOW}vscode (Python)${END}"

	if [ -n "$(command -v code)" ]; then
		# Extention - Insert Unicode #
		echo -e "  => Config ${BR_YELLOW}Python${END} extension"
		if [ -z "$(code --list-extensions | grep -w ms-python.python)" ]; then
			code --install-extension ms-python.python
		fi

		# Config Python Environment #
		if [ -n "$(command -v pyenv)" ]; then
			if [ -z $2 ]; then
				pyenv install -s 3.9-dev
				pyenv local 3.9-dev
			else
				pyenv install -s $2
				pyenv local $2
			fi
			eval "$(pyenv init -)"

			if [ ! -d ./.venv ]; then
				python -m venv .venv
				cp $(dirname $1)/activate.sh .
			fi
			source ./.venv/bin/activate

			if [ -n $VIRTUAL_ENV ]; then
				if [ -f ./$3 ]; then
					pip install --install-option="-UI" -r $3 2> /dev/null
				else
					pip install --install-option="-UI" -r $(dirname $1)/requirements.txt 2> /dev/null
				fi
			fi
		fi

		if [ ! -d ./.vscode ]; then
			mkdir .vscode
		fi
		cp $(dirname $1)/*.json ./.vscode
	else
		echo "     Not installed"
	fi
}

# Run Script ------------------------------------------------------------------#
VSCode_Python_Config $0 $1 $2 $3
