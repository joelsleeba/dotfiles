" Vim Configuration

" Package Manager: vim-plug
call plug#begin()

" Plugins
Plug 'junegunn/vim-plug'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'lervag/vimtex'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-commentary'
Plug 'joshdick/onedark.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" Relative Line Numbers
set number
set relativenumber
set belloff=all
set mouse=a
let mapleader = " "

" Theme: onedark
set t_Co=256
colorscheme onedark

" Snippets
let g:UltiSnipsExpandTrigger = "<Enter>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='sioyek'
set conceallevel=1
let g:tex_conceal='abdmg'
let g:vimtex_compiler_latexmk = { 
	        \ 'executable' : 'latexmk',
					\ 'OPTIONS' : [ 
					\   '-xelatex',
					\   '-file-line-error',
					\   '-synctex=1',
					\   '-interaction=nonstopmode',
					\ ],
					\}

"synctex function 
function! Synctex()
	        " remove 'silent' for debugging
					execute "silent !zathura --synctex-forward " . line('.') . ":" . col('.') . ":" . bufname('%') . " " . g:syncpdf
endfunction
map <C-enter> :call Synctex()<cr>
					

" File Explorer
map <C-n> :NERDTreeToggle<CR>

" Vim-airline
let g:airline_powerline_fonts = 1

" Commenting
nnoremap <leader>c <Esc>:Commentary<CR>
vnoremap <leader>c <Esc>:Commentary<CR>

" Code Completion
set completeopt=noinsert,menuone
let g:coc_global_extensions = ['coc-python']

" Keybindings
"<C-s> - save current file
nmap <C-s> :w<CR>
" <leader>q - quit current file
nmap <leader>q :q<CR>
" <leader>t - open tagbar
nmap <leader>t :TagbarToggle<CR>

" Convenient keybindings to change window focus
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Vim cursor
let &t_SI = "\<esc>[5 q"  " blinking I-beam in insert mode
let &t_SR = "\<esc>[3 q"  " blinking underline in replace mode
let &t_EI = "\<esc>[ q"  " default cursor (usually blinking block) otherwise

" remappign j and k for softjumps
noremap j gj
noremap k gk
