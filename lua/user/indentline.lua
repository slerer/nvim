local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
  vim.notify('Failed to require "indent_blankline"...')
  return
end

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

indent_blankline.setup {
  use_treesitter = true,
  char = "▏",
  -- char = "│",
  -- char_highlight_list = {
  --   "IndentBlanklineIndent1",
  --   "IndentBlanklineIndent2",
  --   "IndentBlanklineIndent3",
  --   "IndentBlanklineIndent4",
  --   "IndentBlanklineIndent5",
  --   "IndentBlanklineIndent6",
  -- },

  show_first_indent_level = true,
  show_trailing_blankline_indent = false,
  show_current_context = true,
  show_current_context_start = true,
  -- show_end_of_line = true,

  context_patterns = { "class", "return", "function", "method", "^if", "^while", "jsx_element",
    "^for", "^object", "^table", "block", "arguments", "if_statement", "else_clause", "jsx_element",
    "jsx_self_closing_element", "try_statement", "catch_clause", "import_statement", "operation_type",
  },
  buftype_exclude = { "terminal", "nofile" },
  filetype_exclude = { "", "alpha", "norg", "help", "markdown", "dapui_scopes", "dapui_stacks", "dapui_watches",
    "dapui_breakpoints", "dapui_hover", "LuaTree", "dbui", "term", "fugitive", "fugitiveblame", "NvimTree",
    "UltestSummary", "packer", "UltestOutput", "neotest-summary", "Outline", "lsp-installer", "startify", "dashboard",
    "neogitstatus", "Trouble", }
}
