local lsp = require("lsp-zero")

lsp.preset("recommended")

-- htts://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#configurations
lsp.ensure_installed({
    'rust_analyzer',
    'terraformls',
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

-- format on save
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
    lsp_zero.buffer_autoformat()
end)
