#! /usr/bin/env bash

export LANG=en_US.UTF-8

prepend_path() {
    [[ -d "$1" ]] || return

    case ":$PATH:" in
        *":$1:"*) ;;
        *) PATH="$1:$PATH" ;;
    esac
}

prepend_path /opt/homebrew/bin
prepend_path /Library/TeX/texbin
prepend_path /usr/local/cuda/bin
prepend_path "$HOME/.cargo/bin"
prepend_path "$HOME/.local/bin"

export PATH

# set bash-specific settings
if [[ "$SHELL" == *bash ]]; then
    export PS1="\[\033[33m\]\u\[\033[32m\]@\[\033[32m\]\h:\[\033[34m\]\w\[\033[34m\]\$ \[\033[m\]"
    # export LSCOLORS=ExFxBxDxCxegedabagacad

    shopt -s dotglob
    shopt -s expand_aliases
fi

export HISTCONTROL=ignoreboth

# set tabs to 4
tabs -4


# Compression settings
export ZSTD_NBTHREADS="$(nproc)"
export XZ_DEFAULTS="-T0 -v"

[[ -n "$BASH_VERSION" ]] && export SHELL="$(which bash)"
[[ -n "$ZSH_VERSION" ]] && export SHELL="$(which zsh)"

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
    if [[ -f /opt/ros/jazzy/setup.sh && -z "${AMENT_PREFIX_PATH:-}" ]]; then
        source /opt/ros/humble/setup."$(basename $SHELL)"
    fi

    if [[ "$SHELL" == *zsh ]]; then
        precmd() {
            source "$HOME/dotfiles/ros2env.sh"
        }
    fi
elif [[ -d /opt/ros/jazzy ]]; then
    export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

    if [[ -e $HOME/.cyclonedds.xml ]]; then
        export CYCLONEDDS_URI="file://$HOME/.cyclonedds.xml"
    fi

    if [[ -f /opt/ros/jazzy/setup.sh && -z "${AMENT_PREFIX_PATH:-}" ]]; then
        source "/opt/ros/jazzy/setup.$(basename $SHELL)"
    fi

    eval "$(register-python-argcomplete ros2)"
    eval "$(register-python-argcomplete colcon)"

    if [[ "$SHELL" == *zsh ]]; then
        precmd() {
            source "$HOME/dotfiles/ros2env.sh"
        }
    fi
fi


[[ -f "$HOME/dotfiles/secrets" ]] && source "$HOME/dotfiles/secrets"

source "$HOME/dotfiles/aliases"
