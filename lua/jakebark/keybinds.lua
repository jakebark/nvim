vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", ":Vex<CR>")
vim.keymap.set("n", "Z", vim.cmd.Ex)
vim.keymap.set("n", "<leader><CR>", ":so ~/.config/nvim/init.lua<CR>")
vim.keymap.set("n", "<leader>cv", ":e ~/.config/nvim/<CR>")
vim.keymap.set("n", "<leader>n", ":Notes<CR>")


vim.keymap.set("n", "<leader>gf", ":GFiles<CR>")
vim.keymap.set("n", "<leader>ff", ":Files<CR>")
vim.keymap.set("n", "<leader>pf", ":Vex<CR>:Files<CR>")
vim.keymap.set("n", "C-j", "cnext<CR")
vim.keymap.set("n", "C-k", "cprev<CR")


--vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
--vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Yank into system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y') -- yank motion
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+Y') -- yank line

-- Delete into system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"+d') -- delete motion
vim.keymap.set({ 'n', 'v' }, '<leader>D', '"+D') -- delete line

-- Paste from system clipboard
vim.keymap.set('n', '<leader>p', '"+p') -- paste after cursor
vim.keymap.set('n', '<leader>P', '"+P') -- paste before cursor

-- grep
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
