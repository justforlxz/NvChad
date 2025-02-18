local default_on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = {
  "html",
  "cssls",
  "tsserver",
  "volar",
  "pylsp",
  "rust_analyzer",
  "bashls",
  "cmake",
  "jsonls",
  "ltex",
  "yamlls",
  "sqlls",
}

function on_attach(client, bufnr)
  default_on_attach(client, bufnr)
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = true
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

--
-- lspconfig.pyright.setup { blabla}

local function switch_source_header_splitcmd(bufnr, splitcmd)
  bufnr = lspconfig.util.validate_bufnr(bufnr)
  local clangd_client = lspconfig.util.get_active_client_by_name(bufnr, "clangd")
  local params = { uri = vim.uri_from_bufnr(bufnr) }
  if clangd_client then
    clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
      if err then
        error(tostring(err))
      end
      if not result then
        vim.notify("Corresponding file can’t be determined", vim.log.levels.ERROR, { title = "LSP Error!" })
        return
      end
      vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
    end)
  else
    vim.notify(
      "Method textDocument/switchSourceHeader is not supported by any active server on this buffer",
      vim.log.levels.ERROR,
      { title = "LSP Error!" }
    )
  end
end

local function get_binary_path_list(binaries)
  local path_list = {}
  for _, binary in ipairs(binaries) do
    local path = vim.fn.exepath(binary)
    if path ~= "" then
      table.insert(path_list, path)
    end
  end
  return table.concat(path_list, ",")
end

lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = vim.tbl_deep_extend("keep", { offsetEncoding = { "utf-16", "utf-8" } }, capabilities),
  single_file_support = true,
  cmd = {
    "clangd",
    "-j=12",
    "--enable-config",
    "--background-index",
    "--pch-storage=memory",
    -- You MUST set this arg ↓ to your c/cpp compiler location (if not included)!
    "--query-driver=" .. get_binary_path_list { "clang++", "clang", "gcc", "g++" },
    "--clang-tidy",
    "--all-scopes-completion",
    "--completion-style=detailed",
    "--header-insertion-decorators",
    "--header-insertion=iwyu",
    "--limit-references=3000",
    "--limit-results=350",
  },
  commands = {
    ClangdSwitchSourceHeader = {
      function()
        switch_source_header_splitcmd(0, "edit")
      end,
      description = "Open source/header in current buffer",
    },
    ClangdSwitchSourceHeaderVSplit = {
      function()
        switch_source_header_splitcmd(0, "vsplit")
      end,
      description = "Open source/header in a new vsplit",
    },
    ClangdSwitchSourceHeaderSplit = {
      function()
        switch_source_header_splitcmd(0, "split")
      end,
      description = "Open source/header in a new split",
    },
  },
}

if vim.fn.executable("qmlls") then
  lspconfig.qmlls.setup {
    cmd = { "qmlls6" },
    filetypes = { "qmljs" },
    root_dir = function(fname)
      return lspconfig.util.find_git_ancestor(fname)
    end,
    single_file_support = true,
    on_attach = on_attach,
  }
end
