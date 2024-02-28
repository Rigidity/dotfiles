return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    vim.api.nvim_command("augroup terminal_setup | au!")
    vim.api.nvim_command("autocmd TermOpen * nnoremap <buffer><LeftRelease> <LeftRelease>i")
    vim.api.nvim_command("augroup end")

    -- vim.keymap.set("i", "<C-S-s>", "<cmd>:ToggleTerm<cr>")

    require("toggleterm").setup({
      size = 12,
      open_mapping = [[<c-s>]],
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 1,
      start_in_insert = true,
      persist_size = true,
      close_on_exit = true,
      direction = "horizontal",
    })
  end,
}
