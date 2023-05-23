#! /usr/bin/env bash

# prereqs: git, wget, zsh

if [[ ! -d $HOME/.oh-my-zsh ]]; then
    yes | sh -c "CHSH=yes RUNZSH=no $(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    # after this command runs, we're in a new zsh shell
fi

if [[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-completions ]]; then
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
fi

if [[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

if [[ ! -d $HOME/.oh-my-zsh/custom/themes/powerlevel10k ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

rm -f $HOME/.zshrc && ln -rs .zshrc $HOME/.zshrc
rm -f $HOME/.p10k.zsh && ln -rs .p10k.zsh $HOME/.p10k.zsh
rm -f $HOME/.tmux.conf && ln -rs .tmux.conf $HOME/.tmux.conf
