return {
    {
        "stevearc/oil.nvim",
        lazy = false,

        dependencies = {
            {
                "echasnovski/mini.icons",
                opts = {},
            },
        },

        opts = {
            view_options = {
                show_hidden = true,
            },

            win_options = {
                number = false,
                relativenumber = false,
            },

            keymaps = {
                ["<C-h>"] = false,
                ["<C-l>"] = false,
                ["<C-j>"] = false,
                ["<C-k>"] = false,
            },

            delete_to_trash = true,
        },
    },
}
