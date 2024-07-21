local KebabVim_utils = {}

function KebabVim_utils.StartUp()
	vim.o.background = "dark"
	vim.opt.termguicolors = true

	vim.notify = require("notify")

	vim.g.mapleader = "C"
end

-- WARNING: MAY BREAK!
-- REQUIRES: PLENARY, NEOVIM API, LUA, GIT
-- PULLS CONTENT FROM https://github.com/MeKebabMan/KebabVim.git
function KebabVim_utils.UPDATE()
	if not vim.g.ReadMeTXT or not vim.g.NvimPath or not vim.g.GitBranch then
		return false
	end

	local job = require("plenary.job")

	local fetch_exit_code = 1
	local diff_exit_code = 1

	job:new({
		command = "git",
		args = { "fetch", "origin", tostring(vim.g.GitBranch) },
		cwd = vim.fn.expand(tostring(vim.g.NvimPath)),
		on_exit = function(_, code)
			fetch_exit_code = code
		end,
	}):sync()

	if fetch_exit_code == nil or fetch_exit_code ~= 0 then
		-- FAILED TO FETCH NOTIFY THE USER
		vim.notify("Failed to fetch new data from the repository!", vim.log.levels.ERROR, {
			title = "AUTO UPDATE",
		})
		return false
	end

	job:new({
		command = "git",
		args = { "diff", "HEAD", "origin/" .. tostring(vim.g.GitBranch), "--exit-code", "--quiet" },
		cwd = vim.fn.expand(tostring(vim.g.NvimPath)),
		on_exit = function(_, code)
			diff_exit_code = code
		end,
	}):sync()

	if diff_exit_code ~= nil and diff_exit_code ~= 0 then
		vim.notify(
			"Difference found between repositories.. Preparing to update!\nDISABLE FEATURE AT INIT.LUA",
			vim.log.levels.INFO,
			{
				title = "AUTO UPDATE",
			}
		)

		local pull_exit_code = 1

		job:new({
			command = "git",
			args = { "pull", "origin", tostring(vim.g.GitBranch) },
			cwd = vim.fn.expand(tostring(vim.g.NvimPath)),
			on_exit = function(_, code)
				pull_exit_code = code
			end,
		}):sync()

		if pull_exit_code ~= nil and pull_exit_code == 0 then
			-- UPDATE SUCCESSFULL NOTIFY THE USER
			vim.notify("Update successfull!", vim.log.levels.INFO, {
				title = "AUTO UPDATE",
			})
			vim.cmd("e " .. vim.fn.expand(tostring(vim.g.NvimPath)) .. "/" .. tostring(vim.g.ReadMeTXT))
		else
			-- FAIL TO UPDATE NOTIFY THE USER!
			vim.notify(
				"Failed to update: "
					.. tostring(pull_output)
					.. "\nTHIS FEATURE IS UNDER DEVELOPMENT\nDISABLE AT INIT.LUA",
				vim.log.levels.ERROR,
				{
					title = "AUTO UPDATE",
				}
			)
			return false
		end
	end

	return true
end

return KebabVim_utils
