-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

vim.g.vscode_snippets_path = vim.fn.stdpath "config" .. "/lua/custom/snips"

require("custom.configs.format").configure_format_on_save()

-- set qml filetype
vim.api.nvim_command('au BufNewFile,BufRead *.qml setfiletype qmljs')
