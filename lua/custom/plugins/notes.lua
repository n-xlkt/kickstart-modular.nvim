-- Markdown, notes, and knowledge management
return {
  -- Editing
  {
    'gaoDean/autolist.nvim',
    ft = { 'markdown', 'norg', 'mdx' },
    config = function()
      require('autolist').setup()

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'markdown', 'norg', 'mdx' },
        callback = function()
          local opts = { buffer = true }
          vim.keymap.set('i', '<tab>', '<cmd>AutolistTab<cr>', opts)
          vim.keymap.set('i', '<s-tab>', '<cmd>AutolistShiftTab<cr>', opts)
          vim.keymap.set('i', '<CR>', '<CR><cmd>AutolistNewBullet<cr>', opts)
          vim.keymap.set('n', 'o', 'o<cmd>AutolistNewBullet<cr>', opts)
          vim.keymap.set('n', 'O', 'O<cmd>AutolistNewBulletBefore<cr>', opts)
          vim.keymap.set('n', '<CR>', '<cmd>AutolistToggleCheckbox<cr><CR>', opts)
          vim.keymap.set('n', '<leader>cn', require('autolist').cycle_next_dr, { buffer = true, expr = true })
          vim.keymap.set('n', '<leader>cp', require('autolist').cycle_prev_dr, { buffer = true, expr = true })
          vim.keymap.set('n', '>>', '>><cmd>AutolistRecalculate<cr>', opts)
          vim.keymap.set('n', '<<', '<<<cmd>AutolistRecalculate<cr>', opts)
          vim.keymap.set('n', 'dd', 'dd<cmd>AutolistRecalculate<cr>', opts)
          vim.keymap.set('v', 'd', 'd<cmd>AutolistRecalculate<cr>', opts)
        end,
      })
    end,
  },
  {
    'davidmh/mdx.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },

  -- Rendering
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown', 'mdx' },
    opts = {},
  },

  -- Obsidian
  {
    'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MeanderingProgrammer/render-markdown.nvim',
    },
    config = function(_, opts)
      require('obsidian').setup(opts)

      require('which-key').add {
        { '<leader>o', group = '[O]bsidian' },
        { '<leader>oo', '<cmd>ObsidianOpen<cr>', desc = 'Open note' },
        { '<leader>op', '<cmd>ObsidianPasteImg<cr>', desc = 'Paste image' },
        { '<leader>oq', '<cmd>ObsidianQuickSwitch<cr>', desc = 'Quick switch' },
        { '<leader>os', '<cmd>ObsidianSearch<cr>', desc = 'Search' },
        { '<leader>ot', '<cmd>ObsidianTags<cr>', desc = 'Tags' },
        { '<leader>ol', '<cmd>ObsidianLinks<cr>', desc = 'Links' },
        { '<leader>ob', '<cmd>ObsidianBacklinks<cr>', desc = 'Backlinks' },
        { '<leader>om', '<cmd>ObsidianNewFromTemplate<cr>', desc = 'New note from template' },
        { '<leader>or', '<cmd>ObsidianRename<cr>', desc = 'Rename' },
        { '<leader>oc', '<cmd>ObsidianTOC<cr>', desc = 'Contents (TOC)' },
      }
    end,
    opts = {
      workspaces = {
        { name = 'personal', path = '~/Documents/zettelfern/' },
        { name = 'knowledge-base', path = '~/Code/knowledge-base/' },
      },
      new_notes_location = 'current_dir',
      disable_frontmatter = false,
      ---@return table
      note_frontmatter_func = function(note)
        local out = { tags = note.tags }
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,
    },
  },

  -- Diagrams
  {
    'selimacerbas/mermaid-playground.nvim',
    dependencies = {
      { 'selimacerbas/live-server.nvim', cmd = { 'LiveServerStart', 'LiveServerStop' } },
    },
    config = function()
      require('markdown_preview').setup {}
    end,
  },
}
