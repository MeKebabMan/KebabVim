local KebabVim_config = {}

-- PLUGINS
KebabVim_config.plugins = {
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		priority = 1000,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim",
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"onsails/lspkind.nvim",
		priority = 1000,
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
		},
		version = "v2.*",
		build = {
			"make install_jsregexp",
		},
		priority = 1000,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
			"nvim-lua/plenary.nvim",
		},
		priority = 1000,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
	},
	{
		"windwp/nvim-ts-autotag",
	},
	{
		"rcarriga/nvim-notify",
	},
	{
		"romgrk/barbar.nvim",
	},
	{

		"IogaMaster/neocord",
		event = "VeryLazy",
	},
	{
		"numToStr/Comment.nvim",
	},
	{
		"lewis6991/gitsigns.nvim",
	},
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		opts = {},
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"goolord/alpha-nvim",
	},
	{
		"nvim-lua/plenary.nvim",
	}
}

-- LANGUAGE SERVERS
KebabVim_config.language_servers = {
	"lua_ls",
	"tsserver",
	"html",
	"cssls",
	"jsonls",
	"yamlls",
	"clangd",
	"pyright",
	"csharp_ls",
	"cmake",
}

-- TREESITTER SYNTAX 
KebabVim_config.treesitter = {
	"lua",
	"c",
	"markdown",
	"vim",
	"vimdoc",
	"query",
	"typescript",
	"javascript",
	"html",
	"css",
	"json",
	"yaml",
	"xml",
	"c_sharp",
}


return KebabVim_config
