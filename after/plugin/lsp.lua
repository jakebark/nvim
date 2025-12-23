local servers = {
    lua_ls = {
        filetypes = { "lua" },
        cmd = { "lua-language-server" },
        settings = {
            Lua = {
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = { enable = false },
            }
        }
    },
    gopls = {
        filetypes = { "go" },
        cmd = { "gopls" }
    },
    pylsp = {
        filetypes = { "python" },
        cmd = { "pylsp" }
    },
    rust_analyzer = {
        filetypes = { "rust" },
        cmd = { "rust-analyzer" }
    },
    terraformls = {
        filetypes = { "terraform" },
        cmd = { "terraform-ls", "serve" }
    },
    jsonls = {
        filetypes = { "json" },
        cmd = { "json-languageserver", "--stdio" }
    },
    yamlls = {
        filetypes = { "yaml" },
        cmd = { "yaml-language-server", "--stdio" }
    },
    dockerls = {
        filetypes = { "dockerfile" },
        cmd = { "docker-langserver", "--stdio" }
    },
    vimls = {
        filetypes = { "vim" },
        cmd = { "vim-language-server", "--stdio" }
    }
}

local server_names = vim.tbl_keys(servers) -- {"lua_ls", "gopls", "jsonls"}
local all_filetypes = {}                   -- {"lua", "go", "json"}
for _, config in pairs(servers) do
    vim.list_extend(all_filetypes, config.filetypes)
end


require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = server_names
})

local capabilities = require('cmp_nvim_lsp').default_capabilities() -- enhance default LSP with autocomplete (hrsh7th/cmp-nvim-lsp)

local on_attach = function(client, bufnr)
    -- auto-format on save
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
        })
    end
end


local filetype_to_server = {} -- ["lua"] = "lua_ls"
for server_name, config in pairs(servers) do
    for _, filetype in ipairs(config.filetypes) do
        filetype_to_server[filetype] = server_name
    end
end
-- start lsp when file type is opened
-- create lookup for lsp, rather than search
vim.api.nvim_create_autocmd("FileType", {
    pattern = all_filetypes,

    callback = function()
        local ft = vim.bo.filetype                 -- "lua"
        local server_name = filetype_to_server[ft] -- "lua_ls"
        local config = servers[server_name]        -- gets the full config

        if config then
            vim.lsp.start({
                name = server_name,
                cmd = config.cmd,
                root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1]),
                capabilities = capabilities,
                on_attach = on_attach,
                settings = config.settings,
            })
        end
    end,
})
vim.diagnostic.config({
    virtual_text = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = 'E',
            [vim.diagnostic.severity.WARN] = 'W',
            [vim.diagnostic.severity.HINT] = 'H',
            [vim.diagnostic.severity.INFO] = 'I',
        }
    }
})

-- JSON formatting with jq
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.json",
    callback = function()
        vim.cmd(":%!jq .")
    end,
})

local cmp = require('cmp') -- configure hrsh7th/nvim-cmp for autocomplete, use L3MON4D3/LuaSnip for expanding snippets
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    -- completion sources in priority order
    sources = cmp.config.sources({
        -- primary
        { name = 'nvim_lsp' }, -- lsp completions
        -- { name = 'nvim_lua' }, -- lua API completion
        { name = 'luasnip' },  -- snippet completions
    }, {
        -- secondary
        { name = 'buffer' }, -- buffer text completions
        { name = 'path' },   -- file path completions
    })
})
