local KebabVim_utils = {}

function KebabVim_utils.StartUp()
	vim.o.background = "dark"
	vim.opt.termguicolors = true

	vim.notify = require("notify")

	vim.g.mapleader = "C"
end

return KebabVim_utils
