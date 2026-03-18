-- Override lua_ls to use lazydev.nvim instead of the heavy runtime library scan
return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    init = function()
      -- Override lua_ls on_init to remove the expensive workspace.library scan.
      -- lazydev.nvim handles this more efficiently.
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        once = true,
        callback = function()
          vim.lsp.config('lua_ls', {
            on_init = function(client)
              -- Only apply Neovim-specific settings when editing the nvim config
              -- or when no .luarc.json exists
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
                  -- lazydev.nvim handles library paths, so we don't need the expensive scan
                  library = {
                    '${3rd}/luv/library',
                  },
                },
              })
            end,
          })
        end,
      })
    end,
  },
}
