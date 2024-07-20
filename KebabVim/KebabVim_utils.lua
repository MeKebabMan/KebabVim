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

	local fetch_data = {}
	local diff_output = {}
	local pull_output = {}

	job:new({
		command = "git",
		args = { "fetch", "--all" },
		cwd = vim.fn.expand(tostring(vim.g.NvimPath)),
		on_stdout = function(_, data)
			table.insert(fetch_data, data)
		end,
		on_stderr = function(_, data)
			table.insert(fetch_data, data)
		end,
	}):sync()

	job:new({
		command = "git",
		args = { "diff", "--name-only", "HEAD", "origin/main" },
		cwd = vim.fn.expand(tostring(vim.g.NvimPath)),
		on_stdout = function(_, data)
			if data and data ~= "" then
				table.insert(diff_output, data)
			end
		end,
		on_stderr = function(_, data)
			table.insert(diff_output, data)
		end,
	})

	if #diff_output > 0 then
		vim.notify(
			"Difference found between repositories.. Preparing to update!\nDISABLE FEATURE AT INIT.LUA",
			vim.log.levels.INFO
		)

		job:new({
			command = "git",
			args = { "pull", "origin", "main" },
			cwd = vim.fn.expand(tostring(vim.g.NvimPath)),
			on_stdout = function(_, data)
				table.insert(pull_output, data)
			end,
			on_stderr = function(_, data)
				table.insert(pull_output, data)
			end,
		}):sync()

		if #pull_output > 0 then
			vim.notify("Update successfull!", vim.log.level.INFO)
			vim.cmd("e " .. vim.fn.expand(tostring(vim.g.NvimPath)) .. "/" .. tostring(vim.g.ReadMeTXT))
		else
			vim.notify(
				"Failed to update: "
					.. tostring(pull_output)
					.. "\nTHIS FEATURE IS UNDER DEVELOPMENT\nDISABLE AT INIT.LUA",
				vim.log.levels.ERROR
			)
			return false
		end
	end

	return true
end

return KebabVim_utils
