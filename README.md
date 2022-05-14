# My Neovim Config

## Prerequisites

- Nvimpager

```
brew install scdoc
```

Clone the repo:
```
git clone https://github.com/lucc/nvimpager.git
cd nvimpager
make PREFIX=$HOME/.local install
```
Then add to your `~/.zshrc`:
```
if [[ "$(command -v nvim)" ]]; then
    export EDITOR='nvim'
    export SUDO_EDITOR=nvim
    export MANPAGER='nvim +Man!'
    # export PAGER=nvimpager
    # export MANPAGER=nvimpager
    export MANWIDTH=999
fi
```
- Misc CLI Tools
```arch -arm64 brew install gnu-sed```

## Try out this config

Make sure to remove or move your current `nvim` directory

Run `nvim` and wait for the plugins to be installed 

**NOTE** (You will notice treesitter pulling in a bunch of parsers the next time you open Neovim) 


each video will be associated with a branch so checkout the one you are interested in

## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```

You'll probably notice you don't have support for copy/paste also that python and node haven't been setup

So let's fix that

First we'll fix copy/paste

- On mac `pbcopy` should be builtin

- On Ubuntu

  ```
  sudo apt install xsel
  ```

- On Arch Linux

  ```
  sudo pacman -S xsel
  ```

Next we need to install python support (node is optional)

- Neovim python support

  Create a venv named `neovim`
  ```
  conda create -n neovim python=3
  conda activate neovim
  pip install pynvim
  ```
  Then update the value of `vim.g.python3_host_prog` in `~/.config/nvim/lua/user/options.lua+`.

- Neovim node support

  ```
  npm i -g neovim
  ```

- LSP and Linters
  Run the following:
  ```
  brew install go zoxide rg fd fzf wget yarn
  brew install vint shellcheck jsonlint yamllint
  brew install tflint ansible-lint tidy-html5 proselint write-good

  Lorem ipsum dolor
  ```

## Fonts

- [A nerd font](https://github.com/ryanoasis/nerd-fonts)

- [codicon](https://github.com/microsoft/vscode-codicons/raw/main/dist/codicon.ttf)
- [An emoji font](https://github.com/googlefonts/noto-emoji/blob/main/fonts/NotoColorEmoji.ttf)
After moving fonts to `~/.local/share/fonts/`

Run: `$ fc-cache -f -v`


<!-- arch -arm64 brew install --cask alacritty -->
<!-- arch -arm64 brew install tmux --HEAD -->
<!-- arch -arm64 brew install rust npm pyright tree exa -->
<!-- brew install bash -->
<!-- nrew install --HEAD universal-ctags -->
<!-- arch -arm64 brew reinstall -s tmux --fetch-HEAD -->
<!-- arch -arm64 brew reinstall -s tmux -->
<!-- arch -arm64 brew reinstall -s neovim -->
<!-- brew install iterm2 -->
<!-- brew tap homebrew/cask-fonts && brew install --cask font-source-code-pro -->
<!-- brew install --cask font-hack-nerd-font -->
<!-- brew install --cask font-firamono-nerd-font -->
<!-- brew install --cask font-fira-nerd-font -->
<!-- brew install --cask font-fira-code-nerd-font -->
<!-- brew install --cask font-fira-mono-nerd-font -->
<!-- brew install --cask font-inconsolata--nerd-font -->
<!-- brew install --cask font-inconsolata-nerd-font -->
<!-- brew install cdargs bat -->
<!-- brew install --cask font-jetbrains-mono-nerd-font -->
<!-- brew install --cask font-roboto-mono-nerd-font -->
<!-- brew install --cask font-meslo-nerd-font -->
<!-- brew install git -->
<!-- brew install --HEAD alacritty -->
<!-- brew install --HEAD neovim -->
<!-- brew install cdargs bat -->
<!-- brew install rg -->
<!-- brew install ag -->
<!-- brew install romkatv/powerlevel10k/powerlevel10k -->
<!-- brew install --HEAD tmux -->
<!-- brew uninstall powerlevel10k && arch -arm64 brew install --HEAD powerlevel10k -->
<!-- arch -arm64 brew install powerlevel10k -->
<!-- brew install tldr -->
<!---->

cargo install stylua prettier black
python -m pip install pycodestyle pyflakes flake8 mypy
pip install -U prettier black flake8 mypy jedi

-- git clone alacritty-themes !!!
