" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype on

se
" TODO: Load plugins here (pathogen or vundle)

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on
set onmifunc=syntaxcomplete#Complete
autocmd FileType * setlocal omnifunc=syntaxcomplete#Complete
noremap <A-j> <C-x><C-o>
noremap <A-k> <C-x><C-o><Up>

" set leader to space
let mapleader = "\<Space>"

" Security
set modelines=0

" Show line numbers
set number

" Highlight cursor line
" set cursorline

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
" set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=20
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Enable auto completion menu after pressing TAB
" set wildmenu


" Make wildmenu behave like bash completion
" set wildmode=list:longest


" Textmate holdouts

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Color scheme (terminal)
set background=dark

" set everything to be unfolded
set foldlevelstart=99

" disabel visual bells
set noerrorbells
set belloff=all

" enable relative lines
set relativenumber

" PLUGINS ---------------------------------------------------------------- {{{

" Plugin code goes here.

" }}}


" MAPPINGS --------------------------------------------------------------- {{{

" Mappings code goes here.

" global mappings

" Map Ctrl + d to duplicate line or selection
nnoremap <C-d> :<C-u>normal! yyp<CR>
vnoremap <C-d> :<C-u>normal! y<CR>gvP

nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
inoremap <C-S-s> <ESC>:%s/\<<C-r><C-w>\>\\g<Left><Left>

noremap <M-1> {
noremap <C-c> <ESC>

inoremap <A-S-j> <ESC>:m +1<CR>i
inoremap <A-S-k> <ESC>:m -2<CR>i

nnoremap <A-S-j> :m +1<CR>
nnoremap <A-S-k> :m -2<CR>

nnoremap <leader>ö jA
nnoremap <leader>Ö kA

nnoremap ö [
inoremap ö [
vnoremap ö [
xnoremap ö [
cnoremap ö [
onoremap ö [
snoremap ö [

nnoremap Ö <
inoremap Ö <
vnoremap Ö <
xnoremap Ö <
cnoremap Ö <
onoremap Ö <
snoremap Ö <

nnoremap ä ]
inoremap ä ]
vnoremap ä ]
xnoremap ä ]
cnoremap ä ]
onoremap ä ]
snoremap ä ]

nnoremap Ä >
inoremap Ä >
vnoremap Ä >
xnoremap Ä >
cnoremap Ä >
onoremap Ä >
snoremap Ä >

nnoremap ü {
inoremap ü {
vnoremap ü {
xnoremap ü {
cnoremap ü {
onoremap ü {
snoremap ü {

noremap ciö ci[
noremap ciÖ ci<
noremap ciä ci]
noremap ciÄ ci>
noremap ciü ci{

noremap diö di[
noremap diÖ di<
noremap diä di]
noremap diÄ di>
noremap diü di{

noremap yiö yi[
noremap yiÖ yi<
noremap yiä yi]
noremap yiÄ yi>
noremap yiü yi{

noremap caö ca[
noremap caÖ ca<
noremap caä ca]
noremap caÄ ca>
noremap caü ca{

noremap daö da[
noremap daÖ da<
noremap daä da]
noremap daÄ da>
noremap daü da{

noremap yaö ya[
noremap yaÖ ya<
noremap yaä ya]
noremap yaÄ ya>
noremap yaü ya{

inoremap Ü {<ENTER>}<ESC>O

nnoremap <C-y> V<DEL>
inoremap <C-y> <ESC>V<DEL>

" insert line above
nnoremap <C-S-ENTER> O<Esc>
inoremap <C-S-ENTER> <Esc>O

" insert line below
nnoremap <S-ENTER> o<ESC>k
inoremap <S-ENTER> <ESC>o<ESC>ki

" define groups of filetypes
" c-like mappings
let s:c_type = 'c,cpp,ino,check'
autocmd FileType <expr> c_type,java inoremap <buffer> # <ESC>A; <ESC>o
autocmd FileType <expr> c_type ,java inoremap <buffer> <M-#> #
autocmd FileType <expr> c_type inoremap <buffer> ß ->
autocmd FileType <expr> c_type inoremap <buffer> <leader>ppoi ->


" python specific mappings
let s:python_type = 'python,ipynb'

autocmd FileType <expr> python_type inoremap <buffer> ß <END>-><SPACE>
autocmd FileType <expr> python_type inoremap <buffer> <leader>sse self.
autocmd FileType <expr> python_type inoremap <buffer> # <END>:<ESC>o

autocmd FileType <expr> python_type inoremap <buffer> ß <END>-><SPACE>
autocmd FileType <expr> python_type inoremap <buffer> <leader>sse self.

" vhdl specific mappings
let s:vhdl_type = 'vhdl,vhd'
autocmd FileType <expr> vhdl_type inoremap <buffer> ß <=
autocmd FileType <expr> vhdl_type inoremap <buffer> <S-ß> =>

" java specific mappings
autocmd FileType java inoremap <buffer> ß <END>:<SPACE>

" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" More Vimscripts code goes here.

" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.

" }}}
