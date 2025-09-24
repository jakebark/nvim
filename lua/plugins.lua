-- install packer if not installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

-- first time startup
local packer_bootstrap = ensure_packer()

-- reload neovim whenever you save the packer.lua file
vim.cmd([[
  augroup packer_user_config
  autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'morhetz/gruvbox'
    use("hashivim/vim-terraform")
    use("tpope/vim-fugitive")
    use("tpope/vim-commentary") -- gc, gcc line, gcap para
    use("tpope/vim-surround")   -- S", cs'"
    use("mbbill/undotree")
    use("jakebark/notes.nvim")

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end, }

    use {
        'williamboman/mason.nvim',
        requires = {
            { 'williamboman/mason-lspconfig.nvim' },
        }
    }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            { 'hrsh7th/cmp-buffer' },           -- buffer text completions
            { 'hrsh7th/cmp-path' },             -- file paths completions
            { 'saadparwaiz1/cmp_luasnip' },     -- snippet completions
            { 'hrsh7th/cmp-nvim-lsp' },         -- lsp completions
            { 'hrsh7th/cmp-nvim-lua' },         -- lua API completion
            { 'L3MON4D3/LuaSnip' },             -- snippet completions
            { 'rafamadriz/friendly-snippets' }, -- prefined snippets, used by luasnip
        }
    }

    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        ft = { "markdown" },
    })
end)
