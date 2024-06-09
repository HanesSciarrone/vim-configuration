# vim-configuration
This repository is intended to show you the configuration applied by me in neovim to use it as an IDE.


## Packages indtalled to work pluggins

**Debian**

- sudo pacman -S xclip              (clipboard)
- sudo pacman -S ripgrep            (Telescope)
- sudo pacman -S python-virtualenv  (nvim-lsp-installer)
- sudo pacman -S clang              (lspconfig: clang)
- sudo pacman -S cmake              (lspconfig: cmake)

## Font configuration

We have to install necessary font that neovim shows the symbols on the status bar, to do this please following the steps on this repository

sudo pacman -S ttf-hack-nerd

## Configuration jsonls

The vscode-json-language-server isn't included in the build-in snippets of Neovim therefore we have to install the language server with AUR repository*. 

```
git clone https://aur.archlinux.org/vscode-langservers-extracted.git
cd vscode-langservers-extracted
makepkg
sudo pacman -U vscode-langservers-extracted-4.10.0-1-any.pkg.tar.zst
```

