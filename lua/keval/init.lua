vim.g.mapleader = " "
vim.g.have_nerd_font = false

require("keval.set")
require("keval.remap")
require("keval.lazy_init")
-- require("keval.lsp")
require("keval.treesitter")
require("keval.auto_commands")

-- Theme
vim.cmd.colorscheme("catppuccin")

-- Lualine
require("lualine").setup {
  options = { theme = "catppuccin" }
}

-- Git signs
require("gitsigns").setup()

-- Autopairs & surround
require("nvim-autopairs").setup()
require("nvim-surround").setup()

-- harpoon2
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

