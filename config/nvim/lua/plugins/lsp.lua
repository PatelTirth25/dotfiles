return {
    {
        "neovim/nvim-lspconfig",

        dependencies = {
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        {
                            path = "${3rd}/luv/library",
                            words = { "vim%.uv" },
                        },
                    },
                },
            },

            {
                "williamboman/mason.nvim",
                config = true,
            },

            {
                "williamboman/mason-lspconfig.nvim",
                config = true,
            },
        },

        config = function()
            vim.diagnostic.config({
                signs = false,
                virtual_text = true,
                underline = true,
                update_in_insert = true,
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),

                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, {
                            buffer = event.buf,
                            desc = "LSP: " .. desc,
                        })
                    end

                    local telescope = require("telescope.builtin")

                    map("gd", telescope.lsp_definitions, "[G]oto [D]efinition")
                    map("gr", telescope.lsp_references, "[G]oto [R]eferences")
                    map("gi", telescope.lsp_implementations, "[G]oto [I]mplementation")
                    map("<leader>D", telescope.lsp_type_definitions, "Type [D]efinition")
                    map("<leader>ds", telescope.lsp_document_symbols, "[D]ocument [S]ymbols")

                    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                    map("K", vim.lsp.buf.hover, "Hover Documentation")

                    local client = vim.lsp.get_client_by_id(event.data.client_id)

                    if client and client.server_capabilities.documentHighlightProvider then
                        local highlight_group =
                            vim.api.nvim_create_augroup(
                                "kickstart-lsp-highlight",
                                { clear = false }
                            )

                        vim.api.nvim_create_autocmd(
                            { "CursorHold", "CursorHoldI" },
                            {
                                buffer = event.buf,
                                group = highlight_group,
                                callback = vim.lsp.buf.document_highlight,
                            }
                        )

                        vim.api.nvim_create_autocmd(
                            { "CursorMoved", "CursorMovedI" },
                            {
                                buffer = event.buf,
                                group = highlight_group,
                                callback = vim.lsp.buf.clear_references,
                            }
                        )

                        vim.api.nvim_create_autocmd("LspDetach", {
                            group = vim.api.nvim_create_augroup(
                                "kickstart-lsp-detach",
                                { clear = true }
                            ),

                            callback = function(event2)
                                vim.lsp.buf.clear_references()

                                vim.api.nvim_clear_autocmds({
                                    group = "kickstart-lsp-highlight",
                                    buffer = event2.buf,
                                })
                            end,
                        })
                    end
                end,
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client =
                        vim.lsp.get_client_by_id(args.data.client_id)

                    if not client then
                        return
                    end

                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = args.buf,

                            callback = function()
                                vim.lsp.buf.format({
                                    bufnr = args.buf,
                                    id = client.id,
                                })
                            end,
                        })
                    end
                end,
            })

            local capabilities =
                require("cmp_nvim_lsp").default_capabilities()

            local servers = {
                ts_ls = {
                    filetypes = {
                        "javascript",
                        "typescript",
                        "javascriptreact",
                        "typescriptreact",
                    },
                },

                clangd = {},

                rust_analyzer = {},

                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                        },
                    },
                },
            }

            require("mason").setup()

            require("mason-lspconfig").setup({
                ensure_installed = vim.tbl_keys(servers),
            })

            for server_name, server in pairs(servers) do
                server.capabilities = vim.tbl_deep_extend(
                    "force",
                    {},
                    capabilities,
                    server.capabilities or {}
                )

                vim.lsp.config(server_name, server)
                vim.lsp.enable(server_name)
            end
        end,
    },
}
