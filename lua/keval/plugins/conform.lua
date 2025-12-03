return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			format_on_save = {
				timeout_ms = 5000,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
				lua = { "stylua" },
				go = { "gofmt" },
				elixir = { "mix" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				html = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
			},
			formatters = {
				["clang-format"] = {
					prepend_args = { "-style=file", "-fallback-style=LLVM" },
				},
				-- Prettier formats → ESLint highlights → ts_ls provides language features.
				prettier = {
					condition = function(ctx)
						local project_has_prettier = vim.fs.find({
							".prettierrc",
							".prettierrc.json",
							".prettierrc.js",
							".prettierrc.cjs",
							"prettier.config.js",
							"prettier.config.cjs",
						}, { upward = true, path = ctx.filename })[1]

						return true -- always run, but: default cfg if no file
					end,
					prepend_args = function(ctx)
						local project_has_prettier = vim.fs.find({
							".prettierrc",
							".prettierrc.json",
							".prettierrc.js",
							".prettierrc.cjs",
							"prettier.config.js",
							"prettier.config.cjs",
						}, { upward = true, path = ctx.filename })[1]

						if not project_has_prettier then
							return {
								"--single-quote",
								"true",
								"--trailing-comma",
								"all",
								"--print-width",
								"100",
								"--semi",
								"true",
								"--arrow-parens",
								"avoid",
							}
						end

						return {}
					end,
				},
			},
		})

		vim.keymap.set("n", "<leader>fm", function()
			require("conform").format({ bufnr = 0 })
		end, { desc = "Formate the buffer", noremap = true, silent = true })
	end,
}
