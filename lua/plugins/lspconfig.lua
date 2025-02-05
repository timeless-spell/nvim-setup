return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'saghen/blink.cmp',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('<leader>lgd', vim.lsp.buf.definition, '[G]oto Definition')
        map('<leader>lgD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('<leader>lgi', vim.lsp.buf.implementation, '[G]oto Implementation')
        map('<leader>lgt', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')
        map('<leader>lsh', vim.lsp.buf.signature_help, '[S]ignature [H]elp')
        map('<leader>lre', vim.lsp.buf.references, '[Re]ferences')
        map('<leader>lrn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>lca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        map('<leader>lws', vim.lsp.buf.workspace_symbol, '[W}orkspace [S]ymbol')
        map('<leader>lds', vim.lsp.buf.document_symbol, '[D]ocument [S]ymbol')

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = event2.buf })
            end,
          })
        end

        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>lht', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    local capabilities = require('blink.cmp').get_lsp_capabilities()

    local servers = {
      lua_ls = {
        -- cmd = { ... },
        -- filetypes = { ... },
        -- capabilities = {},
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            diagnostics = {
              disable = {
                'missing-fields',
              },
            },
            hint = {
              enable = true,
            },
          },
        },
      },
    }

    require('mason').setup({
      ui = {
        border = 'rounded',
      },
    })

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua',
      'jdtls',
      'java-debug-adapter',
      'java-test',
    })
    require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

    require('mason-lspconfig').setup({
      handlers = {
        function(server_name)
          if server_name ~= 'jdtls' then
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end
        end,
      },
    })
  end,
}
