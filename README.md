# Dotfiles

## Step 1: Install `chezmoi` and clone dotfiles

[Requires homebrew to be installed on macOS.](https://brew.sh/)

```zsh
# macOS:
brew install chezmoi
# Ubuntu: https://www.chezmoi.io/install/#one-line-binary-install

chezmoi init https://github.com/hanneskaeufler/dotfiles.git
```

## Step 2: Edit config

```zsh
chezmoi cd && cp chezmoi.toml.example ~/.config/chezmoi/chezmoi.toml
vim ~/.config/chezmoi/chezmoi.toml
```

## Step 3: Profit

```zsh
chezmoi apply
```
