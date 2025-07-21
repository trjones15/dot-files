This is a folder containing my nvim configurations. 

Usage:
1. Download Repo
2. Go to config/init.lua, comment out gruvbox, and save
3. Reopen neovim and type in ':PackerInstall' This will install gruvbox.
4. Go back to where you commented out gruvbox and uncomment it
5. Install go-pls binaries with :GoInstallBinaries
6. Install python language server with ```npm i -g pyright```
7. Install Lua language server ```https://github.com/LuaLS/lua-language-server/releases```
8. Install lua tree-sitter with ```:TSUpdate lua```
9. Install vim tree-sitter with ```:TSUpdate vim```
10. Install ripgrep (It is necessary for fuzzy grep aka the telescope plugin)
11. Change pyenv directory in plugins/configs/nvim-lspconfig.lua to the output of 'which python'
12. To get fonts to work, download Droid Sans Mono Nerd Font Complete.otf from https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf and add it as a font to Mac. Then add it as a font to iterm2 or your editor

Rust Setup (Don't install with ASDF):
1. Download rust: `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`
2. Run the following command `rustup component add rust-src rustfmt clippy rust-analyzer`
