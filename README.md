# vim-configuration
This repository is intended to show you the configuration applied by me in neovim to use it as an C/C++ IDE.


## Packages indtalled to work pluggins

**Debian**

- sudo apt install xclip (clipboard)
- sudo apt install ripgrep (Telescope)
- sudo apt install python3-venv (nvim-lsp-installer)
- sudo apt install clangd (lspconfig: clangd)
- sudo apt install cmake (lspconfig: cmake)

## Font configuration

We have to install necessary font that neovim shows the symbols on the status bar, to do this please following the steps on this repository

https://github.com/ryanoasis/nerd-fonts#font-installation

## Configuration jsonls

The vscode-json-language-server isn't included in the build-in snippets of Neovim therefore we have to install the language server with **npm**. For install **npm** we should execute the command line:

```
sudo apt install npm
```

Then, we install the language server with 

```
npm i -g vscode-langservers-extracted
```
