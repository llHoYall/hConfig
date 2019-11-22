# Z-Shell

## Installation

### > MAC

> $ brew install zsh

### > Linux

> $ sudo apt install -y zsh

### Oh-My-Zsh

> $ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## Configuration

### zsh Plugins

#### zsh-syntax-highlighting

1. Install the plugin

> $ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

2. Add the plugin to `~/.zshrc` file.

```zsh
plugins=(
	[plugins...]
	zsh-syntax-highlighting
)
```

3. Restart `zsh`

#### zsh-autosuggestions

1. Install the plugin

> $ git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

2. Add the plugin to `~/.zshrc` file.

```zsh
plugins=(
	[plugins...]
	zsh-autosuggestions
)
```

3. Restart `zsh`
