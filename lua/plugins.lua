-- Source plugin and its configuration immediately
-- @param plugin String with name of plugin as subdirectory in 'pack'
local packadd = function(plugin)
  -- Add plugin. Using `packadd!` during startup is better for initialization
  -- order (see `:h load-plugins`). Use `packadd` otherwise to also force
  -- 'plugin' scripts to be executed right away.
  -- local command = vim.v.vim_did_enter == 1 and 'packadd' or 'packadd!'
  local command = 'packadd'
  vim.cmd(string.format([[%s %s]], command, plugin))

  -- Try execute its configuration
  -- NOTE: configuration file should have the same name as plugin directory
  pcall(require, 'ec.configs.' .. plugin)
end

-- Defer plugin source right after Vim is loaded
--
-- This reduces time before a fully functional start screen is shown. Use this
-- for plugins that are not directly related to startup process.
--
-- @param plugin String with name of plugin as subdirectory in 'pack'
local packadd_defer = function(plugin)
  vim.schedule(function() packadd(plugin) end)
end

packadd_defer('nvim-code-action-menu')
packadd_defer('nvim-lightbulb')
packadd_defer('lsp_signature')
packadd_defer('Comment')

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- general language support
  use('jose-elias-alvarez/null-ls.nvim')

  -- UI improvements
  use 'rcarriga/nvim-notify'
  use {
    'nvim-lualine/lualine.nvim',
  }
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", "hrsh7th/vim-vsnip", "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-nvim-lua", 'hrsh7th/cmp-path', 'hrsh7th/cmp-calc', 'f3fora/cmp-spell', 'hrsh7th/cmp-emoji'
    }
  }

  -- Version control
  use {
    'tanvirtin/vgit.nvim',
  }

  -- Editting goodies
  use({
    "kylechui/nvim-surround",
    tag = "*",
  })
  use 'echasnovski/mini.pairs'
  --
  -- Navigation
  use 'windwp/nvim-spectre'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
  }
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  }
  use {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {}
    end
  }
end)
