return {
  'gbprod/substitute.nvim',
  keys = {
    {
      's',
      function()
        require('substitute').operator()
      end,
      { noremap = true },
    },
    {
      'ss',
      function()
        require('substitute').line()
      end,
      { noremap = true },
    },
    {
      'S',
      function()
        require('substitute').eol()
      end,
      { noremap = true },
    },
    {
      mode = 'x',
      'S',
      function()
        require('substitute').visual()
      end,
      { noremap = true },
    },
  },
  opts = {
    on_substitute = function()
      require('yanky.integration').substitute()
    end,
  },
}
