-- Extra formatters (extends kickstart's conform without modifying it)
return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        python = { 'ruff_format' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
      },
    },
  },
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { 'ruff', 'prettierd' })
    end,
  },
}
