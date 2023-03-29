-- Automatically installs packer.nvim

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

-- Packer Commands
-- You must run this or `PackerSync` whenever you make changes to your plugin configuration
-- Regenerate compiled loader file
-- :PackerCompile

-- Remove any disabled or unused plugins
-- :PackerClean

-- Clean, then install missing plugins
-- :PackerInstall

-- Clean, then update and install plugins
-- :PackerUpdate

-- Perform `PackerUpdate` and then `PackerCompile`
-- :PackerSync

-- Loads opt plugin immediately
-- :PackerLoad completion-nvim ale

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Language Server Protocol
    use 'neovim/nvim-lspconfig'
    -- Language Server Protocol - Autocompletion
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    -- Language Server Protocol - Better Syntax Highlighting
    use 'nvim-treesitter/nvim-treesitter'

    -- Language Specific Plugins
    -- Language Specific Plugins - Golang
    use 'fatih/vim-go' -- need to run :GoInstallBinaries to load everything

    -- File Navigation
    -- File Navigation - File Directory
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
    }
    -- File Navigation - Fuzzy File Finder
    use {
        'nvim-telescope/telescope.nvim', -- ripgrep is required for fuzzy grep
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } -- needed for faster fuzzy file finding
    -- File Navigation - git status
    use 'airblade/vim-gitgutter'

    -- Text Manipulation
    use 'scrooloose/nerdcommenter'

    -- General
    use 'morhetz/gruvbox' -- color scheme
    use 'vim-airline/vim-airline'

    -- Still to do 
    -- 0. automatically have nvim-tree show up 
    -- 5. work on a new shell https://starship.rs/
    -- 6. source with dotfiles direcotry
end)
