return {
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- use latest stable
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				providers = {
					"lsp",
					"treesitter",
					"regex",
				},
				delay = 100,
				filetype_overrides = {},
				filetypes_denylist = {
					"dirbuf",
					"dirvish",
					"fugitive",
				},
				filetypes_allowlist = {},
				modes_denylist = {},
				modes_allowlist = {},
				providers_regex_syntax_denylist = {},
				providers_regex_syntax_allowlist = {},
				under_cursor = true,
				large_file_cutoff = 10000,
				large_file_overrides = nil,
				min_count_to_highlight = 1,
				should_enable = function(bufnr)
					return true
				end,
				case_insensitive_regex = false,
				disable_keymaps = false,
			})
			-- Force underline highlight after plugin + colorscheme
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					for _, group in ipairs({
						"IlluminatedWordText",
						"IlluminatedWordRead",
						"IlluminatedWordWrite",
						"IlluminateWordText",
						"IlluminateWordRead",
						"IlluminateWordWrite",
					}) do
						pcall(vim.api.nvim_set_hl, 0, group, {
							underline = true,
							-- Optional:
							-- sp = "#ffaa00", -- underline color
							-- bold = true,
							-- bg = "#2a2a2a",
						})
					end
				end,
			})
		end,
	},
	{
		"nvim-mini/mini.surround",
		opts = {
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
			},
		},
	},
	{
		"danymat/neogen",
		config = true,
		keys = {
			{
				"<leader>cn",
				function()
					require("neogen").generate()
				end,
				desc = "Generate Annotations (Neogen)",
			},
		},
	},
}
