local vim_options = {}

function vim_options.SetKebabVimDefault()
	vim.cmd([[ 
	
	set number
	set cursorline
	
	set laststatus=3

	]])
end

return vim_options
