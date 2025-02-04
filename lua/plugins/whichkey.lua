return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  keys = {
    {
      '<leader>\\',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
  config = function()
    local wk = require('which-key')

    wk.setup({
      preset = 'helix',
      spec = {
        { '<leader>t', group = 'Telescope', icon = '󰭎' },
        { '<leader>tl', group = 'LSP', icon = '' },
        { '<leader>ts', group = 'Search', icon = '󰍉' },
        { '<leader>m', group = 'Mini', icon = '󰨅' },
        { '<leader>T', group = 'Trouble', icon = '󱈎' },
        { '<leader>g', group = 'Git', icon = '' },
        { '<leader>F', group = 'FzfLua', icon = '󰍉' },
        { '<leader>l', group = 'LSP', icon = '󰒋' },
        { '<leader>d', group = 'DAP', icon = '' },
        { '<leader>r', group = 'Resession', icon = '󰹑' },
      },
    })
  end,
}
