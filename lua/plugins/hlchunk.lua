return {
  'shellRaining/hlchunk.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function(_, opts)
    require('hlchunk').setup({
      chunk = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
  end,
}
