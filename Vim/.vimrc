" set Unix EOL
set ff=unix

" Don't try to be vi compatible
set nocompatible

" set no temporary files
set nobackup
set noswapfile

" set language to english
set langmenu=en_US.UTF-8
language messages en_US.UTF-8

" Helps force plugins to load correctly when it is turned back on below
filetype on

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on
autocmd FileType * setlocal omnifunc=syntaxcomplete#Complete

" function! TriggerOrMoveOmni()
  " if pumvisible()
    " return "\<C-o>"
  " else
    " return "\<C-x>\<C-o>"
  " endif
" endfunction


function! TriggerOrMoveOmni()
  if pumvisible()
    return "\<C-n>"
  else
    return "\<C-x>\<C-n>"
  endif
endfunction

inoremap <expr> <A-j> TriggerOrMoveOmni()
inoremap <A-k> <C-p>

" set leader to space
let mapleader = '´'
" let mapleader = "\<Space>"

" Security
set modelines=0

" Show line numbers
set number

" Highlight cursor line
set cursorline

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
" set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=1080  
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

" Set use all coloursset
set t_Co=256
if (has("termguicolors"))
    set termguicolors
endif

syntax enable

" set everything to be unfolded
set foldlevelstart=99

" disabel visual bells
set noerrorbells
set belloff=all

" enable relative lines
set relativenumber

" show match count
" set shortmess-=S

" PLUGINS ---------------------------------------------------------------- {{{

" Plugin code goes here.
"
" Fuzzy search thingy

function! DynamicSearch() abort
    let l:pattern = ''
    let l:currfile = expand('%:p')

    :echo ' > '

    while 1
      let l:key = getchar()
        if l:key == 0x1b
            cclose
            break
        elseif l:key  == 0x0d
            break

        elseif l:key == "\<BS>"
            let pattern = substitute(pattern, '.$', '', '')

        else 
            let l:key = nr2char(l:key)
            let l:pattern .= l:key
        endif
        
         let l:cmd_ll =  'vimgrep /' . l:pattern . '/gfc ' . l:currfile
         execute l:cmd_ll
         copen
         redraw
        echon ' > ' . l:pattern
    endwhile
endfunction


nnoremap <leader>fs :call DynamicSearch()<CR>
nnoremap <silent> <buffer> <M-j> :cnext<CR>
nnoremap <silent> <buffer> <M-k> :cprev<CR>
" nnoremap <silent> <buffer> <M-l> :cfirst<CR>
nnoremap <silent> <buffer> <leader>cc :cclose<CR>


function! DynamicSearchFiles() abort
  let l:pattern = ''
  let l:currdir = expand('%:p:h')
  let l:cmd = ''

  echo ' > '

  while 1
    let l:key = getchar()
    if l:key == 0x1b
      cclose
      break
    elseif l:key  == 0x0d
      break
    elseif l:key == "\<BS>"
      let l:pattern = substitute(l:pattern, '.$', '', '')
    else
      let l:key = nr2char(l:key)
      let l:pattern .= l:key
    endif

    let l:cmd = 'silent! execute "!" . "find " . l:currdir . " -type f -name " . shellescape(l:pattern) . " 2>/dev/null"'
    let l:result = system(l:cmd)
    cexpr l:result
    copen
    redraw
    echon ' > ' . l:pattern
  endwhile

  nnoremap <buffer> <CR> :call OpenQuickfixEntry()<CR>
endfunction

function! OpenQuickfixEntry() abort
  let l:entry = getqflist()[getqflistindex()]
  execute 'silent! edit ' . l:entry['filename']
endfunction

nnoremap <leader>ff :call DynamicSearchFiles()<CR>

" }}}


" MAPPINGS --------------------------------------------------------------- {{{

" Mappings code goes here.

" global mappings

" Map Ctrl + d to duplicate line or selection
" nnoremap <C-d> :<C-u>normal! yyp<CR>
" vnoremap <C-d> :<C-u>normal! y<CR>gvP

nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
inoremap <C-S-l> <ESC>:%s/\<<C-r><C-w>\>\\g<Left><Left>

