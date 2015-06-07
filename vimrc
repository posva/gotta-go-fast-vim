" Minimalistic vim config to go fast
" Eduardo San Martin Morote aka posva

" Load plugins rigth away
source ./vim-plugins.vim

" General options {
set nu " Show number lines

syntax on " syntax highlight

set encoding=utf-8

" Can delete previously edited text
set backspace=indent,eol,start

set langmenu=en_US.UTF-8 " sets the language of the menu (gvim)
language en_US.UTF-8  " sets the language of the messages / ui (vim)

" "Give me some space" said the cursor
"set scrolloff=15

set mouse=a " mouse is so usefull if well used

" Gotta go fast
set ttyfast
set lazyredraw

" Display non visible characters
set list
set listchars=tab:›\ ,trail:●,extends:#,nbsp:.

" Theme
" If you use a light terminal term change this to 'light'
set background=dark
colorscheme solarized
set cursorline

" relative line numbers
autocmd BufLeave * set norelativenumber
autocmd BufLeave * set number
autocmd BufEnter * set relativenumber
autocmd InsertEnter * set norelativenumber
autocmd InsertEnter * set number
autocmd InsertLeave * set relativenumber

" makes * and # work on visual mode too.
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" recursively vimgrep for word under cursor or selection if you hit leader-star
nmap <leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/ **'<CR>
vmap <leader>* :<C-u>call <SID>VSetSearch()<CR>:execute 'noautocmd vimgrep /' . @/ . '/ **'<CR>

" Some default indentation
set expandtab " uses spaces by default
set shiftwidth=2
set softtabstop=2
set smartindent " smart code indentation
set smarttab " smart tabs

set ignorecase " Do case in sensitive matching with
set smartcase " be sensitive when there's a capital letter

" Backup dir to keep your working dir clean
set backup
set backupdir=~/.vim/backup
set dir=~/.vim/backup

" Be polite!
set confirm

" tmux fix (background color erase)
set t_ut=

"show parial pattern matches in real time
set incsearch
" I like highlighted search pattern
set hlsearch
"display folders ( sympathie with the devil )
"set foldcolumn=1

" Disable ex mode
map Q <Nop>

" }

" Key Remapping and commands{Ä

" Visual shifting (does not exit Visual mode)
vnoremap < <gv[MaÄ
vnoremap > >gv

" Use , instead of \
let mapleader = ','

" Disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Exit insert mode with jj
imap jj <ESC>

" Center the view when moving
nmap H Hzz
nmap L Lzz

" Stop acting dumb when pasting
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Easily remove all trailing spaces
command Spaces %s/\s\+$\|\t\+$//g
" }

" Misc {
" common typing mistakes
abbreviate teh the
ab fro for
function CheckRo()
  if ! (&readonly)
    set fileencoding=utf-8
  endif
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  end
  return ''
endfunction

" Restore Cursor
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" Automatically create the directories we need
function! InitializeDirectories()
  let parent = $HOME
  let prefix = 'vim'
  let dir_list = {
        \ 'backup': 'backupdir',
        \ 'views': 'viewdir',
        \ 'swap': 'directory' }

  if has('persistent_undo')
    let dir_list['undo'] = 'undodir'
  endif

  let common_dir = parent . '/.' . prefix

  for [dirname, settingname] in items(dir_list)
    let directory = common_dir . dirname . '/'
    if exists("*mkdir")
      if !isdirectory(directory)
        call mkdir(directory)
      endif
    endif
    if !isdirectory(directory)
      echo "Warning: Unable to create backup directory: " . directory
      echo "Try: mkdir -p " . directory
    else
      let directory = substitute(directory, " ", "\\\\ ", "g")
      exec "set " . settingname . "=" . directory
    endif
  endfor
endfunction
call InitializeDirectories()
" }

" Plugins configs {
" Tabular {
nmap <leader>a& :Tabularize /&<CR>
vmap <leader>a& :Tabularize /&<CR>
nmap <leader>a= :Tabularize /=<CR>
vmap <leader>a= :Tabularize /=<CR>
nmap <leader>a: :Tabularize /:<CR>
vmap <leader>a: :Tabularize /:<CR>
nmap <leader>a:: :Tabularize /:\zs<CR>
vmap <leader>a:: :Tabularize /:\zs<CR>
nmap <leader>a, :Tabularize /,<CR>
vmap <leader>a, :Tabularize /,<CR>
nmap <leader>a,, :Tabularize /,\zs<CR>
vmap <leader>a,, :Tabularize /,\zs<CR>
nmap <leader>a<Bar> :Tabularize /<Bar><CR>
vmap <leader>a<Bar> :Tabularize /<Bar><CR>
" }
" sessionman {
set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
nmap <leader>sl :SessionList<CR>
nmap <leader>ss :SessionSave<CR>
nmap <leader>sc :SessionClose<CR>
" }
" Syntastic {
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1

" I prefer using python3
let g:syntastic_python_checkers = ['python', 'python3']
let g:syntastic_python_python_exec = 'python3'
" }
" NERD commenter {
map <F5> <leader>c<space>
" }
" Airline {
" Disable those two if you enable powerline
let g:airline_left_sep = ''
let g:airline_right_sep = ''
"let g:airline_powerline_fonts = 1
set laststatus=2
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#branch#enabled = 1
"let g:airline#extensions#branch#empty_message = ''
"let g:airline#extensions#whitespace#checks = [ 'indent' ]
" }
"Ctrl-P {
let g:ctrlp_working_path_mode = 'ra'
nnoremap <silent> <D-t> :CtrlP<CR>
nnoremap <silent> <D-r> :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\.git$\|\.hg$\|\.svn$',
      \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

" On Windows use "dir" as fallback command.
if has('win32') || has('win64')
  let g:ctrlp_user_command = {
        \ 'types': {
        \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
        \ 2: ['.hg', 'hg --cwd %s locate -I .'],
        \ },
        \ 'fallback': 'dir %s /-n /b /s /a-d'
        \ }
else
  let g:ctrlp_user_command = {
        \ 'types': {
        \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
        \ 2: ['.hg', 'hg --cwd %s locate -I .'],
        \ },
        \ 'fallback': 'find %s -type f'
        \ }
endif
" }
" Ag {
nmap º :Ag <c-r>=expand("<cword>")<cr><cr>
nnoremap <space>/ :Ag
" }
" textmanip {
xmap <C-j> <Plug>(textmanip-move-down)
xmap <C-k> <Plug>(textmanip-move-up)
xmap <C-h> <Plug>(textmanip-move-left)
xmap <C-l> <Plug>(textmanip-move-right)
" }
" }
" Local config file {
if filereadable(".vim-local.vim")
  source .vim-local.vim
endif
" }
