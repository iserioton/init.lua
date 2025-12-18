return {
	{
		"github/copilot.vim",
		lazy = false,
		config = function()
			vim.g.copilot_no_tab_map = true
			vim.keymap.set("i", "<leader><Tab>", 'copilot#Accept("\\<CR>")', {
				expr = true,
				silent = true,
				replace_keycodes = false,
			})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			"github/copilot.vim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("CopilotChat").setup({
				model = "gpt-4o",
				show_help = true,
				auto_follow_cursor = true,
			})
			vim.keymap.set("n", "<leader>cc", ":CopilotChat<CR>", { silent = true })
			vim.keymap.set("n", "<leader>cf", function()
				require("CopilotChat").ask("Explain this file")
			end, { silent = true })
			vim.keymap.set("v", "<leader>ce", function()
				require("CopilotChat").ask("Explain this code")
			end, { silent = true })
			vim.keymap.set("v", "<leader>cr", function()
				require("CopilotChat").ask("Refactor this code")
			end, { silent = true })
		end,
	},
}
