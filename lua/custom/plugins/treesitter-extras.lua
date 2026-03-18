-- Extra treesitter parsers (extends kickstart's treesitter without modifying it)
return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'mermaid', 'bibtex' })
      opts.ignore_install = { 'latex' }
    end,
  },
}
