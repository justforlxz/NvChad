---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    ["<A-i>"] = "",
    ["<leader>x"] = "",
  },
}

M.general = {
  i = {
    ["<C-s>"] = { "<Esc><cmd> w <CR>", "Save file" },
    ["<A-S-q>"] = { "<Esc><cmd> q! <CR>", "Force quit" },
  },
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<A-S-q>"] = { "<cmd> q! <CR>", "Force quit" },
  },
}

-- more keybinds!

M.telescope = {
  n = {
    ["<leader>fs"] = { "<cmd> Telescope grep_string <CR>", "Find current word" },
  },
}

M.tabufline = {
  n = {
    -- close buffer + hide terminal buffer
    ["<A-q>"] = {
      function()
        require("nvchad.tabufline").close_buffer()
      end,
      "Close buffer",
    },
  },
}

M.suda = {
  n = {
    ["<A-s>"] = { "<cmd> SudaWrite <CR>", "Save file using sudo" },
  },
}

M.nvterm = {
  t = {
    ["<A-d>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },
  },
  n = {
    ["<A-d>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },
  },
}

M.crates = {
  n = {
    ["<leader>cv"] = {
      function()
        require("crates").show_versions_popup()
      end,
      "Show versions",
    },
    ["<leader>cf"] = {
      function()
        require("crates").show_features_popup()
      end,
      "Show features or features details",
    },
    ["<leader>cd"] = {
      function()
        require("crates").show_dependencies_popup()
      end,
      "Show depedencies",
    },
  },
}

M.markdown_preview = {
  n = {
    ["<F12>"] = { "<cmd> MarkdownPreviewToggle <CR>", "Preview markdown" },
  },
}

M.lspconfig = {
  n = {
    ["<A-f>"] = {
      function()
        require("custom.configs.format").toggle_format_on_save()
      end,
    },
  },
}

return M
