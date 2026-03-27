-- Academic writing: LaTeX, Typst, bibliography, pandoc, writing aids
return {
  -- LaTeX + Pandoc
  {
    'lervag/vimtex',
    init = function()
      vim.g.vimtex_view_method = 'skim'
      vim.g.vimtex_context_pdf_viewer = 'zathura'

      vim.g.vimtex_indent_enabled = false
      vim.g.tex_indent_items = false
      vim.g.tex_indent_brace = false

      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_log_ignore = {
        'Underfull',
        'Overfull',
        'specifier changed to',
        'Token not allowed in a PDF string',
      }

      vim.g.vimtex_mappings_enabled = false
      vim.g.tex_flavor = 'latex'

      require('which-key').add {
        { '<leader>v', group = '[V]imtex' },
        { '<leader>vb', '<cmd>VimtexCompile<CR>', desc = 'Build' },
        { '<leader>vc', '<cmd>:VimtexClearCache All<CR>', desc = 'Clear' },
        { '<leader>ve', '<cmd>VimtexErrors<CR>', desc = 'Error Report' },
        { '<leader>vf', '<cmd>Telescope bibtex format_string=\\citet{%s}<CR>', desc = 'Find Citation' },
        { '<leader>vi', '<cmd>VimtexTocOpen<CR>', desc = 'Index' },
        { '<leader>vk', '<cmd>VimtexClean<CR>', desc = 'Kill AUX' },
        { '<leader>vm', '<plug>(vimtex-context-menu)', desc = 'Menu' },
        { '<leader>vv', '<cmd>VimtexView<CR>', desc = 'View' },
        { '<leader>vw', '<cmd>VimtexCountWords!<CR>', desc = 'Word Count' },
        { '<leader>vx', '<cmd>terminal bibexport -o %:p:r.bib %:p:r.aux<CR>', desc = 'Bib Export' },
        { '<leader>p', group = '[P]andoc' },
        { '<leader>ph', '<cmd>term pandoc "%:p" -o "%:p:r.html"<CR>', desc = 'HTML' },
        { '<leader>pl', '<cmd>term pandoc "%:p" -o "%:p:r.tex"<CR>', desc = 'LaTeX' },
        { '<leader>pm', '<cmd>term pandoc "%:p" -o "%:p:r.md"<CR>', desc = 'Markdown' },
        { '<leader>pp', '<cmd>term pandoc "%:p" -o "%:p:r.pdf" open=0<CR>', desc = 'PDF' },
        { '<leader>pw', '<cmd>term pandoc "%:p" -o "%:p:r.docx"<CR>', desc = 'Word' },
      }
    end,
  },
  {
    'micangl/cmp-vimtex',
    ft = 'tex',
    config = function()
      require('cmp_vimtex').setup {
        additional_information = {
          info_in_menu = true,
          info_in_window = true,
          info_max_length = 60,
          match_against_info = true,
          symbols_in_menu = true,
        },
        bibtex_parser = { enabled = true },
        search = {
          browser = 'open',
          default = 'google_scholar',
          search_engines = {
            google_scholar = {
              name = 'Google Scholar',
              get_url = require('cmp_vimtex').url_default_format 'https://scholar.google.com/scholar?hl=en&q=%s',
            },
          },
        },
      }
    end,
  },
  -- Bibliography / citations
  {
    'nvim-telescope/telescope-bibtex.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    ft = { 'tex', 'markdown', 'typst' },
    config = function()
      require('telescope').load_extension 'bibtex'
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    opts = {
      extensions = {
        bibtex = {
          depth = 1,
          global_files = { '~/Library/texmf/bibtex/bib/Zotero.bib' },
          search_keys = { 'author', 'year', 'title' },
          citation_format = '{{author}} ({{year}}), {{title}}.',
          citation_trim_firstname = true,
          citation_max_auth = 2,
          custom_formats = {
            { id = 'citet', cite_maker = '\\citet{%s}' },
          },
          format = 'citet',
          context = true,
          context_fallback = true,
          wrap = false,
        },
      },
    },
  },

  -- Writing aids
  { 'andrewferrier/wrapping.nvim', opts = {} },
}
