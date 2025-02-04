return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'Bilal2453/luvit-meta',
    lazy = true,
  },
  -- {
  -- 	"iguanacucumber/magazine.nvim",
  -- 	name = "nvim-cmp",
  -- 	opts = function(_, opts)
  -- 		opts.sources = opts.sources or {}
  -- 		table.insert(opts.sources, {
  -- 			name = "lazydev",
  -- 			group_index = 0,
  -- 		})
  -- 	end,
  -- },

  -- NOTE: optional blink completion source for require statements and module annotations
  { -- optional blink completion source for require statements and module annotations
    'saghen/blink.cmp',
    opts = {
      sources = {
        -- add lazydev to your completion providers
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
    },
  },
}
