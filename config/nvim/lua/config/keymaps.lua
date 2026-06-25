local key = vim.keymap.set

-- To remove highlight from search
key("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Keymap for comment
key("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", {})

-- Oil Nvim
key("n", "-", "<CMD>Oil<CR>", { desc = "Open Oil" })

-- To move entire lines up and down
key("v", "J", ":m '>+1<CR>gv=gv")
key("v", "K", ":m '<-2<CR>gv=gv")

-- Html folds
key("n", "<leader>z", "zfat")

-- Undo tree
key("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })

-- Fugitive git
key("n", "<leader>g", vim.cmd.Git, { desc = "Open Fugitive" })

-- Diagnostic keymaps (Neovim 0.12)
key("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic message" })

key("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic message" })

key("n", "<leader>e", vim.diagnostic.open_float, {
    desc = "Show diagnostic error messages",
})

-- Window navigation
key("n", "<C-h>", "<C-w><C-h>", {
    desc = "Move focus to the left window",
    noremap = true,
    silent = true,
})

key("n", "<C-l>", "<C-w><C-l>", {
    desc = "Move focus to the right window",
    noremap = true,
    silent = true,
})

key("n", "<C-j>", "<C-w><C-j>", {
    desc = "Move focus to the lower window",
    noremap = true,
    silent = true,
})

key("n", "<C-k>", "<C-w><C-k>", {
    desc = "Move focus to the upper window",
    noremap = true,
    silent = true,
})

-- Do not continue comments with o/O
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- Quick Fix
key("n", "<leader>q", function()
    local is_open = false

    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_config(win).relative == "" then
            local buf = vim.api.nvim_win_get_buf(win)

            if vim.bo[buf].buftype == "quickfix" then
                is_open = true
                break
            end
        end
    end

    if is_open then
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end, { desc = "Toggle Quickfix List" })

key("n", "]q", "<cmd>cnext<CR>", { desc = "Next Quickfix Item" })
key("n", "[q", "<cmd>cprev<CR>", { desc = "Previous Quickfix Item" })

-- Terminal
key("n", "<leader>ot", "<cmd>Floaterminal<CR>", {
    noremap = true,
    silent = true,
    desc = "Open Floating Terminal",
})

-- key("n", "<leader>ot", function()
--     vim.cmd.vnew()
--     vim.cmd.term()
--     vim.cmd.wincmd("J")
--     vim.api.nvim_win_set_height(0, 15)
-- end)

key("t", "<Esc><Esc>", "<C-\\><C-n>", {
    desc = "Escape terminal mode",
})
