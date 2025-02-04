return {
  'iguanacucumber/magazine.nvim',
  enabled = false,
  name = 'nvim-cmp',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    { 'iguanacucumber/mag-nvim-lsp', name = 'cmp-nvim-lsp', opts = {} },
    { 'iguanacucumber/mag-nvim-lua', name = 'cmp-nvim-lua' },
    { 'iguanacucumber/mag-buffer', name = 'cmp-buffer' },
    { 'iguanacucumber/mag-cmdline', name = 'cmp-cmdline' },
    { 'FelipeLema/cmp-async-path' },
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
    },
    'saadparwaiz1/cmp_luasnip',
    'mtoohey31/cmp-fish',
    'hrsh7th/cmp-emoji',
    'chrisgrieser/cmp-nerdfont',
    'kdheepak/cmp-latex-symbols',
    'onsails/lspkind.nvim',
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    luasnip.config.setup({})

    cmp.setup({
      view = {
        entries = {
          selection_order = 'near_cursor',
        },
      },
      window = {
        completion = { border = 'solid', winblend = 20 },
        documentation = { border = 'solid', winblend = 20 },
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = 'menu,menuone,noinsert' },
      mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),

        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
        ['<Up>'] = cmp.mapping(function(fallback)
          fallback()
        end, { 'i', 'c' }),

        ['<Down>'] = cmp.mapping(function(fallback)
          fallback()
        end, { 'i', 'c' }),

        -- NOTE: For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        -- https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      }),
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'nvim_lua' },
        { name = 'buffer' },
        { name = 'async_path' },
        { name = 'fish' },
        { name = 'emoji' },
        { name = 'nerdfont' },
        {
          name = 'latex_symbols',
          option = {
            strategy = 0,
          },
        },
      },
      formatting = {
        format = function(entry, item)
          local color_item = require('nvim-highlight-colors').format(entry, { kind = item.kind })
          item = require('lspkind').cmp_format({
            mode = 'symbol_text',
            symbol_map = { Codeium = '' },
            menu = {
              cmdline = '[CMD]',
              buffer = '[Buf]',
              nvim_lsp = '[LSP]',
              luasnip = '[LuaSnip]',
              async_path = '[Path]',
              nvim_lua = '[Lua]',
              latex_symbols = '[Latex]',
              fish = '[Fish]',
              emoji = '[Emoji]',
              nerdfont = '[Nerdfont]',
            },
            maxwidth = {
              -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
              -- can also be a function to dynamically calculate max width such as
              -- menu = function() return math.floor(0.45 * vim.o.columns) end,
              menu = 50, -- leading text (labelDetails)
              abbr = 50, -- actual suggestion item
            },
            ellipsis_char = '...',
            show_labelDetails = true,
          })(entry, item)
          if color_item.abbr_hl_group then
            item.kind_hl_group = color_item.abbr_hl_group
            item.kind = color_item.abbr
          end
          return item
        end,
      },
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
      matching = { disallow_symbol_nonprefix_matching = false },
    })
  end,
}
