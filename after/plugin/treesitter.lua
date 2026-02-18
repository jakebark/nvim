require("nvim-treesitter.configs").setup({
    ensure_installed = { "dockerfile", "go", "hcl", "json", "lua", "markdown", "python", "rust", "vim", "yaml" },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    modules = {},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})
