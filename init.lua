-- NEOVIM CONFIG MADE BY @me_kebab_man (DISCORD), @MeKebabMan (GITHUB)
-- Copyright MeKebabMan 2024 Mit License
-- NEOVIM CONFIG MADE BY @me_kebab_man (DISCORD), @MeKebabMan (GITHUB)

-- GLOBAL VARIABLES
vim.g.KebabVimPath = vim.fn.expand("~/.config/nvim/KebabVim/")
vim.g.NvimPath = vim.fn.expand("~/.config/nvim/")
vim.g.ReadMeTXT = "NVIM_README.txt"
vim.g.AutoUpdate = true

local os = require("os")

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

-- KEBAB VIM SET UP!
local function directory_exists(directory)
	local stat = vim.loop.fs_stat(vim.fn.expand(directory))
	return stat and stat.type == "directory"
end

if directory_exists(vim.fn.expand(tostring(vim.g.KebabVimPath))) then

	vim.opt.rtp:prepend(vim.fn.expand(tostring(vim.g.KebabVimPath)))

	package.path = package.path .. ";" .. vim.fn.expand(tostring(vim.g.KebabVimPath)) .. "/?.lua"

	local KebabVim_config = require("KebabVim_config")

	-- Plugin manager
	require("lazy").setup(KebabVim_config.plugins, {})

	local KebabVim_utils = require("KebabVim_utils")
	local plugin_module = require("plugin_module")
	local vim_options = require("vim_options")

	KebabVim_utils.StartUp()

	-- Vim options
	vim_options.SetKebabVimDefault()

	-- Plugins
	if KebabVim_config.Use_default_welcome_screen then
		plugin_module.alphanvim()
	end

	plugin_module.SetTheme("kanagawa")
	plugin_module.lualine()
	plugin_module.nvim_treesitter(KebabVim_config.treesitter)
	plugin_module.KebabVimCMP()
	plugin_module.KebabVimLSP(KebabVim_config.language_servers)
	plugin_module.KebabVimNone_ls()

	plugin_module.KebabVimFileExplorer("<C-e>", {
		window = {
			width = 25,
		},
	})
	plugin_module.Telescope()
	plugin_module.Autotag()
	plugin_module.KebabVimAutoPairs()
	plugin_module.KebabVim_SetUp_DefaultNotify()
	plugin_module.barbar()

	if KebabVim_config.Use_extra_plugins then
		require("Comment").setup({})

		require("gitsigns").setup({})

		plugin_module.which_key()

		if vim.g.AutoUpdate then
			if KebabVim_utils.UPDATE() then
				vim.notify("Failed to do a update check!", vim.log.levels.ERROR)
			end
		end
	end
else
	require("lazy").setup({
		{
			"rcarriga/nvim-notify",
		},
		{
			"maxmx03/solarized.nvim",
		},
		{
			"nvim-treesitter/nvim-treesitter",
		},
		{
			"goolord/alpha-nvim",
			dependencies = {
				"nvim-tree/nvim-web-devicons",
			}
		}
	}, {})

	vim.opt.termguicolors = true

	vim.notify = require("notify")

	vim.notify("KebabVim directory does not exist! Falling back!", vim.log.levels.ERROR)

	vim.cmd([[
		syntax enable
		set background=dark
		colorscheme solarized
		set number
		set cursorline
		set laststatus=3
	]])

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

		highlight = {
			enable = true,
		},
	})

	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")

	dashboard.section.header.val = {
		[[██╗░░██╗███████╗██████╗░░█████╗░██████╗░██╗░░░██╗██╗███╗░░░███╗  ░░██╗  ██╗░░██╗  ██╗░░]],
		[[██║░██╔╝██╔════╝██╔══██╗██╔══██╗██╔══██╗██║░░░██║██║████╗░████║  ░██╔╝  ╚██╗██╔╝  ╚██╗░]],
		[[█████═╝░█████╗░░██████╦╝███████║██████╦╝╚██╗░██╔╝██║██╔████╔██║  ██╔╝░  ░╚███╔╝░  ░╚██╗]],
		[[██╔═██╗░██╔══╝░░██╔══██╗██╔══██║██╔══██╗░╚████╔╝░██║██║╚██╔╝██║  ╚██╗░  ░██╔██╗░  ░██╔╝]],
		[[██║░╚██╗███████╗██████╦╝██║░░██║██████╦╝░░╚██╔╝░░██║██║░╚═╝░██║  ░╚██╗  ██╔╝╚██╗  ██╔╝░]],
		[[╚═╝░░╚═╝╚══════╝╚═════╝░╚═╝░░╚═╝╚═════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝  ░░╚═╝  ╚═╝░░╚═╝  ╚═╝░░]],
	}

	dashboard.section.buttons.val = {
	         dashboard.button( "e", "  New file (DEFAULT)" , ":ene <BAR> startinsert <CR>"),
	         dashboard.button( "q", "󰅚  Quit NVIM (DEFAULT)" , ":qa<CR>"),
	}

	alpha.setup(dashboard.opts)
end
