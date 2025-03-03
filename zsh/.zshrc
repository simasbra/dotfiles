#!/usr/bin/env zsh

# auto complete
autoload -U compinit; compinit
_comp_options+=(globdots) # with hidden files

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
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# pure prompt
fpath+=($HOME/.config/zsh/pure)
autoload -U promptinit; promptinit
prompt pure

# Alacritty completions
fpath+=${ZDOTDIR:-~}/.zsh_functions
