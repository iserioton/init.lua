return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- Parsers to ensure are installed
				ensure_installed = {
					"javascript",
					"typescript",
					"tsx",
					"json",
					"html",
					"css",
					"lua",
					"bash",
				},

				-- Enable syntax highlighting
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},

				-- Enable code folding
				fold = {
					enable = true,
				},

				-- Enable incremental selection (like VSCode selection expansion)
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn", -- start selection
						node_incremental = "grn", -- expand node
						scope_incremental = "grc", -- expand scope
						node_decremental = "grm", -- shrink node
					},
				},

				-- Enable smart indentation
				indent = {
					enable = true,
				},

				auto_install = false,
			})

			vim.o.foldmethod = "expr"
			vim.o.foldexpr = "nvim_treesitter#foldexpr()"
			vim.o.foldenable = true -- folds are enabled
			vim.o.foldlevel = 99 -- open most folds by default
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		after = "nvim-treesitter",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				multiwindow = false, -- Enable multiwindow support.
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
		end,
	},
}
