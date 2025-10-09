local km = vim.keymap.set

-- File explorer
km("n", "<leader>kv", vim.cmd.Ex)


-- Telescope
-- km("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
-- km("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
-- km("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "List buffers" })
-- km("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
km("n", "<leader>fm", function() vim.lsp.buf.format { async = true } end,
  { desc = "Formate the buffer", noremap = true, silent = true })
km("n", "<leader>bd", ":bd<CR>", { desc = "Delete current buffer" })

km("n", "<leader>tw", function()
  vim.o.wrap = not vim.o.wrap
  print("Line wrap " .. (vim.o.wrap and "enabled" or "disabled"))
end, { desc = "Toggle line wrap" })

-- Open a vertical split on the right
km("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical split" })

-- Open a horizontal split below
km("n", "<leader>sh", ":split<CR>", { desc = "Horizontal split" })

-- Close current split
km("n", "<leader>sc", "<C-w>c", { desc = "Close split" })

-- Close all other splits
km("n", "<leader>so", "<C-w>o", { desc = "Close other splits" })

-- Quick save / quit
km("n", "<leader>w", ":w<CR>", { desc = "Save file" })
-- km("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Better window navigation
-- km("n", "<C-h>", "<C-w>h")
-- km("n", "<C-l>", "<C-w>l")
-- km("n", "<C-j>", "<C-w>j")
-- km("n", "<C-k>", "<C-w>k")

-- git
km("n", "<leader>gg", ":Neogit<CR>", { noremap = true, silent = true })

-- Super useful when replacing words multiple times with the same yank
km("x", "<leader>p", [["_dP]], { desc = "Super useful when replacing words multiple times with the same yank" })

-- Lets you copy from Neovim → paste into your browser, Slack, etc
km({ "n", "v" }, "<leader>y", [["+y]], { desc = "Lets you copy from Neovim → paste into your browser, Slack, etc" })
km("n", "<leader>Y", [["+Y]])

-- delete without touching your yank register.
km({ "n", "v" }, "<leader>d", "\"_d", { desc = "Delete without touching your yank register" })

-- Copy to system clipboard
-- km("n", "<leader>Y", '"+yy', { noremap = true, silent = true }) -- Normal mode: copy current line
-- km("n", "<leader>Y", '"+yy', { noremap = true, silent = true }) -- Normal mode: copy current line

-- Paste from system clipboard
-- km("n", "<leader>p", '"+p', { noremap = true, silent = true }) -- Normal mode: paste
-- km("v", "<leader>p", '"+p', { noremap = true, silent = true }) -- Visual mode: paste

-- Clear highlights on search when pressing <Esc> in normal mode
km('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
km('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
km('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
km('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
km('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
km('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
km('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
km('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
km('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
km('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
km('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- km("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- km("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- km("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- km("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })


-- Generic Run Command based on filetype
km("n", "<leader>rf", function()
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

