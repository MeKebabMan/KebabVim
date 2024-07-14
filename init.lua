-- NEOVIM CONFIG MADE BY @me_kebab_man (DISCORD), @MeKebabMan (GITHUB)
-- Copyright MeKebabMan 2024 Mit License
-- NEOVIM CONFIG MADE BY @me_kebab_man (DISCORD), @MeKebabMan (GITHUB)

-- CHECK FOR UPDATES!!

local function is_update_needed()
	local handle = io.popen("cd ~/.config/nvim/ && git remote update && git status -uno")
	if handle == nil then return false end
	local result = handle:read("*a");
	handle:close()

	if result:match("Your branch is behind") then
		return true
	end
	return false
end

local function update_and_exit()
	if is_update_needed() then
		os.execute("~/.config/nvim/Install.sh")
		vim.cmd("qa!");
	end
end

update_and_exit()

-- CHECK FOR UPDATES!!

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- PLUGINS

local plugins = {
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
}

-- SET UP PLUGIN MANAGER

require("lazy").setup(plugins, {})

-- SET COLOR SCHEME & VIM OPTIONS

vim.cmd("colorscheme kanagawa")

vim.cmd([[

set number
set cursorline

set laststatus=3

]])

-- NVIM TREESITTER FOR SYNTAX HIGHLIGHTING

require("nvim-treesitter").setup()
require("nvim-treesitter.configs").setup({
	ensure_installed = {
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
	},

	auto_install = true,

	highlight = {
		enable = true,
	},
})

-- LSP

local language_servers = {
	"lua_ls",
	"tsserver",
	"pyright",
	"clangd",
	"html",
	"cssls",
	"jsonls",
	"yamlls",
	"csharp_ls",
}

require("mason").setup({})

require("mason-lspconfig").setup({
	ensure_installed = language_servers,
})

local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = "text_symbol",
			maxwidth = 50,
			ellipsis_char = "...",
			show_labelDetails = true,

			---@diagnostic disable-next-line: unused-local
			before = function(entry, vim_item)
				return vim_item
			end,
		}),
	},
})

require("luasnip.loaders.from_vscode").lazy_load()

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, server in pairs(language_servers) do
	lspconfig[server].setup({
		capabilities = capabilities,
	})
end

vim.keymap.set("n", "<C-x>", vim.lsp.buf.hover, {})
vim.keymap.set({ "n", "v" }, "<C-c>", vim.lsp.buf.code_action, {})

-- None ls

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.clang_format,
	},
})

vim.keymap.set("n", "<space>c", vim.lsp.buf.format, {})

-- Neotree

require("neo-tree").setup({
	window = {
		width = 25,
	},
})

vim.keymap.set("n", "<C-e>", ":Neotree filesystem reveal left<CR>", {})

-- Lualine

require("lualine").setup({
	options = {
		theme = "auto",
	},
})

-- Telescope

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-g>f", builtin.find_files, {})
vim.keymap.set("n", "<C-g>g", builtin.live_grep, {})
vim.keymap.set("n", "<C-g>b", builtin.buffers, {})
vim.keymap.set("n", "<C-g>h", builtin.help_tags, {})

require("telescope").setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
})

require("telescope").load_extension("ui-select")

-- Auto pairs & auto tag
require("nvim-ts-autotag").setup({})
require("nvim-autopairs").setup({})
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
