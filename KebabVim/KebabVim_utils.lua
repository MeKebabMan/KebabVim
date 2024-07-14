local KebabVim_utils = {}

function KebabVim_utils.StartUp()
	vim.notify = require("notify")

	vim.notify("Welcome to KebabVim!", "Welcome")
end

return KebabVim_utils
