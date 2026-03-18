-- Extra LSP servers (extends kickstart's lspconfig without modifying it)
return {
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      automatic_installation = true,
    },
  },
  {
    'neovim/nvim-lspconfig',
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        once = true,
        callback = function()
          local servers = { 'pyright', 'bashls', 'yamlls', 'taplo', 'html', 'cssls', 'ts_ls', 'mdx_analyzer' }
          for _, server in ipairs(servers) do
            vim.lsp.config(server, {})
            vim.lsp.enable(server)
          end
        end,
      })
    end,
  },
}
