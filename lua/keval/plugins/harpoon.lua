return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup()

		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end, { desc = "Add current buffer into harpoon" })

		vim.keymap.set("n", "<C-h><C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Open harpoon list" })

		vim.keymap.set("n", "<C-h><C-h>", function()
			harpoon:list():select(1)
		end, { desc = "Open first buffer from harpoon" })

		vim.keymap.set("n", "<C-h><C-j>", function()
			harpoon:list():select(2)
		end, { desc = "Open second buffer from harpoon" })

		vim.keymap.set("n", "<C-h><C-k>", function()
			harpoon:list():select(3)
		end, { desc = "Open third buffer from harpoon" })

		vim.keymap.set("n", "<C-h><C-l>", function()
			harpoon:list():select(4)
		end, { desc = "Open forth buffer from harpoon" })

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-h><C-p>", function()
			harpoon:list():prev()
		end, { desc = "Open previous buffer from harpoon" })

		vim.keymap.set("n", "<C-h><C-n>", function()
			harpoon:list():next()
		end, { desc = "Open next buffer from harpoon" })
	end,
}
