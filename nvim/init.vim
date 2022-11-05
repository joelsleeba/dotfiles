call plug#begin()

" vimtex
Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" snippets library
Plug 'honza/vim-snippets'

" snippets engine
Plug 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger="<return>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Code Completer.
" Configured for C-type languages C#, Node.JS, TypeScript,
" Python and Java. Support can be added for Golang and Rust.
Plug 'ycm-core/YouCompleteMe'

"Code Formatter
Plug 'sbdchd/neoformat'
let UNCRUSTIFY_CONFIG="$HOME/.config/uncrustify/uncrustify.cfg"

" Syntax Highlighting for i3config
Plug 'mboughaba/i3config.vim'

" For the sidebar file explorer
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'

" gruvbox theme for nvim
Plug 'morhetz/gruvbox'

call plug#end()

" Keymaps
nnoremap <C-n> :NvimTreeToggle<CR>

" for line numbers
set number
set foldmethod=indent
colorscheme gruvbox
:lua require'nvim-tree'.setup()

