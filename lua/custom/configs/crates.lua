return function()
  require("crates").setup {
    popup = {
      autofocus = true,
    },
    null_ls = {
      enabled = true,
      name = "crates.nvim",
    },
  }
end
