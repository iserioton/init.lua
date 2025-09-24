--  See `:help vim.keymap.set()`
local km = vim.keymap

-- File explorer
km.set("n", "<leader>kv", vim.cmd.Ex)

-- Telescope
-- km.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
-- km.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
-- km.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "List buffers" })
-- km.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
km.set("n", "<leader>fm", function() vim.lsp.buf.format { async = true } end,
  { desc = "Formate the buffer", noremap = true, silent = true })
km.set("n", "<leader>bd", ":bd<CR>", { desc = "Delete current buffer" })

km.set("n", "<leader>tw", function()
  vim.o.wrap = not vim.o.wrap
  print("Line wrap " .. (vim.o.wrap and "enabled" or "disabled"))
end, { desc = "Toggle line wrap" })

-- Open a vertical split on the right
km.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical split" })

-- Open a horizontal split below
km.set("n", "<leader>sh", ":split<CR>", { desc = "Horizontal split" })

-- Close current split
km.set("n", "<leader>sc", "<C-w>c", { desc = "Close split" })

-- Close all other splits
km.set("n", "<leader>so", "<C-w>o", { desc = "Close other splits" })

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

-- Super useful when replacing words multiple times with the same yank
km.set("x", "<leader>p", [["_dP]], { desc = "Super useful when replacing words multiple times with the same yank" })

-- Lets you copy from Neovim → paste into your browser, Slack, etc
km.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Lets you copy from Neovim → paste into your browser, Slack, etc" })
km.set("n", "<leader>Y", [["+Y]])

-- delete without touching your yank register.
km.set({ "n", "v" }, "<leader>d", "\"_d", { desc = "Delete without touching your yank register" })

-- Copy to system clipboard
-- km.set("n", "<leader>Y", '"+yy', { noremap = true, silent = true }) -- Normal mode: copy current line
-- km.set("n", "<leader>Y", '"+yy', { noremap = true, silent = true }) -- Normal mode: copy current line

-- Paste from system clipboard
-- km.set("n", "<leader>p", '"+p', { noremap = true, silent = true }) -- Normal mode: paste
-- km.set("v", "<leader>p", '"+p', { noremap = true, silent = true }) -- Visual mode: paste

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


-- Generic Run Command based on filetype
vim.keymap.set("n", "<leader>rf", function()
  local file = vim.fn.expand("%:p")
  local ft = vim.bo.filetype
  local cmd = ""

  if ft == "c" then
    local name_no_ext = vim.fn.expand("%:t:r")
    local build_dir = "./build"
    vim.fn.mkdir(build_dir, "p")
    cmd = string.format(
      "/usr/bin/gcc -g %s -o %s/%s && chmod +x %s/%s && %s/%s",
      file, build_dir, name_no_ext, build_dir, name_no_ext, build_dir, name_no_ext
    )
  elseif ft == "cpp" then
    local name_no_ext = vim.fn.expand("%:t:r")
    local build_dir = "./build"
    vim.fn.mkdir(build_dir, "p")
    cmd = string.format(
      "/usr/bin/g++ -g %s -o %s/%s && chmod +x %s/%s && %s/%s",
      file, build_dir, name_no_ext, build_dir, name_no_ext, build_dir, name_no_ext
    )
  elseif ft == "python" then
    cmd = "python3 " .. file
  elseif ft == "javascript" then
    cmd = "node " .. file
  elseif ft == "typescript" then
    cmd = "ts-node " .. file
  elseif ft == "lua" then
    cmd = "lua " .. file
  elseif ft == "sh" then
    cmd = "bash " .. file
  else
    vim.notify("No run command defined for filetype: " .. ft, vim.log.levels.WARN)
    return
  end

  vim.cmd("split | terminal " .. cmd)
end, { desc = "Run file based on filetype" })
