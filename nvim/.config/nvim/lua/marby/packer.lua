-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- LSP
  use {
     "neovim/nvim-lspconfig",
     "williamboman/mason.nvim",
     "jose-elias-alvarez/null-ls.nvim",
     "jayp0521/mason-null-ls.nvim",
  }

  -- Speed Up Neovim
  use 'lewis6991/impatient.nvim'

  -- CMP Stuff
  use {
     'hrsh7th/cmp-nvim-lsp',
     'hrsh7th/cmp-buffer',
     'hrsh7th/cmp-path',
     'hrsh7th/cmp-cmdline',
     'hrsh7th/nvim-cmp',
  }

  -- Snipping Tool
  use({"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*"})

  -- ToggleTerm - Do I really need this? - test it
  use { "akinsho/toggleterm.nvim" }

  -- Color scheme
  use 'folke/tokyonight.nvim'

  -- Post-install/update hook with neovim command
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Use dependency and run lua function after load
  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}

  use {
      'nvim-tree/nvim-tree.lua',
      requires = {
          'nvim-tree/nvim-web-devicons', -- optional, for file icons
      },
      -- tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
end)
