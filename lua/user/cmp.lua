local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  vim.notify('Failed to require "cmp"...')
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  vim.notify('Failed to require "luasnip"...')
  return
end

local ls = luasnip
-- some shorthands...
local snip = ls.snippet
-- local node = ls.snippet_node
-- local text = ls.text_node
-- local insert = ls.insert_node
local func = ls.function_node
-- local choice = ls.choice_node
-- local dynamicn = ls.dynamic_node

local date = function() return {os.date('%Y-%m-%d')} end

ls.add_snippets(nil, {
    all = {
        snip({
            trig = "date",
            namr = "Date",
            dscr = "Date in the form of YYYY-MM-DD",
        }, {
            func(date, {}),
        }),
        snip({
            trig = "IP",
            namr = "IPython embed",
            dscr = "from IPython import embed; embed()",
        }, {
            func(function() return {"from IPython import embed; embed()"} end, {}),
        }),
    },
})

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local icons = require "user.icons"

local kind_icons = icons.kind

cmp.setup {
  -- nvim-cmp by defaults disables autocomplete for prompt buffers
  enabled = function ()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
      or require("cmp_dap").is_dap_buffer()
  end,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-j>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    -- ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    -- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = false },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
      "c",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
      "c",
    }),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      -- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- NOTE: order matters
      vim_item.menu = ({
        dap = "[DAP]",
        nvim_lua = "[NVIM]",
        nvim_lsp = "[LSP]",
        luasnip = "[SNIPPET]",
        path = "[PATH]",
        buffer = "[BUFFER]",
        spell = "[ABC]",
        omni = "[OMNI]",
        emoji = "[EMOJI]",
        git = "[GIT]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = 'dap' },
    { name = "nvim_lua", keyword_length = 3 },
    { name = "nvim_lsp", keyword_length = 3 },
    { name = "nvim_lsp_signature_help" },
    { name = "luasnip", keyword_length = 2 },
    { name = "path" },
    { name = "buffer", keyword_length = 3 },
    { name = "spell", keyword_length = 2 },
    { name = "omni" },
    { name = "emoji" },
    { name = "git" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  -- documentation = true,
  window = {
    completion = {
      -- cmp.config.window.bordered(),
      -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
    -- documentation = "native",
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
  },
  -- documentation = {
  -- 	border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  -- },
  experimental = {
    ghost_text = false,
    -- native_menu = false,
  },
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

local cmp_git_status, cmp_git = pcall(require, "cmp_git")
if not cmp_git_status then
  vim.notify('Failed to require "cmp_git"...')
else
  cmp_git.setup({})
end

-- Trying out also filling omnifunc:
_G.vimrc = _G.vimrc or {}
_G.vimrc.cmp = _G.vimrc.cmp or {}
_G.vimrc.cmp.lsp = function()
  cmp.complete({
    config = {
      sources = {
        { name = 'nvim_lsp' }
      }
    }
  })
end
_G.vimrc.cmp.snippet = function()
  cmp.complete({
    config = {
      sources = {
        { name = 'luasnip' }
      }
    }
  })
end

vim.cmd([[
   inoremap <c-x><c-o> <Cmd>lua vimrc.cmp.lsp()<CR>
   inoremap <c-x><c-s> <Cmd>lua vimrc.cmp.snippet()<CR>
   ]])
