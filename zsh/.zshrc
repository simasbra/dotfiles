#!/usr/bin/env zsh

# auto complete
autoload -U compinit
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-$ZSH_VERSION
_comp_options+=(globdots) # with hidden files

# history
[ -d "$XDG_STATE_HOME"/zsh ] || mkdir -p "$XDG_STATE_HOME"/zsh
HISTFILE="$XDG_STATE_HOME"/zsh/history
setopt HIST_IGNORE_DUPS

# completion cache
[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache

# case insensitive path completion
zstyle ':completion:*' matcher-list 'm:{a-zA-z}={A-Za-z}'
zstyle ':completion:*' menu select

# vim motions
bindkey -v
export KEYTIMEOUT=1

# colemak replacements normal mode
bindkey -M vicmd "J" forward-word         # Swap J with E
bindkey -M vicmd "j" vi-forward-word      # Swap j with e
bindkey -M vicmd "N" run-help             # Swap N with K
bindkey -M vicmd "n" down-line-or-history # Swap n with j
bindkey -M vicmd "e" forward-char         # Swap e with l
bindkey -M vicmd "l" up-line-or-history   # Swap l with k

# syntax highlighting
case "$(uname -s)" in
	Linux)
		source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # linux
		;;
	Darwin)
		source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # macos
		;;
esac

# pure prompt
fpath+=($HOME/.config/zsh/pure)
autoload -U promptinit
promptinit
prompt pure
PURE_PROMPT_SYMBOL=">"
PURE_PROMPT_VICMD_SYMBOL="<"

# node shit
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
