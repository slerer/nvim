local let = vim

-- Globals (let g: in vimscript):
let.g.python3_host_prog = "/Users/shacharlerer/miniconda3/envs/neovim/bin/python3"

let.g.loaded_netrw = 1
let.g.loaded_netrwPlugin = 1

let.g.tq_map_keys = 1
let.g.tq_enabled_backends={"datamuse_com", "mthesaur_txt", "openoffice_en"}

-- if you want to use overlay feature
let.g.choosewin_overlay_enable = 1

-- Adding the next two in case I'll reinstall FZF
if let.fn.executable('rg') == 1 then
    let.g.rg_derive_root = 'true'
end

if let.fn.executable('ag') == 1 then
    let.o.grepprg = "ag --nogroup --nocolor"
end

-- ultest
let.g.ultest_use_pty = 1

-- mbbil/undotree
let.g.undotree_SetFocusWhenToggle = 1
let.g.undotree_SplitWidth = 30
let.g.undotree_WindowLayout = 2
let.g.undotree_ShortIndicators = 1

-- Vista
let.g.vista_fzf_preview = {'right:50%'}
let.g.vista_echo_cursor_strategy = 'both'
let.g.vista_sidebar_width = 30
let.g.vista_default_executive = 'nvim_lsp'
let.g.vista_close_on_jump = 1
let.g.vista_close_on_fzf_select = 1
let.g.vista_blink = '[3, 100]'
let.g.vista_executive_for = { vimwiki = 'markdown', pandoc = 'markdown', markdown = 'toc' }
let.g.vista_finder_alternative_executives = 'ctags'

-- in millisecond, used for both CursorHold and CursorHoldI,
-- use updatetime instead if not defined
let.g.cursorhold_updatetime = 100

let.g.sphinx_default_role = 'any'
let.g.sphinx_html_output_dirs = { '_build/html', 'build/html', '../_build/html', '../build/html', '_build/dirhtml', 'build/dirhtml', '../_build/dirhtml', '../build/dirhtml', }

-- Markdown Preview
vim.g.preview_markdown_parser = 'glow'

-- Global utility functions:
P = function(v)
  print(let.inspect(v))
  return v
end

if pcall(require, "plenary") then
  RELOAD = require("plenary.reload").reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

-- The function is called `T` for `termcodes`.
-- You don't have to call it that, but I find the terseness convenient
-- function T(str)
--     -- Adjust boolean arguments as needed
--     return let.api.nvim_replace_termcodes(str, true, true, true)
-- end
