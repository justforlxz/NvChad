local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "json", "yaml", "typescript", "vue" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- bash
  b.formatting.shfmt,
}

null_ls.setup {
  sources = sources,
}
