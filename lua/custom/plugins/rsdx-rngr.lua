return {
  {
    dir = '~/Code/rsdx-rngr.nvim',
    dependencies = { 'rktjmp/lush.nvim' },
    lazy = false,
    priority = 1000,
    init = function()
      vim.opt.termguicolors = true
      -- Use VimEnter to ensure this runs after all plugin configs (including tokyonight)
      vim.api.nvim_create_autocmd('VimEnter', {
        once = true,
        callback = function()
          vim.cmd.colorscheme 'rsdx-rngr'
        end,
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
