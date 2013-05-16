#
# ~/.zprofile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

PATH=$PATH:/home/paullik/Documents
PATH=$PATH:/home/paullik/.gem/ruby/1.9.1/bin
PATH=$PATH:/home/paullik/QtSDK/QtCreator/bin
PATH="/usr/lib/colorgcc/bin:$PATH"
export PATH

export EDITOR="/usr/bin/vim"

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx &> ~/.xlog

