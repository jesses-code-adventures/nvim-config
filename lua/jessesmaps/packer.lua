-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use "nvim-telescope/telescope.nvim"

  --   use {
	 --  'nvim-telescope/telescope.nvim', tag = '0.1.0',
	 --  requires = { {'nvim-lua/plenary.nvim'} }
  -- }

  use({
	  'rose-pine/neovim',
	  as = 'rose-pine',
  })

  use {
      'olivercederborg/poimandres.nvim',
      as = 'poimandres',
      config = function()
          require('poimandres').setup {
            -- todo
          }
      end
  }

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
		-- :TSUpdate[Sync] doesn't exist until plugin/nvim-treesitter is loaded (i.e. not after first install); call update() directly
		run = function() require("nvim-treesitter.install").update { with_sync = true } end
	}
  use("nvim-treesitter/playground")
  use "nvim-lua/plenary.nvim"
  -- use "ThePrimeagen/harpoon"
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
  use("theprimeagen/vim-be-good");
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

