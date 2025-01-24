return {
    {
        "saghen/blink.compat",
        version = "*",
        lazy = true,
        opts = {},
    },
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "moyiz/blink-emoji.nvim",
            "mtoohey31/cmp-fish",
            "chrisgrieser/cmp-nerdfont",
        },
        version = "*",
        opts = {
            keymap = {
                preset = "default",
                cmdline = {
                    preset = "default",
                },
            },
            completion = {
                menu = {
                    max_height = 20,
                    border = "solid",
                    winblend = 10,
                    draw = {
                        columns = {
                            { "label", "label_description", gap = 1 },
                            { "kind_icon", "kind", gap = 1 },
                            { "source_name" },
                        },
                        components = {
                            kind_icon = {
                                ellipsis = false,
                                text = function(ctx)
                                    local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                                    return kind_icon
                                end,
                                highlight = function(ctx)
                                    local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                                    return hl
                                end,
                            },
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                    window = { border = "solid" },
                },
            },
            signature = {
                enabled = true,
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer", "emoji", "fish", "nerdfont" },
                providers = {
                    emoji = {
                        module = "blink-emoji",
                        name = "Emoji",
                        score_offset = 15,
                    },
                    fish = {
                        name = "fish",
                        module = "blink.compat.source",
                    },
                    nerdfont = {
                        name = "nerdfont",
                        module = "blink.compat.source",
                    },
                },
            },
        },
        opts_extend = { "sources.default" },
    },
}
