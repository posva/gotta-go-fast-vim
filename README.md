Gotta go fast - Vim
===

Starter `vimrc` featuring minimal plugin and fast installation.

## Install
Before installing you need a recent Vim and if you're on OS X you'll need
[`brew`](http://brew.sh/)

To install simply execute the install script `./install.sh`

## Plugins

- Vundle for managin plugins
- vim-surround for surrounding characters such as `'`, `"`, `)`, ...
- vim-repeat for using `.` with vim-surround
- tabular for easy alignement
- gitgutter for git add/removes tracking
- syntastic for syntax checking
- nerdtree for easy directory navigation
- nerdcommenter for easy comment toggle with F5
- ctrlp for opening files faster
- multiple-cursors
- easymotions for faster movement
- ag for recursive search
- tetmanip for moving text around
- airline for file information

## Mappings

You can look for mapping inside the `vimrc` file for a complete list

- Leader is set to `,`
- F2 to toggle Paste Mode
- F5 to toggle comments
- `<space>` + `/` to recursively search
- `<C-j>` and `<C-k>` to move lines around
