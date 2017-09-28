# List Plugins
source $ZPLUG_HOME/init.zsh
zplug "plugins/git", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh
zplug "mafredri/zsh-async", from:github, defer:0
zplug "sindresorhus/pure", from:github
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Install and Load Plugins
if ! zplug check --verbose; then
	printf "Install zplug plugins? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi
zplug load

# Terminal Settings
bindkey -v
export TERM=xterm-256color
