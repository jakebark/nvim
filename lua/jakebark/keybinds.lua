vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", ":Vex<CR>")
vim.keymap.set("n", "Z", vim.cmd.Ex)
vim.keymap.set("n", "<leader><CR>", ":so ~/.config/nvim/init.lua<CR>")
vim.keymap.set("n", "<leader>gf", ":GFiles<CR>")
vim.keymap.set("n", "<leader>ff", ":Files<CR>")
vim.keymap.set("n", "C-j", "cnext<CR")
vim.keymap.set("n", "C-k", "cprev<CR")

-- copy and paste to clipboard
vim.keymap.set("n", "<leader>y", [["+y]]) 
vim.keymap.set("n", "<leader>Y", [["+Y]])



