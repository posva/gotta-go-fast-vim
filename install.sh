#! /bin/bash

source ./task-logger.sh

fail() {
  ko
  bad "$@"
}

crash() {
  ko
  bad "$@"
  exit 1
}

dir="$HOME/gotta-go-fast-vim"

working -n "Checking directory"
clonned=$(cd "$(dirname "$0")" && pwd)
log_cmd check_dir test "$clonned" = "$dir" || crash "The files are located at ${clonned} but they should be at ${dir}"

vundle="$dir/vim/bundle/Vundle.vim"
if [[ ! -d "$vundle" ]]; then
  working -n "Cloning Vundle"
  log_cmd -c vundle git clone https://github.com/gmarik/Vundle.vim.git "$vundle"
fi

olddir="$dir/vim-backup"
files="vimrc vim"

_backup_dir() {
  mkdir -p $olddir || return 1
  for file in $files; do
    if [ -f ~/."$file" -o -d ~/."$file" ]; then
      mv -f ~/."$file" "$olddir" || return 1
    fi
  done
}
backup_dir() {
  local i tmp
  i=0
  tmp="$olddir"
  while [[ -d "$olddir" ]]; do
    ((i++))
    olddir="${tmp}-$i"
  done
  working -n "Backing up files to $olddir"
  log_cmd $0 _backup_dir || crash "Backup failed, aborting"
}

_symlinks() {
  for file in $files; do
    ln -s "${dir}/${file}" ~/."$file" || return 1
  done
}

symlink() {
  working -n "Symlinking vimrc and vim"
  log_cmd symlink _symlinks || fail "Symlink failed. Check logs at $LOG_DIR"
}

backup_dir
symlink

working -n "Installing vim plugins"
reset_timer 5
if vim -Nu "$dir/vim-plugins.vim" +PluginInstall! +qall; then
  echo -n "[$(get_timer 5) s]"
  ok
else
  echo -n "[$(get_timer 5) s]"
  ko
fi

if [[ ! -x $(which ag) ]]; then
  INSTALL="sudo apt-get install -y silversearcher-ag"
  if [[ "$(uname)" = "Darwin" ]]; then
    INSTALL="brew install the_silver_searcher"
  fi

  working -n "Installing ag"
  log_cmd ag "$INSTALL" || fail "ag install failed. Check logs at $LOG_DIR"
fi

finish
