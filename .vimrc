" Setup!
" $ vim +PlugInstall +qall > /dev/null
" coc requires node
" $ curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
"
" Where's my vim?
" :version
" :echo expand('~')
" :echo $HOME
" :echo $VIM
" :echo $VIMRUNTIME
"

" auto install
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'bling/vim-airline'
Plug 'dikiaap/minimalist'
Plug 'ervandew/screen'
Plug 'flazz/vim-colorschemes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()

try
    colorscheme gruvbox
    let g:gruvbox_italic=0
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default " need better default
endtry

filetype plugin indent on
filetype off                  " required

"let g:gruvbox_termcolors=256

" Powerline setup
set autoindent    " align the new line indent with the previous line
set background=dark
set backspace=indent,eol,start  " more powerful backspacing
set cursorline	  " highlist current line
set expandtab     " insert spaces when hitting TABs
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2
set nocompatible              " be iMproved, required
set nomodeline
set number
set relativenumber
set shiftround    " round indent to multiple of 'shiftwidth'
set shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns
set showcmd	  " show last command entered in the bottom bar
set softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set splitright
set tabstop=4     " a hard TAB displays as 4 columns
set textwidth=79  " lines longer than 79 columns will be broken

syntax enable
"autocmd vimenter * NERDTree " sets nerd tree to start up on vim load
hi CursorLine term=bold cterm=bold guibg=Grey40

" set esc to jj and leader to space 
inoremap jj <Esc>
nnoremap ; :

" coc completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

"fzf
nnoremap <LocalLeader>f :Files<CR>
nnoremap <LocalLeader>ff :GFiles<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

let maplocalleader = " "

let g:tex_flavor = "latex"
autocmd filetype python     setlocal ts=4 sts=4 sw=4
autocmd filetype tex        setlocal ts=2 sts=2 sw=2
autocmd filetype html       setlocal ts=2 sts=2 sw=4
autocmd filetype javascript setlocal ts=2 sts=2 sw=4

" better vim split movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" compile latex
nnoremap <leader>ll :w<CR>:!latexmk -pdf %<CR>

" upon saving, delete trailing whitespace
autocmd BufWritePre *.py :%s/\s\+$//e

" airline {{{
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" use simple separators
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_left_sep=''
let g:airline_right_sep=''
" Explode airline from preview windows
let g:airline_exclude_preview = 1
let g:airline#extensions#ctrlp#color_template = 'normal'
"}}}
"
" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1

" Open a .py file, hit space + p to tmux a script with ipython
" visually select a block of code and type space + v to send it to ipython
" ipyhon tmux integration {{{
let g:ScreenImpl = "Tmux"

" Open an ipython3 shell below current pane
autocmd FileType python map <LocalLeader>P :ScreenShell ipython<CR>

" Open an ipython3 shell above urrent pane
autocmd FileType python map <LocalLeader>p :ScreenShell! ipython<CR>

"autocmd FileType python map <LocalLeader>p :IPython!  <CR>
"
" Close whichever shell is running.
autocmd FileType python map <LocalLeader>q :ScreenQuit<CR>
" Send current line to python and move to next line.
autocmd FileType python map <LocalLeader>rp V:ScreenSend<CR>
" Send visual selection to python and move to next line.
autocmd FileType python map <LocalLeader>v :ScreenSend<CR>`>0j
" Send a carriage return line to python.
autocmd FileType python map <LocalLeader>a :call g:ScreenShellSend("\r")<CR>
" Clear screen.
autocmd FileType python map <LocalLeader>L
                        \ :call g:ScreenShellSend('!clear')<CR>
" Start a time block to execute code in.
autocmd FileType python map <LocalLeader>t
                        \ :call g:ScreenShellSend('%%time')<CR>
" Start a timeit block to execute code in.
autocmd FileType python map <LocalLeader>tt
                        \ :call g:ScreenShellSend('%%timeit')<CR>
" Start a debugger repl to execute code in.
autocmd FileType python map <LocalLeader>db
                        \ :call g:ScreenShellSend('%%debug')<CR>
" Start a profiling block to execute code in.
autocmd FileType python map <LocalLeader>pr
                        \ :call g:ScreenShellSend('%%prun')<CR>
" Print the current working directory.
autocmd FileType python map <LocalLeader>gw
                        \ :call g:ScreenShellSend('!pwd')<CR>
" Set working directory to current file's folder.
function! SetWD()
        let wd = '!cd ' . expand('%:p:h')
        :call g:ScreenShellSend(wd)
endfunction
autocmd FileType python map <LocalLeader>sw :call SetWD()<CR>
" Get ipython help for word under cursor. Complement it with Shift + K.
function! GetHelp()
        let w = expand("<cword>") . "??"
        :call g:ScreenShellSend(w)
endfunction
autocmd FileType python map <LocalLeader>h :call GetHelp()<CR>
" Get `dir` help for word under cursor.
function! GetDir()
        let w = "dir(" . expand("<cword>") . ")"
        :call g:ScreenShellSend(w)
endfunction
"autocmd FileType python map <LocalLeader>d :call GetDir()<CR>
function! s:get_visual_selection()
endfunction
" Get `?` help for word under cursor.
function! GetHelpMagic()
        let foo_tmp =  GetVisual()
        let w = "?".foo_tmp
        :call g:ScreenShellSend(w)
endfunction
autocmd FileType python map <LocalLeader>dc :call GetHelpMagic()<CR>

" Get `dir` help for word under cursor.
function! GetLen()
        let w = "len(" . expand("<cword>") . ")"
        :call g:ScreenShellSend(w)
        echo  w
endfunction
autocmd FileType python map <LocalLeader>l :call GetLen()<CR>
"}}}
"
" py-doc bindings
let g:pydoc_open_cmd = 'vsplit'
let g:pydoc_cmd = '/Users/giulio/anaconda/bin/python -m pydoc'
"}}}
"
" run file
autocmd FileType python nnoremap  <buffer> <leader>r :exec '!python' shellescape(@%, 1)<cr>
" {{{ misc functinons
" gets the selected text in visual mode
function! GetVisual()
        " Why is this not a built-in Vim script function?!
        let [lnum1, col1] = getpos("'<")[1:2]
        let [lnum2, col2] = getpos("'>")[1:2]
        let lines = getline(lnum1, lnum2)
        let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
        let lines[0] = lines[0][col1 - 1:]
        return join(lines, "\n")
endfunction
"}}}

