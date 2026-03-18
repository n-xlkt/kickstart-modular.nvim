-- Extra treesitter parsers (extends kickstart's treesitter without modifying it)
return {
  {
    'nvim-treesitter/nvim-treesitter',
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        once = true,
        callback = function()
          require('nvim-treesitter').install { 'mermaid', 'bibtex' }
        end,
      })
    end,
  },
}
