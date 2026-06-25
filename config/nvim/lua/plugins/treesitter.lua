return {
    {
        "nvim-treesitter/nvim-treesitter",

        build = ":TSUpdate",

        main = "nvim-treesitter.configs",

        opts = {
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "rust",

                "lua",
                "luadoc",
                "vim",
                "vimdoc",

                "javascript",
                "typescript",
                "tsx",

                "html",

                "json",
                "yaml",
                "toml",

                "markdown",
                "markdown_inline",

                "python",

                "diff",
                "query",
            },

            auto_install = true,

            highlight = {
                enable = true,
            },

            indent = {
                enable = true,
            },

            autotag = {
                enable = true,
            },

            incremental_selection = {
                enable = true,

                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<BS>",
                },
            },
        },
    },
}
