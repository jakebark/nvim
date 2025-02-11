local lsp = require("lsp-zero")

lsp.preset("recommended")
lsp.setup()
lsp.nvim_workspace() -- Fix Undefined global 'vim'

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
lsp.ensure_installed({
    'dockerls',
    'gopls',
    'jsonls',
    'lua_ls',
    'pylsp',
    'rust_analyzer',
    'terraformls',
    'vimls',
    'yamlls',
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

-- change autocomplete binds
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<CR>'] = nil --rm enter autocomplete
-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

vim.diagnostic.config({
    virtual_text = true
})

-- format on save
lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    lsp.buffer_autoformat()
end)
