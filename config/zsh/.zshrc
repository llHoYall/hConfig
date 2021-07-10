# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="random"
#ZSH_THEME="crcandy"
#ZSH_THEME="dst"
#ZSH_THEME="fino-time"
#ZSH_THEME="pmcgee"
#ZSH_THEME="tjkirch"
#ZSH_THEME="ys"
ZSH_THEME="hoya"

ZSH_DISABLE_COMPFIX="true"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	# git
	# fasd
	# fzf
	tmux
	# tmuxinator
	# virtualenv
	zsh-syntax-highlighting
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# HoYa #########################################################################
# LS_COLORS -------------------------------------------------------------------#
export LS_COLORS=$LS_COLORS:"di=34:*.sh=32:*.ps1=32:ow=34:"

# Python ----------------------------------------------------------------------#
export VIRTUAL_ENV_DISABLE_PROMPT="true"

# Go --------------------------------------------------------------------------#
export GOPATH=$HOME/go

# NVM -------------------------------------------------------------------------#
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

# fzf -------------------------------------------------------------------------#
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tmux ------------------------------------------------------------------------#
if [ -z "$TMUX" ]; then
	tmux attach -t hTMUX || tmux new -s hTMUX
fi

# Path ------------------------------------------------------------------------#
export PATH = $PATH:$GOPATH/bin

# Aliasing --------------------------------------------------------------------#
alias ll="ls -ahlF"

alias ga="git add"
alias gaa="git add --all"
alias gb="git branch -vv"
alias gbr="git branch -r"
alias gco="git checkout"
alias gcp="git cherry-pick"
alias gcmm="git commit"
alias gcmm!="git commit --amend"
alias gcf="git config"
alias gcfg="git config --global"
alias gcfl="git config --local"
alias gd="git diff"
alias gf="git fetch -p"
alias gh="git help"
alias glg="git log --oneline --graph -50"
alias glge="git log --graph --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' -20"
alias gmg="git merge"
alias gpl="git pull -p"
alias gpu="git push"
alias grm="git remote -v"
alias grb="git rebase"
alias grst="git reset"
alias grv="git revert"
alias gsh="git show"
alias gsts="git stash"
alias gst="git status"
alias gs="git switch"
alias gt="git tag"
