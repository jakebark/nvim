local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})

-- find files in nvim directory
vim.keymap.set('n', '<leader>cv', function()
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = 'config > nvim' })

-- find files in notes
vim.keymap.set('n', '<leader>mn', function()
    builtin.find_files { cwd = "./notes" }
end, { desc = 'my notes' })

-- find files in notes
vim.keymap.set('n', '<leader>/', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = 'fuzzy find current buffer' })
