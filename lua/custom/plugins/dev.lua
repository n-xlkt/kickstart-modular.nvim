-- Development toolchain: LSP servers, treesitter parsers, formatters, linters

-- LSP servers
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  once = true,
  callback = function()
    -- General dev servers
    local servers = { 'pyright', 'bashls', 'yamlls', 'taplo', 'html', 'cssls', 'ts_ls', 'mdx_analyzer' }
    for _, server in ipairs(servers) do
      vim.lsp.config(server, {})
      vim.lsp.enable(server)
    end

    -- Typst
    vim.lsp.config('tinymist', { settings = { exportPdf = 'onSave' } })
    vim.lsp.enable 'tinymist'

    -- Lua (lazydev handles workspace library, so we skip the expensive scan)
    vim.lsp.config('lua_ls', {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath 'config'
            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
          then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            version = 'LuaJIT',
            path = { 'lua/?.lua', 'lua/?/init.lua' },
          },
          workspace = {
            checkThirdParty = false,
            library = { '${3rd}/luv/library' },
          },
        })
      end,
    })
  end,
})

-- Treesitter parsers
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  once = true,
  callback = function()
    require('nvim-treesitter').install { 'mermaid', 'typst', 'bibtex' }
  end,
})

return {
  -- LSP
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      automatic_installation = true,
    },
  },

  -- Formatting
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        python = { 'ruff_format' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typst = { 'typstfmt' },
      },
    },
  },

  -- Linting
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        python = { 'ruff' },
        markdown = { 'markdownlint' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          if vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })
    end,
  },

  -- Lua
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  -- Tooling (Mason)
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { 'ruff', 'prettierd', 'tinymist', 'typstfmt' })
    end,
  },
}
