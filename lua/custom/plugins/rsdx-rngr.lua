return {
  {
    dir = '~/Code/rsdx-rngr.nvim',
    dependencies = { 'rktjmp/lush.nvim' },
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.cmd.colorscheme 'rsdx-rngr'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
