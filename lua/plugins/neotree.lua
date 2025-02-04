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
  opts = function(_, opts)
    local function on_move(data)
      Snacks.rename.on_rename_file(data.source, data.destination)
    end
    local events = require('neo-tree.events')
    opts.event_handlers = opts.event_handlers or {}
    vim.list_extend(opts.event_handlers, {
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    })

    return {
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
    }
  end,
}
