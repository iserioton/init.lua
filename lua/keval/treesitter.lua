-- ================================
-- Treesitter Config (JS/TS/React + Web)
-- ================================
require('nvim-treesitter.configs').setup {
  -- Parsers to ensure are installed
  ensure_installed = {
    "javascript",
    "typescript",
    "tsx",
    "json",
    "html",
    "css",
    "lua",
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
      init_selection = "gnn",        -- start selection
      node_incremental = "grn",      -- expand node
      scope_incremental = "grc",     -- expand scope
      node_decremental = "grm",      -- shrink node
    },
  },

  -- Enable smart indentation
  indent = {
    enable = true,
  },

  auto_install = false,
}

-- ================================
-- Global folding settings
-- ================================
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldenable = true      -- folds are enabled
vim.o.foldlevel = 99         -- open most folds by default

