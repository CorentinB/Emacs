#!bin/bash

safe_mkdir () {
    if [ ! -d $1 ]; then
	mkdir -p $1
    fi
}

cd
safe_mkdir old_emacs
safe_mkdir new_emacs

cd new_emacs
git clone https://github.com/Kaserta/Emacs.git

cd
cp -r .emacs.d old_emacs
cp -r .emacs old_emacs

cp -r new_emacs/Emacs/.emacs.d ./.emacs.d
cp -r new_emacs/Emacs/.emacs ./.emacs
