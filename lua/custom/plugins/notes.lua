-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'gaoDean/autolist.nvim',
    ft = {
      'markdown',
      -- "text",
      -- "tex",
      -- "plaintex",
      'norg',
      'mdx',
    },
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
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown', 'mdx' },
    opts = {},
  },
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = 'markdown',
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MeanderingProgrammer/render-markdown.nvim',
    },

    config = function(_, opts)
      -- Setup obsidian.nvim
      require('obsidian').setup(opts)

      -- Create which-key mappings for common commands.
      local wk = require 'which-key'

      wk.add {
        { '<leader>o', group = '[O]bsidian' },
        { '<leader>oo', '<cmd>ObsidianOpen<cr>', desc = 'Open note' },
        -- { '<leader>od', '<cmd>ObsidianDailies -10 0<cr>', desc = 'Daily notes' },
        { '<leader>op', '<cmd>ObsidianPasteImg<cr>', desc = 'Paste image' },
        { '<leader>oq', '<cmd>ObsidianQuickSwitch<cr>', desc = 'Quick switch' },
        { '<leader>os', '<cmd>ObsidianSearch<cr>', desc = 'Search' },
        { '<leader>ot', '<cmd>ObsidianTags<cr>', desc = 'Tags' },
        { '<leader>ol', '<cmd>ObsidianLinks<cr>', desc = 'Links' },
        { '<leader>ob', '<cmd>ObsidianBacklinks<cr>', desc = 'Backlinks' },
        { '<leader>om', '<cmd>ObsidianNewFromTemplate<cr>', desc = 'New note from template' },
        -- { '<leader>om', '<cmd>ObsidianTemplate<cr>', desc = 'Template' },
        -- { '<leader>on', '<cmd>ObsidianQuickSwitch nav<cr>', desc = 'Nav' },
        { '<leader>or', '<cmd>ObsidianRename<cr>', desc = 'Rename' },
        { '<leader>oc', '<cmd>ObsidianTOC<cr>', desc = 'Contents (TOC)' },
      }
    end,
    opts = {
      workspaces = {
        {
          name = 'personal',
          path = '~/Documents/zettelfern/',
        },
        {
          name = 'knowledge-base',
          path = '~/Code/knowledge-base/',
        },
      },
      -- mappings = {
      --   ['<leader>ot'] = {
      --     action = function()
      --       return require('obsidian').util.toc()
      --     end,
      --     opts = { buffer = true },
      --   },
      -- },
      new_notes_location = 'current_dir',
      disable_frontmatter = false,
      -- Optional, alternatively you can customize the frontmatter data.
      ---@return table
      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.

        local out = { tags = note.tags }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,
      -- templates = {
      --   folder = '~/Documents/zettelkasten/zz_templates/',
      --   date_format = '%YYMMDD-',
      --   time_format = '%HHmmss',
      --   substitutions = {},
      -- },
      -- see below for full list of options 👇
    },
  },
  {
    'davidmh/mdx.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
}
