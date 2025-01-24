return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            theme = "tokyonight-night",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            extensions = {
                "neo-tree",
                "mason",
                "nvim-dap-ui",
                "lazy",
                "aerial",
                "trouble",
                "quickfix",
            },
        },
        sections = {
            lualine_x = { "aerial" },
        },
    },
}
