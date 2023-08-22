local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "NvChad/nvterm",
    opts = overrides.nvterm,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function(_, opts)
      require("better_escape").setup(opts)
    end,
  },

  {
    "folke/todo-comments.nvim",
    event = { "CursorHold", "CursorHoldI" },
    config = function(_, opts)
      require("todo-comments").setup(opts)
    end,
  },

  {
    "lambdalisue/suda.vim",
    cmd = { "SudaRead", "SudaWrite" },
    config = function()
      vim.g["suda#prompt"] = "Enter administrator password: "
    end,
  },

  {
    "ibhagwan/smartyank.nvim",
    event = "BufReadPost",
    config = function(_, opts)
      require("smartyank").setup(opts)
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = require "custom.configs.copilot",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        config = function(_, opts)
          require("copilot_cmp").setup(opts)
        end,
      },
    },
  },

  {
    "Saecki/crates.nvim",
    event = "BufReadPost Cargo.toml",
    config = require "custom.configs.crates",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = ":call mkdp#util#install()",
  },

  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local notify = require "notify"
      notify.setup {
        background_colour = "#1D1536",
      }
      vim.notify = notify
    end,
  },

  {
    "RRethy/vim-illuminate",
    event = { "CursorHold", "CursorHoldI" },
    config = function()
      require("illuminate").configure {
        under_cursor = false,
      }
    end,
  },
  {
    "karb94/neoscroll.nvim",
    event = { "CursorHold", "CursorHoldI" },
    config = function()
      require("neoscroll").setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = {
          "<C-u>",
          "<C-d>",
          "<C-b>",
          "<C-f>",
          "<C-y>",
          "<C-e>",
          "zt",
          "zz",
          "zb",
        },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
      })
    end,
  }
  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
