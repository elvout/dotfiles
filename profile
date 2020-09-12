#! /usr/bin/env bash

os="$(uname -s)"
utlab=false
[[ -x /usr/local/bin/cshosts ]] && utlab=true


# set path based on env

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin

[[ "$os" == "Darwin" ]] && PATH=/Library/TeX/texbin:$PATH

PATH=~/Applications/bin:~/bin:~/.local/bin:~/.cargo/bin:$PATH

[[ "$utlab" == true ]] && PATH=/u/gheith/public/qemu_5.1.0/bin:$PATH


# set bash-specific settings
if [[ "$(echo $SHELL)" =~ .*/bash ]]; then
    export PS1="\[\033[33m\]\u\[\033[32m\]@\[\033[32m\]\h:\[\033[34m\]\w\[\033[34m\]\$ \[\033[m\]"
    # export LSCOLORS=ExFxBxDxCxegedabagacad

    shopt -s dotglob
    shopt -s expand_aliases
fi


# set tabs to 4
tabs -4


# brew bash completions on macos
if [[ "$os" == "Darwin" ]] && [[ "$(echo $SHELL)" =~ .*/bash ]]; then
    if [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]]; then
        source "/usr/local/etc/profile.d/bash_completion.sh"
    fi

    if [[ -d /usr/local/etc/bash_completion.d ]]; then
        for file in /usr/local/etc/bash_completion.d/*; do
            source "$file"
        done
    fi
fi
