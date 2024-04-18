vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", ":Vex<CR>")
vim.keymap.set("n", "Z", vim.cmd.Ex)
vim.keymap.set("n", "<leader><CR>", ":so ~/.config/nvim/init.lua<CR>")
-- vim.keymap.set("n", "<leader>cv", ":e ~/.config/nvim/<CR>")
vim.keymap.set("n", "<leader>mn", ":e ~/notes/<CR>")

vim.keymap.set("n", "<leader>gf", ":GFiles<CR>")
vim.keymap.set("n", "<leader>ff", ":Files<CR>")
vim.keymap.set("n", "C-j", "cnext<CR")
vim.keymap.set("n", "C-k", "cprev<CR")

-- copy and paste to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- grep
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- git
vim.keymap.set("n", "<leader>ga", ":!Git add .<CR>")
vim.keymap.set("n", "<leader>gc", ":!Git commit -m ")
vim.keymap.set("n", "<leader>gp", ":!Git push<CR>")
