return {
  'folke/tokyonight.nvim',
  priority = 1000,
  init = function()
    vim.cmd.colorscheme('tokyonight-night')
  end,
  opts = {
    style = 'night',
    transparent = true,
    styles = {
      keywords = { italic = false },
      sidebars = 'transparent',
      floats = 'transparent',
    },
    on_colors = function(colors)
      colors.bg_statusline = colors.none
    end,
    on_highlights = function(highlights, colors)
      highlights.CursorLine = { bg = '#1B1428' }
      highlights.Visual = { bg = '#392E4D' }
      highlights.MiniCursorword = { bg = '' }
      highlights.MiniCursorwordCurrent = { bg = '' }
    end,
  },
}
