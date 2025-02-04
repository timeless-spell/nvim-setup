return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  keys = {
    { '\\r', '<CMD>Neotree reveal<CR>', desc = 'Neotree reveal' },
    { '\\c', '<CMD>Neotree current<CR>', desc = 'Neotree current' },
    { '\\\\', '<CMD>Neotree reveal_force_cwd<CR>', desc = 'Neotree reveal cwd' },
    { '\\t', '<CMD>Neotree toggle<CR>', desc = 'Neotree toggle' },
  },
  opts = {
    window = {
      position = 'right',
    },
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
      hijack_netrw_behavior = 'disabled',
    },
  },
}
