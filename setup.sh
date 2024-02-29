#! /usr/bin/env bash

# prereqs: git, curl, zsh

set -e

if [[ ! -d $HOME/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if [[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

if [[ ! -d $HOME/.oh-my-zsh/custom/themes/powerlevel10k ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

if [[ ! -d $HOME/.tmux/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if ! command -v cargo &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

    # Build various rust-based tools from source.
    # Statically link with musl so binaries work in containers.
    # TODO: There's surely a way to get the latest binaries from github.
    if [[ "$(uname -sm)" == "Linux x86_64" ]]; then
        # Assume ubuntu for now
        sudo apt install --yes make musl-tools
        ~/.cargo/bin/rustup target add x86_64-unknown-linux-musl

        ~/.cargo/bin/cargo install \
            --target x86_64-unknown-linux-musl \
            bat dua-cli fd-find git-delta hyperfine
    fi

fi

rm -f $HOME/.zshrc && ln -rs .zshrc $HOME/.zshrc
rm -f $HOME/.p10k.zsh && ln -rs .p10k.zsh $HOME/.p10k.zsh
rm -f $HOME/.tmux.conf && ln -rs .tmux.conf $HOME/.tmux.conf
rm -f $HOME/.vimrc && ln -rs .vimrc $HOME/.vimrc

echo run chsh -s /bin/zsh "$(whoami)"
exec zsh
