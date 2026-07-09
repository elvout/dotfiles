export GITSTATUS_NUM_THREADS=2
source "$HOME/.local/share/zsh/powerlevel10k/powerlevel10k.zsh-theme"
[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt append_history
setopt extendedhistory
setopt histignoredups
setopt histignorespace
setopt histverify

# Directory
setopt autocd
setopt autopushd
setopt pushdignoredups
setopt pushdminus
d() {
    if [[ -n "$1" ]]; then
        dirs "$@"
    else
        dirs -v | head -n 10
    fi
}

# Misc
setopt combiningchars
setopt interactivecomments
setopt longlistjobs
setopt noflowcontrol

# Completions
source $HOME/dotfiles/ls_colors
setopt completeinword
zmodload -i zsh/complist
WORDCHARS=''
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' matcher-list \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
    'r:|=*' \
    'l:|=* r:|=*'

autoload -Uz compinit
compinit -d "$HOME/.zcompdump"
bindkey -M menuselect '^[[Z' reverse-menu-complete

source "$HOME/dotfiles/profile"

source "$HOME/.local/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
