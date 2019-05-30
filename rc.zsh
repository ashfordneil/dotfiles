# List Plugins
source $ZPLUG_HOME/init.zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/cargo", from:oh-my-zsh
zplug "plugins/rust", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh
zplug "mafredri/zsh-async", from:github, defer:0
zplug "sindresorhus/pure", from:github
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "aperezdc/zsh-fzy"

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

# Tmux settings (seeing as the developers don't want to do this themselves)
alias tmux="tmux -f $HOME/.config/tmux/tmux.conf"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/neil/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/neil/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/neil/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/neil/google-cloud-sdk/completion.zsh.inc'; fi

# iterm shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# rust <3
source $HOME/.cargo/env

# fuzzy
zstyle :fzy:cd command fd --type d
zstyle :fzy:file command fd
bindkey '\ec' fzy-cd-widget
bindkey '^T' fzy-file-widget
bindkey '^R' fzy-history-widget

# git
alias gdog='git log --all --decorate --oneline --graph'
