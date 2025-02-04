return {
  'stevearc/resession.nvim',
  keys = {
    {
      '<leader>rs',
      function()
        require('resession').save()
      end,
      desc = 'Resession save',
    },
    {
      '<leader>rl',
      function()
        require('resession').load()
      end,
      desc = 'Resession load',
    },
    {
      '<leader>rd',
      function()
        require('resession').delete()
      end,
      desc = 'Resession delete',
    },
  },
  opts = function(_, opts)
    opts = opts or {}
    opts.autosave = {
      enabled = true,
      interval = 60,
      notify = true,
    }

    vim.api.nvim_create_autocmd('VimLeavePre', {
      callback = function()
        -- Always save a special session named "last"
        require('resession').save('last')
      end,
    })
  end,
}
