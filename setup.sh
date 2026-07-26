#! /usr/bin/env bash

# prereqs: git, curl, zsh

set -e

ZSH_PLUGINS="$HOME/.local/share/zsh"
mkdir -p "$ZSH_PLUGINS"

if [[ ! -d "$ZSH_PLUGINS/zsh-syntax-highlighting" ]]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_PLUGINS/zsh-syntax-highlighting"
fi

if [[ ! -d "$ZSH_PLUGINS/powerlevel10k" ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_PLUGINS/powerlevel10k"
fi

if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

if [[ "$(uname -sm)" == "Linux x86_64" ]]; then
    if [[ ! -f "$HOME/.cargo/bin/cargo-binstall" ]]; then
        curl -L --proto '=https' --tlsv1.2 -sSf \
            https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh \
            | bash
    fi

    "$HOME/.cargo/bin/cargo-binstall" \
        --targets x86_64-unknown-linux-musl \
        --strategies crate-meta-data \
        bat fd-find hyperfine

    "$HOME/.cargo/bin/cargo-binstall" \
        --targets x86_64-unknown-linux-musl \
        --strategies crate-meta-data \
        --bin-dir 'dua-v{ version }-{ target }/{ bin }{ binary-ext }' \
        dua-cli

    "$HOME/.cargo/bin/cargo-binstall" \
        --targets x86_64-unknown-linux-musl \
        --strategies crate-meta-data \
        --bin-dir 'delta-{ version }-{ target }/{ bin }{ binary-ext }' \
        git-delta
fi

rm -f $HOME/.zshrc && ln -rs .zshrc $HOME/.zshrc
rm -f $HOME/.p10k.zsh && ln -rs .p10k.zsh $HOME/.p10k.zsh
rm -f $HOME/.tmux.conf && ln -rs .tmux.conf $HOME/.tmux.conf
rm -f $HOME/.vimrc && ln -rs .vimrc $HOME/.vimrc
if [[ ! -f $HOME/.config/htop/htoprc ]]; then
    mkdir -p $HOME/.config/htop
    ln -s "$(realpath .config/htop/htoprc)" $HOME/.config/htop/htoprc
fi

if [[ "$SHELL" != */zsh ]]; then
    echo run chsh -s /bin/zsh "$(whoami)"
    exec zsh
fi
