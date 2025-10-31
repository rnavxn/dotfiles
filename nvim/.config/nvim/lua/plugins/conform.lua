return {
  --... other plugins
  { "stevearc/conform.nvim",
    event = 'BufWritePre',
    cmd = { "Conform", "ConformInfo" },
    config = function()
      require("conform").setup({
        -- Add formatters for your file types
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          python = { "black" },
          -- ... add more as needed
        },
        -- This enables auto-formatting on save
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },
}
