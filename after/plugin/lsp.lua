require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        'dockerls',
        'gopls',
        'jsonls',
        'lua_ls',
        'pylsp',
        'rust_analyzer',
        'terraformls',
        'vimls',
        'yamlls',
    }
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

-- start lsp when file type is opened
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua", "go", "python", "rust", "terraform", "json", "yaml", "dockerfile", "vim" },
    callback = function()
        local server_configs = {
            lua = {
                name = "lua_ls",
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
            go = { name = "gopls", cmd = { "gopls" } },
            python = { name = "pylsp", cmd = { "pylsp" } },
            rust = { name = "rust_analyzer", cmd = { "rust-analyzer" } },
            terraform = { name = "terraformls", cmd = { "terraform-ls", "serve" } },
            json = { name = "jsonls", cmd = { "vscode-json-language-server", "--stdio" } },
            yaml = { name = "yamlls", cmd = { "yaml-language-server", "--stdio" } },
            dockerfile = { name = "dockerls", cmd = { "docker-langserver", "--stdio" } },
            vim = { name = "vimls", cmd = { "vim-language-server", "--stdio" } }
        }

        -- get buffer filetype, look up and start corresponding lsp server
        local ft = vim.bo.filetype
        local config = server_configs[ft]

        if config then
            vim.lsp.start({
                name = config.name,
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

