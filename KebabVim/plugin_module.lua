local plugin_module = {}

function plugin_module.lualine()
	require("lualine").setup({
		options = {
			theme = "auto",
		},
	})
end

function plugin_module.SetTheme(theme)
	if type(theme) == "string" then
		vim.cmd("colorscheme " .. tostring(theme))
	end
end

function plugin_module.nvim_treesitter(installs)
	require("nvim-treesitter").setup()
	require("nvim-treesitter.configs").setup({
		ensure_installed = installs,

		auto_install = true,

		highlight = {
			enable = true,
		},
	})
end

function plugin_module.KebabVimLSP(language_servers)
	require("mason").setup({})

	require("mason-lspconfig").setup({
		ensure_installed = language_servers,
	})

	local lspconfig = require("lspconfig")
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	for _, server in pairs(language_servers) do
		lspconfig[server].setup({
			capabilities = capabilities,
		})
	end

	vim.keymap.set("n", "<C-x>", vim.lsp.buf.hover, {})
	vim.keymap.set({ "n", "v" }, "<C-c>", vim.lsp.buf.code_action, {})
end

function plugin_module.KebabVimCMP()
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
end

function plugin_module.KebabVimNone_ls()
	local null_ls = require("null-ls")

	null_ls.setup({
		sources = {
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.prettier,
			null_ls.builtins.formatting.clang_format,
		},
	})

	vim.keymap.set("n", "<space>c", vim.lsp.buf.format, {})
end

function plugin_module.KebabVimFileExplorer(Key, NeoTree_config)
	require("neo-tree").setup(NeoTree_config)

	if Key then
		vim.keymap.set("n", Key, ":Neotree filesystem reveal left<CR>", {})
	else
		vim.keymap.set("n", "<C-e>", ":Neotree filesystem reveal left<CR>", {})
	end
end

function plugin_module.Telescope()
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
end

function  plugin_module.Autotag()
	require("nvim-ts-autotag").setup({})
end

function  plugin_module.KebabVimAutoPairs()
	require("nvim-autopairs").setup({})
	local cmp = require("cmp")
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

function plugin_module.KebabVim_SetUp_DefaultNotify()
	vim.notify = require("notify")
end

function plugin_module.barbar()
	require("barbar").setup({})
end

return plugin_module
