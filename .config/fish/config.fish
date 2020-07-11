set -gx PATH /home/paul/.cargo/bin /home/paul/Downloads/sublime_text_3/ $PATH

# OPAM configuration
#source /home/paul/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true

if test $DISPLAY
    xhost +local: > /dev/null
end
set -x WORKON_HOME /home/paul/.virtualenvs
bash /usr/local/bin/virtualenvwrapper.sh
