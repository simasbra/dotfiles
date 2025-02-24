#!/usr/bin/env zsh

# auto complete
autoload -U compinit; compinit
# with hidden files
_comp_options+=(globdots)
# spelling correction
setopt CORRECT
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
bindkey -M vicmd "E" vi-join              # Swap E with J
bindkey -M vicmd "e" forward-char         # Swap e with l
bindkey -M vicmd "K" search-backward      # Swap K with N
bindkey -M vicmd "k" search-forward       # Swap k with n
bindkey -M vicmd "l" up-line-or-history   # Swap l with k

# change cursor depending on mode (visual vs normal)
cursor_mode() {
    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    zle-line-init() {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}
cursor_mode

# syntax highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# pure prompt
fpath+=($HOME/.config/zsh/pure)
autoload -U promptinit; promptinit
prompt pure

