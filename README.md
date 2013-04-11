dotfiles
========

My dotfiles for unix based systems

Installation
============

To setup git run:

    sh gitsetup

To setup vim you can do:

    ln -s `pwd`/vim ~/.vim
    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc

For the other stuff simply do:

    ln -s `pwd`/bash_profile ~/.bash_profile
    ln -s `pwd`/screenrc ~/.screenrc
    ln -s `pwd`/tmux.conf ~/.tmux.conf
    ln -s `pwd`/ackrc ~/.ackrc

Finally to use the bash_profile you should have a file with environment setup data, copy the example and edit to taste:

    cp envconf.example ~/.envconf
    vim ~/.envconf
