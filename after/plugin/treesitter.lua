require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "vim", "json", "rust", "hcl" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
    },
})
