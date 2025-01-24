return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "jay-babu/mason-nvim-dap.nvim",
        { "theHamsta/nvim-dap-virtual-text", opts = {} },
    },
    keys = {
        {
            "<leader>db",
            function()
                require("dap").toggle_breakpoint()
            end,
            desc = "Debug: Toggle Breakpoint",
        },
        {
            "<leader>dB",
            function()
                require("dap").set_breakpoint()
            end,
            desc = "Debug: Set Breakpoint",
        },
    },
    config = function(_, opts)
        local dap, dapui = require("dap"), require("dapui")

        require("mason-nvim-dap").setup({
            automatic_installation = true,

            handlers = {},

            ensure_installed = {
                -- "delve",
            },
        })

        dap.adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
                command = "node",
                args = { js_adapter, "${port}" },
            },
        }

        local languages = { "typescript", "javascript" }

        for _, language in ipairs(languages) do
            dap.configurations[language] = {
                {
                    type = "pwa-node",
                    request = "launch",
                    name = "Node",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                },
                {
                    type = "pwa-node",
                    request = "launch",
                    name = "Deno",
                    runtimeExecutable = "deno",
                    runtimeArgs = {
                        "run",
                        "--inspect-wait",
                        "--allow-all",
                    },
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                    attachSimplePort = 9229,
                },
                {
                    type = "pwa-node",
                    request = "attach",
                    name = "Attach",
                    pid = require("dap.utils").pick_process,
                    cwd = "${workspaceFolder}",
                },
            }
        end

        dapui.setup()

        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close

        local map = vim.keymap.set

        map("n", "<leader>dc", function()
            dap.continue()
        end, { desc = "Debug: Start/Continue" })

        map("n", "<leader>dx", function()
            dap.restart()
        end, { desc = "Debug: Restart" })

        map("n", "<leader>di", function()
            dap.step_into()
        end, { desc = "Debug: Step Into" })

        map("n", "<leader>dv", function()
            dap.step_over()
        end, { desc = "Debug: Step Over" })

        map("n", "<leader>do", function()
            dap.step_out()
        end, { desc = "Debug: Step Out" })

        map("n", "<leader>dk", function()
            dap.step_back()
        end, { desc = "Debug: Step Back" })

        map("n", "<leader>dq", function()
            dap.terminate()
        end, { desc = "Debug: Terminate" })

        map({ "n", "v" }, "<leader>dh", function()
            require("dap.ui.widgets").hover()
        end, { desc = "Debug: Hover" })

        map({ "n", "v" }, "<leader>dp", function()
            require("dap.ui.widgets").preview()
        end, { desc = "Debug: Preview" })

        map("n", "<leader>df", function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.frames)
        end, { desc = "Debug: float frame" })

        map("n", "<leader>ds", function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.scopes)
        end, { desc = "Debug: float scopes" })

        vim.api.nvim_create_user_command("DAPUIopen", function()
            dapui.open()
        end, {})

        vim.api.nvim_create_user_command("DAPUIclose", function()
            dapui.close()
        end, {})

        vim.api.nvim_create_user_command("DAPUItoggle", function()
            dapui.toggle()
        end, {})

        vim.api.nvim_create_user_command("DAPUIfloat", function()
            dapui.float_element()
        end, {})

        vim.api.nvim_create_user_command("DAPUIeval", function()
            dapui.eval(nil, { enter = true })
        end, {})
    end,
}
