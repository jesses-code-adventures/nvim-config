-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use "nvim-telescope/telescope.nvim"

  use({
	  'rose-pine/neovim',
	  as = 'rose-pine',
  })

  use({
    "craftzdog/solarized-osaka.nvim",
    as = "solarized-osaka"
  })

  use({
      "IMOKURI/line-number-interval.nvim",
      as = "line-number-interval"
  })

  use({
      "folke/trouble.nvim",
      config = function()
          require("trouble").setup {
              icons = false,
              -- your configuration comes here
              -- or leave it empty to use the default settings
              -- refer to the configuration section below
          }
      end
  })


  use {
		"nvim-treesitter/nvim-treesitter",
		run = function() require("nvim-treesitter.install").update { with_sync = true } end
	}
  use("nvim-treesitter/playground")
  use "nvim-lua/plenary.nvim"
  use {
      "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { {"nvim-lua/plenary.nvim"} }
  }
  use("vrischmann/tree-sitter-templ")
  use("theprimeagen/refactoring.nvim")
  use("mbbill/undotree")
  use("tpope/vim-fugitive")
  use("nvim-treesitter/nvim-treesitter-context");
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
        end
  }
  use({
     "folke/neoconf.nvim",
    })
  use {
      "rafi/neoconf-venom.nvim",
      requires = { "nvim-lua/plenary.nvim" },
  }

  -- Debugger
  use 'mfussenegger/nvim-dap'
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  use "folke/neodev.nvim"
  use "theHamsta/nvim-dap-virtual-text"
  use "mfussenegger/nvim-dap-python"
  use "jay-babu/mason-nvim-dap.nvim"


  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},

          {'onsails/lspkind-nvim'}
	  }
  }

  use("folke/zen-mode.nvim")
  use("laytan/cloak.nvim")
  use("sbdchd/neoformat")

end)

