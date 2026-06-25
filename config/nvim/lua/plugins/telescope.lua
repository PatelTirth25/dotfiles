return {
    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",

        dependencies = {
            "nvim-lua/plenary.nvim",

            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",

                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },

            {
                "nvim-telescope/telescope-ui-select.nvim",
            },

            {
                "nvim-tree/nvim-web-devicons",
                enabled = vim.g.have_nerd_font,
            },
        },

        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")

            telescope.setup({
                pickers = {
                    find_files = {
                        hidden = true,
                        no_ignore = true,
                        respect_gitignore = true,
                    },
                },

                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                },
            })

            pcall(telescope.load_extension, "fzf")
            pcall(telescope.load_extension, "ui-select")

            vim.keymap.set(
                "n",
                "<leader>sh",
                builtin.help_tags,
                { desc = "[S]earch [H]elp" }
            )

            vim.keymap.set(
                "n",
                "<leader>k",
                builtin.keymaps,
                { desc = "[S]earch [K]eymaps" }
            )

            vim.keymap.set(
                "n",
                "<leader>ff",
                builtin.find_files,
                { desc = "[F]ind [F]iles" }
            )

            vim.keymap.set(
                "n",
                "<leader>fw",
                builtin.grep_string,
                { desc = "Search current [W]ord" }
            )

            vim.keymap.set(
                "n",
                "<leader>sw",
                builtin.live_grep,
                { desc = "[S]earch by [G]rep" }
            )

            vim.keymap.set(
                "n",
                "<leader>sd",
                builtin.diagnostics,
                { desc = "[S]earch [D]iagnostics" }
            )

            vim.keymap.set(
                "n",
                "<leader>sr",
                builtin.resume,
                { desc = "[S]earch [R]esume" }
            )

            vim.keymap.set(
                "n",
                "<leader>s.",
                builtin.oldfiles,
                { desc = '[S]earch Recent Files ("." for repeat)' }
            )

            vim.keymap.set(
                "n",
                "<leader><leader>",
                builtin.buffers,
                { desc = "Find existing buffers" }
            )

            vim.keymap.set("n", "<leader>/", function()
                builtin.current_buffer_fuzzy_find(
                    require("telescope.themes").get_dropdown({
                        winblend = 10,
                        previewer = false,
                    })
                )
            end, {
                desc = "Fuzzy search current buffer",
            })

            vim.keymap.set("n", "<leader>sb", function()
                builtin.live_grep({
                    grep_open_files = true,
                    prompt_title = "Live Grep in Open Files",
                })
            end, {
                desc = "Search in open buffers",
            })

            vim.keymap.set("n", "<leader>fn", function()
                builtin.find_files({
                    cwd = vim.fn.stdpath("config"),
                })
            end, {
                desc = "Find Neovim config files",
            })
        end,
    },
}