noremap <M-1> {
noremap <C-c> <ESC>

inoremap <A-S-j> <ESC>:m +1<CR>i
inoremap <A-S-k> <ESC>:m -2<CR>i

nnoremap <A-S-j> :m +1<CR>
nnoremap <A-S-k> :m -2<CR>

" nnoremap <leader>[ jA
" nnoremap <leader>< kA

set langmap=öäÖÄü;<>[]{

imap ö <
imap ä >
imap Ö [
imap Ä ]
imap ü {

nnoremap <leader>ö jA
nnoremap <leader>Ö kA

nnoremap <C-y> V<DEL>
inoremap <C-y> <ESC>V<DEL>

" insert line above
nnoremap <C-ENTER> iquesito
nnoremap <leader>f O<Esc>
inoremap <C-ENTER> <Esc>O
" TODO fix the mapping
" nnoremap <C-S-ENTER> O<Esc>
" inoremap <C-S-ENTER> <Esc>O

" insert line below
nnoremap <S-ENTER> o<ESC>k
inoremap <S-ENTER> <ESC>o<ESC>ki


" Map a key (change the key as needed) to invoke the function
inoremap <expr> <leader>lc '<C-o>:call ToggleLineComment()<CR>'
nnoremap <leader>lc :call ToggleLineComment()<CR>


" define groups of filetypes
" c-like mappings
let s:c_type = 'c,cpp,ino,check'
execute 'autocmd FileType ' . s:c_type . ',java inoremap <buffer> # <ESC>A; <ESC>o'
execute 'autocmd FileType ' . s:c_type . ',java inoremap <buffer> <M-#> #'
execute 'autocmd FileType ' . s:c_type . ' inoremap <buffer> ß ->'
execute 'autocmd FileType ' . s:c_type . ' inoremap <buffer> <leader>ppoi ->'


" python specific mappings
let s:python_type = 'python,ipynb'

execute 'autocmd FileType ' . s:python_type . ' inoremap <buffer> ß <END>-><SPACE>'
execute 'autocmd FileType ' . s:python_type . ' inoremap <buffer> <leader>sse self.'
execute 'autocmd FileType ' . s:python_type . ' inoremap <buffer> # <END>:<ESC>o'

execute 'autocmd FileType ' . s:python_type . ' inoremap <buffer> ß <END>-><SPACE>'
execute 'autocmd FileType ' . s:python_type . ' inoremap <buffer> <leader>sse self.'

" vhdl specific mappings
let s:vhdl_type = 'vhdl,vhd'
execute 'autocmd FileType ' . s:vhdl_type . ' inoremap <buffer> ß <='
execute 'autocmd FileType ' . s:vhdl_type . ' inoremap <buffer> <S-ß> =>'

" java specific mappings
autocmd FileType java inoremap <buffer> ß <END>:<SPACE>

" Toggle comments stuff

" Define the line_comment variable (change the value as needed)
let s:line_comment = ''

execute 'autocmd FileType ' . s:c_type . ' let s:line_comment = "//"'
execute 'autocmd FileType ' . s:python_type . ' let s:line_comment = "#"'
execute 'autocmd FileType ' . s:vhdl_type . ' let s:line_comment = "--"'

" Function to toggle line comment
function! HasLineComment()

  " Get the first characters of the current line
  let current_line = getline('.')
  let first_chars = current_line[0:len(s:line_comment)-1]

  " Check if the first characters match the line comment string
  if first_chars ==# s:line_comment
    return 1
  else
    return 0
  endif
endfunction


function! ToggleLineComment()
    let cursor_pos = getpos('.')
    let column = cursor_pos[2]

    if HasLineComment()
        " Remove line comment
        let cursor_pos[2] -= (len(s:line_comment)+1)
        execute "normal! 0".(len(s:line_comment)+1)."x"
        
    else
        " Add line comment
        let cursor_pos[2] += (len(s:line_comment)+1)
        execute "normal! I".s:line_comment." "

    endif

    " execute command
    call setpos('.', cursor_pos)
endfunction

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
