return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'jay-babu/mason-nvim-dap.nvim',
    { 'theHamsta/nvim-dap-virtual-text', opts = {} },
  },
  keys = {
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>dB',
      function()
        require('dap').set_breakpoint()
      end,
      desc = 'Debug: Set Breakpoint',
    },
  },
  config = function(_, opts)
    local dap, dapui = require('dap'), require('dapui')

    require('mason-nvim-dap').setup({
      automatic_installation = true,

      handlers = {},

      ensure_installed = {
        -- "delve",
      },
    })

    dapui.setup()

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    local map = vim.keymap.set

    map('n', '<leader>dc', function()
      dap.continue()
    end, { desc = 'Debug: Start/Continue' })

    map('n', '<leader>dx', function()
      dap.restart()
    end, { desc = 'Debug: Restart' })

    map('n', '<leader>di', function()
      dap.step_into()
    end, { desc = 'Debug: Step Into' })

    map('n', '<leader>dv', function()
      dap.step_over()
    end, { desc = 'Debug: Step Over' })

    map('n', '<leader>do', function()
      dap.step_out()
    end, { desc = 'Debug: Step Out' })

    map('n', '<leader>dk', function()
      dap.step_back()
    end, { desc = 'Debug: Step Back' })

    map('n', '<leader>dq', function()
      dap.terminate()
    end, { desc = 'Debug: Terminate' })

    map({ 'n', 'v' }, '<leader>dh', function()
      require('dap.ui.widgets').hover()
    end, { desc = 'Debug: Hover' })

    map({ 'n', 'v' }, '<leader>dp', function()
      require('dap.ui.widgets').preview()
    end, { desc = 'Debug: Preview' })

    map('n', '<leader>df', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.frames)
    end, { desc = 'Debug: float frame' })

    map('n', '<leader>ds', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.scopes)
    end, { desc = 'Debug: float scopes' })

    vim.api.nvim_create_user_command('DAPUIopen', function()
      dapui.open()
    end, {})

    vim.api.nvim_create_user_command('DAPUIclose', function()
      dapui.close()
    end, {})

    vim.api.nvim_create_user_command('DAPUItoggle', function()
      dapui.toggle()
    end, {})

    vim.api.nvim_create_user_command('DAPUIfloat', function()
      dapui.float_element()
    end, {})

    vim.api.nvim_create_user_command('DAPUIeval', function()
      dapui.eval(nil, { enter = true })
    end, {})

    dap.configurations.java = {
      {
        name = 'Debug Launch (2GB)',
        type = 'java',
        request = 'launch',
        vmArgs = '' .. '-Xmx2g ',
      },
      {
        name = 'Debug Attach (8000)',
        type = 'java',
        request = 'attach',
        hostName = '127.0.0.1',
        port = 8000,
      },
      {
        name = 'Debug Attach (5005)',
        type = 'java',
        request = 'attach',
        hostName = '127.0.0.1',
        port = 5005,
      },
      {
        name = 'My Custom Java Run Configuration',
        type = 'java',
        request = 'launch',
        -- You need to extend the classPath to list your dependencies.
        -- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
        -- classPaths = {},

        -- If using multi-module projects, remove otherwise.
        -- projectName = "yourProjectName",

        -- javaExec = "java",
        mainClass = 'replace.with.your.fully.qualified.MainClass',

        -- If using the JDK9+ module system, this needs to be extended
        -- `nvim-jdtls` would automatically populate this property
        -- modulePaths = {},
        vmArgs = '' .. '-Xmx2g ',
      },
    }
  end,
}
