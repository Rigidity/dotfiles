return {
  "ThePrimeagen/harpoon",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("harpoon").setup({
      global_settings = {
        save_on_toggle = true,
        save_on_change = true,
      },
    })
    local keybinds = { "a", "s", "d", "f" }
    for i, key in ipairs(keybinds) do
      local keymap = "<leader>h" .. key
      vim.keymap.set("n", keymap, string.format('<cmd>lua require("harpoon.ui").nav_file(%d)<cr>', i), {})
    end
    vim.keymap.set("n", "fh", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', {})
    vim.keymap.set("n", "fa", '<cmd>lua require("harpoon.mark").add_file()<cr>')
    vim.keymap.set("n", "fn", '<cmd>lua require("harpoon.ui").nav_next()<cr>', {})
    vim.keymap.set("n", "fp", '<cmd>lua require("harpoon.ui").nav_prev()<cr>', {})
  end,
}
