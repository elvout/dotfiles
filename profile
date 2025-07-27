#! /usr/bin/env bash

os="$(uname -s)"

# set path based on env
export PATH=~/.local/bin/:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin

[[ -d /Library/TeX/texbin ]] && PATH=/Library/TeX/texbin:$PATH
[[ -d /usr/local/go/bin ]] && PATH=/usr/local/go/bin:~/go/bin:$PATH
[[ -d ~/.cargo/bin ]] && PATH=~/.cargo/bin:$PATH
[[ -d /usr/local/cuda/bin ]] && PATH=/usr/local/cuda/bin:$PATH


# set bash-specific settings
if [[ "$(echo $SHELL)" =~ .*/bash ]]; then
    export PS1="\[\033[33m\]\u\[\033[32m\]@\[\033[32m\]\h:\[\033[34m\]\w\[\033[34m\]\$ \[\033[m\]"
    # export LSCOLORS=ExFxBxDxCxegedabagacad

    shopt -s dotglob
    shopt -s expand_aliases
fi

export HISTCONTROL=ignoreboth

# set tabs to 4
tabs -4


# macOS specific settings
if [[ "$os" == "Darwin" ]]; then
    source $HOME/dotfiles/ls_colors
fi


# Compression settings
export ZSTD_NBTHREADS="$(nproc)"
export XZ_DEFAULTS="-T0 -v"


[[ "$BASH_VERSION" != "" ]] && export SHELL=/usr/bin/bash
[[ "$ZSH_VERSION" != "" ]] && export SHELL=/usr/bin/zsh

# ROS settings
if [[ -e /.dockerenv ]] && [[ -s /.dockerenv ]]; then
    source /.dockerenv
elif [[ -d /opt/ros/noetic ]]; then
    source /opt/ros/noetic/setup."$(basename $SHELL)"

    if [[ -f $HOME/stretch_ws/devel/setup.sh ]]; then
        source $HOME/stretch_ws/devel/setup.zsh
    fi

    # Set ROS IP stuff
    if [[ "$SHELL" == *bash ]]; then
        PROMPT_COMMAND="source $HOME/dotfiles/ros1env.sh"
    elif [[ "$SHELL" == *zsh ]]; then
        preexec() {
            source "$HOME/dotfiles/ros1env.sh"
        }
    fi

    alias cb="catkin build --cmake-args -DCMAKE_BUILD_TYPE=Release -Wno-dev --"
elif [[ -d /opt/ros/humble ]]; then
    # On zsh, sourcing setup.zsh is a lot slower than setup.sh, but is required
    # for shell completions.
    source /opt/ros/humble/setup."$(basename $SHELL)"

    if [[ "$SHELL" == *zsh ]]; then
        precmd() {
            source "$HOME/dotfiles/ros2env.sh"
        }
    fi
fi


[[ -f "$HOME/dotfiles/secrets" ]] && source "$HOME/dotfiles/secrets"

source "$HOME/dotfiles/aliases"
