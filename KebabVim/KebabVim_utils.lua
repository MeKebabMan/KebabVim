local KebabVim_utils = {}

function KebabVim_utils.StartUp()
	vim.o.background = "dark"
	vim.opt.termguicolors = true

	vim.notify = require("notify")

	vim.g.mapleader = "C"
end

-- WARNING: MAY BREAK!
function KebabVim_utils.UPDATE()
	if not vim.g.ReadMeTXT or not vim.g.NvimPath then
		return false
	end

	local job = require("plenary.job")

	local output = {}

	job:new({
		command = "git",
		args = {"status", "--porcelain"},
		cwd = vim.fn.expand(tostring(vim.g.NvimPath)),
		on_stdout = function (_, data)
			table.insert(output, data)
		end
	}):sync()

	local changes = output;
	if #changes > 0 then

		vim.notify("KebabVim repo and this repo is not matching Preparing to update! DISABLE THIS FEATURE IN INIT.LUA", vim.log.levels.INFO)

		local output_pull = {}

		-- PULLING NEW CONTENT FROM THE REPOSITORY!
		job:new({
			command = "git",
			args = {"pull", "origin", "main"},
			cwd = vim.fn.expand(tostring(vim.g.NvimPath)),
			on_stdout = function (_, data)
				table.insert(output, data)
			end,
			on_stderr = function (_, data)
				table.insert(output, data)
			end
		}):sync()

		if #output_pull > 0 then
			vim.notify("Update successfully installed!", vim.log.levels.INFO)
			vim.cmd("e " .. vim.fn.expand(tostring(vim.g.NvimPath)) .. tostring(vim.g.ReadMeTXT))
		else
			vim.notify("Failed to update: "..tostring(output_pull)..".\nThis may be because this config has been changed.\nIf so then please disable this feature in INIT.LUA.\nI am still working on it SORRY!\nPlease post any issues in the repository.\nThank you!", vim.log.levels.ERROR)
			return false
		end

	end

	return true
end

return KebabVim_utils
