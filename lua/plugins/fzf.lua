return {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        {
            "<leader>fsf",
            function()
                require("fzf-lua").files({})
            end,
            desc = "Fzf [ Files ]",
        },
        {
            "<leader>fz",
            function()
                require("fzf-lua").files({ cwd = "~" })
            end,
            desc = "Fzf [ Global ]",
        },
        {
            "<leader>fsc",
            function()
                require("fzf-lua").files({ cwd = "~/.config" })
            end,
            desc = "Fzf [ Config ]",
        },
        {
            "<leader>fds",
            function()
                require("fzf-lua").lsp_document_symbols({})
            end,
            desc = "Fzf [ LSP Document Symbols ]",
        },
    },
    opts = {
        "fzf-native",
        winopts = { fullscreen = true },
        files = {
            previewer = "bat",
        },
    },
}
