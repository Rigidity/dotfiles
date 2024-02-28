return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier.with({
          filetypes = {
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "css",
            "scss",
            "html",
            "json",
            "yaml",
            "markdown",
            "toml",
          },
        }),
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.mypy,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format)

    local _augroups = {}
    local get_augroup = function(client)
      if not _augroups[client.id] then
        local group_name = "lsp-format-" .. client.name
        local id = vim.api.nvim_create_augroup(group_name, { clear = true })
        _augroups[client.id] = id
      end

      return _augroups[client.id]
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach-format", { clear = true }),
      callback = function(args)
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local bufnr = args.buf

        if client.name == "tsserver" then
          return
        end

        if not client.server_capabilities.documentFormattingProvider then
          return
        end

        vim.api.nvim_create_autocmd("BufWritePre", {
          group = get_augroup(client),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({
              async = false,
              timeout_ms = 5000,
              filter = function(c)
                return c.id == client.id
              end,
            })
            -- vim.diagnostic.enable(bufnr)
          end,
        })
      end,
    })
  end,
}
