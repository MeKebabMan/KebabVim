-- NEOVIM CONFIG MADE BY @me_kebab_man (DISCORD), @MeKebabMan (GITHUB)
-- Copyright MeKebabMan 2024 Mit License
-- NEOVIM CONFIG MADE BY @me_kebab_man (DISCORD), @MeKebabMan (GITHUB)

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
vim.opt.rtp:prepend(vim.fn.expand("~/.config/nvim/KebabVim"))

-- KEBAB VIM CONFIG
local KebabVim_config = require("KebabVim.KebabVim_config")

-- Plugin manager
require("lazy").setup(KebabVim_config.plugins, {})

local KebabVim_utils = require("KebabVim.KebabVim_utils")
local plugin_module = require("KebabVim.plugin_module")
local vim_options = require("KebabVim.vim_options")

KebabVim_utils.StartUp()

-- Vim options
vim_options.SetKebabVimDefault()

-- Plugins
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
