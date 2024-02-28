return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local arguments = {
        "--hidden",
        "--smart-case",
        "--line-number",
        "--color=never",
        "--column",
        "--no-ignore-vcs",
        "-g",
        "!**/{.git,node_modules,target,venv,build,dist,.mypy_cache}/*",
        "-g",
        "!**/{package-lock.json,yarn.lock,Cargo.lock}",
      }

      table.unpack = table.unpack or unpack -- 5.1 compatibility

      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
        pickers = {
          find_files = {
            find_command = { "rg", "--files", table.unpack(arguments) },
          },
        },
        defaults = {
          vimgrep_arguments = { "rg", "--no-heading", table.unpack(arguments) },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "ff", builtin.find_files, {})
      vim.keymap.set("n", "fg", builtin.live_grep, {})
      vim.keymap.set("n", "fs", builtin.current_buffer_fuzzy_find, {})

      require("telescope").load_extension("ui-select")
    end,
  },
}
