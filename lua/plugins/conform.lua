return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  cmd = 'ConformInfo',
  keys = {
    {
      '<leader>ff',
      function()
        require('conform').format({ async = true, lsp_fallback = true })
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  config = function()
    local conform = require('conform')
    local util = require('conform.util')

    conform.formatters = {
      biome = {
        cwd = util.root_file('biome.json'),
        require_cwd = true,
      },
      deno_fmt = {
        cwd = util.root_file({ 'deno.json', 'deno.jsonc' }),
        require_cwd = true,
      },
      prettier = {
        cwd = util.root_file({ '.prettierrc.json', '.prettierrc' }),
        require_cwd = true,
      },
    }

    conform.setup({
      formatters_by_ft = {
        lua = { 'stylua' },
        typescript = { 'biome', 'deno_fmt', stop_after_first = true },
        javascript = { 'biome', 'deno_fmt', stop_after_first = true },
        typescriptreact = { 'biome', 'deno_fmt', stop_after_first = true },
        javascriptreact = { 'biome', 'deno_fmt', stop_after_first = true },
        json = { 'biome', 'deno_fmt', stop_after_first = true },
        jsonc = { 'biome', 'deno_fmt', stop_after_first = true },
        html = { 'deno_fmt' },
        css = { 'biome', 'deno_fmt', stop_after_first = true },
        astro = { 'prettier' },
        vue = { 'prettier' },
        -- markdown = { 'deno_fmt' },
        yaml = { 'yamlfmt' },
      },
      default_format_opts = {
        lsp_format = 'fallback',
      },
      format_after_save = {
        lsp_format = 'fallback',
      },
    })

    vim.api.nvim_create_user_command('Format', function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ['end'] = { args.line2, end_line:len() },
        }
      end
      require('conform').format({ async = true, lsp_fallback = true, range = range })
    end, { range = true })
  end,
}
