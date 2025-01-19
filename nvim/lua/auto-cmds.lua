vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python", "bash", "sh", "conf" },
    callback = function()
        vim.keymap.set('x', '<leader>/', ':norm I#<CR>', { buffer = true })
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact", "cpp", "c", "java" },
    callback = function()
        vim.keymap.set('x', '<leader>/', ':norm I//<CR>', { buffer = true })
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua" },
    callback = function()
        vim.keymap.set('x', '<leader>/', ':norm I--<CR>', { buffer = true })
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html" },
    callback = function()
        vim.keymap.set('x', '<leader>/', ':norm I<!--<Esc>A--><CR>', { buffer = true })
    end
})
