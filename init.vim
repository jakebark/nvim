set scrolloff=8
set number 
" set relativenumber 
set tabstop=4 softtabstop=4
set shiftwidth=4 
set expandtab
set smartindent 

call plug#begin(stdpath('data') . '/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'morhetz/gruvbox'

Plug 'tpope/vim-fugitive'

Plug 'hashivim/vim-terraform'

Plug 'ambv/black' "autoformat python
Plug 'neovim/nvim-lspconfig'

" debuggers
"Plug 'puremourning/vimspector' 
"Plug 'szw/vim-maximizer' 

Plug 'rust-lang/rust.vim'
"Plug 'tweekmonster/gofmt.vim'
"Plug 'junegunn/gv.vim'
"Plug 'vim-utils/vim-man'
"Plug 'mbbill/undotree'
"Plug 'theprimeagen/vim-be-good'
"Plug 'tpope/vim-projectionist'
"Plug 'dracula/vim', { 'as': 'dracula'}

":Plug 'ThePrimeagen/harpoon'

"Plug 'sbdchd/neoformat' 



call plug#end()

lua << EOF
require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "vim", "json", "rust", "hcl" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
    },
})
EOF

lua << EOF
local lspconfig = require('lspconfig')
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}
EOF

set background=dark
colorscheme gruvbox

let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap Z :w<CR>:Ex<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>gf :GFiles<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>
nnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG


