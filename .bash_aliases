#!/bin/bash
# alias.sh

shopt -s expand_aliases

alias intellij=sudo\ /usr/local/bin/idea-IC-171.4424.56/bin/idea.sh
alias mysql=mysql\ \-\-user\=root\ \-\-password\=i0tam3ager
alias xclip='xclip -sel clip'

git config --global alias.a add
git config --global alias.c commit -m
git config --global alias.s status
git config --global alias.p push
git config --global alias.co checkout
git config --global alias.l log
