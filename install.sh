#!/bin/bash
DEFAULT_THEME="oseda"

# Don't run as root
if [[ $EUID -ne 0 ]]; then
	# Check if zsh is installed
	ZSH_INSTALLED=$(dpkg -l | grep zsh)
	if [ ! -z "$ZSH_INSTALLED" -a "$ZSH_INSTALLED"!=" " ]; then
		# Check if oh-my-zsh is installed for current user
		if [ -d "~/.oh-my-zsh" ]; then
			echo "oh-my-zsh is not installed"
			sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"	
		else 
			# Install the theme in ~/.oh-my-zsh-custom
			mkdir -p ~/.oh-my-zsh-custom/themes
			echo "install themes in ~/.oh-my-zsh-custom/themes.."
			cp -rf themes/*.zsh-theme ~/.oh-my-zsh-custom/themes
			sed -i '/ZSH_CUSTOM_HOME=/c\ZSH_CUSTOM=$HOME/.oh-my-zsh-custom' ~/.zshrc
			echo "set theme $DEFAULT_THEME in ~/.zshrc.."
			sed -i '/ZSH_THEME=/c\ZSH_THEME="'$DEFAULT_THEME'"' ~/.zshrc
			echo "actualize zsh.."
			source ~/.zshrc	
		fi
	else
		echo "you need to install zsh: apt get install zsh"
	fi
else 
    echo "Please don't run as root"
    exit
fi
