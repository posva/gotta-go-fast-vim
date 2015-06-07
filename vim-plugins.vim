" required options for Vundle
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle must manage Vundle
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-repeat'

Plugin 'altercation/vim-colors-solarized'

" Align text with tabular
Plugin 'godlygeek/tabular'

" Syntastic plugin for compilation errors
Plugin 'scrooloose/syntastic'

" git
Plugin 'airblade/vim-gitgutter'

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'

Plugin 'kien/ctrlp.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'rking/ag.vim'
Plugin 't9md/vim-textmanip'

" Airline iformation about the file at bottom
Plugin 'bling/vim-airline'

" All plugins added!
call vundle#end()
filetype plugin indent on
" To ignore plugin indent changes, instead use:
"filetype plugin on
