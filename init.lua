-- NEOVIM CONFIG MADE BY @me_kebab_man (DISCORD), @MeKebabMan (GITHUB)
-- Copyright MeKebabMan 2024 Mit License
-- NEOVIM CONFIG MADE BY @me_kebab_man (DISCORD), @MeKebabMan (GITHUB)

-- KEBAB VIM GITHUB REPOSITORY: https://github.com/MeKebabMan/KebabVim
-- SUPPORTED OS:
-- Linux / Unix
-- Mac OS (Not tested)
-- WSL+ with Windows
-- UNSUPPORTED OS:
-- Windows (WORKING ON IT!)

-- LOAD USER VARIABLES!
local function GetVariables(_config_file)
	if _config_file and type(_config_file) ~= "string" then
		vim.notify("Could not parse Kebabvim config", vim.log.levels.ERROR, {
			title = "ERROR",
		})
		return false
	end

	local config_file = vim.fn.expand(tostring(_config_file))

	-- read the file
	local file = io.open(config_file, "r")
	if not file then
		vim.notify("Could not parse Kebabvim config", vim.log.levels.ERROR, {
			title = "ERROR",
		})
		return false
	end

	local content = file:read("*all")
	file:close()

	-- parse the file content
	local data = {}
	for line in content:gmatch("[^\r\n]+") do
		local key, value = line:match("([^=]+)=([^=]+)")
		if key and value then
			data[key:match("^%s*(.-)%s*$")] = value:match("^%s*(.-)%s*$")
		end
	end

	-- Convert all the variables into readable data
	for key, value in pairs(data) do
		if key and value then
			if key and string.lower(tostring(value)) == string.lower(tostring("true")) then
				vim.g[key] = true
			elseif key and string.lower(tostring(value)) == string.lower(tostring("false")) then
				vim.g[key] = false
			elseif key and value:sub(1, 1) == '"' and value:sub(-1) == '"' then
				vim.g[key] = tostring(value:sub(2, -2))
			elseif key and string.lower(tostring(value)) == string.lower(tostring("null")) then
				vim.g[key] = nil
			elseif key and string.lower(value:sub(1, 1)) == string.lower("P") then
				if value:sub(2, 2) == '"' and value:sub(-1) == '"' then
					vim.g[key] = vim.fn.expand(tostring(value:sub(3, -2)))
				end
			else
				vim.g[key] = value
			end
		end
	end

	return true
end

local os = require("os")

GetVariables("~/.config/nvim/KebabVim.config")

-- Lazy.nvim plugin manager
-- PLUGIN MANAGER: https://github.com/folke/lazy.nvim
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

-- SET DEFAULT VARIABLES
if not vim.g.NvimPath then
	vim.g.NvimPath = vim.fn.expand("~/.config/nvim/")
end
if not vim.g.KebabVimPath then
	vim.g.KebabVimPath = vim.fn.expand("~/.config/nvim/KebabVim/")
end
if not vim.g.AutoUpdate then
	vim.g.AutoUpdate = true
end
if not vim.g.UseDefaultHomeScreen then
	vim.g.UseDefaultHomeScreen = true
end
if not vim.g.ReadMeTXT then
	vim.g.ReadMeTXT = "NVIM_README.txt"
end
if not vim.g.GitBranch then
	vim.g.GitBranch = "main"
end
if not vim.g.UseExtraPlugins then
	vim.g.UseExtraPlugins = true
end

if directory_exists(vim.fn.expand(tostring(vim.g.KebabVimPath))) then
	if not vim.g.KebabVimPath or not vim.g.NvimPath then
		return
	end

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

	if vim.g.UseDefaultHomeScreen == true then
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

	if vim.g.UseExtraPlugins == true then
		require("Comment").setup({})

		require("gitsigns").setup({})

		plugin_module.which_key()

		if vim.g.AutoUpdate == true then
			if not KebabVim_utils.UPDATE() then
				vim.notify("Failed to do a update check!", vim.log.levels.ERROR, {
					title = "ERROR",
				})
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
			},
		},
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
		dashboard.button("e", "  New file (DEFAULT)", ":ene <BAR> startinsert <CR>"),
		dashboard.button("q", "󰅚  Quit NVIM (DEFAULT)", ":qa<CR>"),
	}

	alpha.setup(dashboard.opts)
end
