local key = vim.keymap.set

-- Tab space to 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.expandtab = true

-- Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Set no wrap
vim.opt.wrap = false

-- Highlight search matches
vim.opt.hlsearch = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Save undo history
vim.opt.undofile = true

-- Change behavior of d, c, p, D
key("n", "d", '"_d', { noremap = true, silent = true })
key("v", "d", '"_d', { noremap = true, silent = true })

key("n", "c", '"_c', { noremap = true, silent = true })
key("v", "c", '"_c', { noremap = true, silent = true })

key("n", "D", '"_D', { noremap = true, silent = true })

key("v", "p", '"_dP', { noremap = true, silent = true })

-- Case-insensitive searching unless capitals are used
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on
vim.opt.signcolumn = "yes"

-- Faster completion
vim.opt.updatetime = 250

-- Split behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live
vim.opt.inccommand = "split"

-- Highlight current line
vim.opt.cursorline = true

-- Keep cursor away from edges
vim.opt.scrolloff = 10

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Terminal settings
vim.api.nvim_create_autocmd("TermOpen", {
    desc = "Terminal settings inside nvim",
    group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end,
})
