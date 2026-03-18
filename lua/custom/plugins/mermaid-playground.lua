return {
  'selimacerbas/mermaid-playground.nvim',
  dependencies = {
    { 'selimacerbas/live-server.nvim', cmd = { 'LiveServerStart', 'LiveServerStop' } },
  },
  config = function()
    require('markdown_preview').setup {}
  end,
}
