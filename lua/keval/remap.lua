--  See `:help vim.keymap.set()`
local km = vim.keymap
local opts = { noremap = true, silent = true }

-- File explorer
km.set("n", "<leader>kv", vim.cmd.Ex)

-- Telescope
-- km.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
-- km.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
-- km.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "List buffers" })
-- km.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
km.set("n", "<leader>fm", function() vim.lsp.buf.format { async = true } end, opts) -- Format

-- Quick save / quit
km.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
-- km.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Better window navigation
-- km.set("n", "<C-h>", "<C-w>h")
-- km.set("n", "<C-l>", "<C-w>l")
-- km.set("n", "<C-j>", "<C-w>j")
-- km.set("n", "<C-k>", "<C-w>k")

-- git
km.set("n", "<leader>gg", ":Neogit<CR>", { noremap = true, silent = true })

-- Copy to system clipboard
km.set("n", "<leader>Y", '"+yy', { noremap = true, silent = true }) -- Normal mode: copy current line
km.set("n", "<leader>Y", '"+yy', { noremap = true, silent = true }) -- Normal mode: copy current line

-- Paste from system clipboard
km.set("n", "<leader>p", '"+p', { noremap = true, silent = true }) -- Normal mode: paste
km.set("v", "<leader>p", '"+p', { noremap = true, silent = true }) -- Visual mode: paste

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })
