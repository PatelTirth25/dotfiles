return {
    {
        "numToStr/Comment.nvim",
        opts = {},
    },

    {
        "mbbill/undotree",
    },

    {
        "tpope/vim-fugitive",
    },

    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },

    {
        "windwp/nvim-autopairs",
        opts = {},
    },

    {
        "windwp/nvim-ts-autotag",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },

        opts = {
            enable_close = true,
            enable_rename = true,
            enable_close_on_slash = false,
        },
    },

    {
        "folke/todo-comments.nvim",
        event = "VimEnter",

        dependencies = {
            "nvim-lua/plenary.nvim",
        },

        opts = {
            signs = false,
        },
    },
}
