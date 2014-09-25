#Bold-white prompt
PS1='\[\e[1;97m\][\u@\h \W]\$\[\e[0m\] '

alias lhost='cd /media/paullik/localhost'
alias aurget='aurget --noedit --deps'
alias cal='cal -m'

alias tmux='tmux -2'
#Colored output
#ls
alias ls='ls -h --color=auto'
eval $(dircolors -b)

#grep color
export GREP_COLOR="1;33"
alias grep='grep --color=auto'

#Fool proof
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'

alias tatt='tmux attach-session -t irc || tmux new -d -n weechat -s irc weechat-curses'
alias ktouch='setxkbmap us && ktouch && setxkbmap ro'

#Colored man output
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
}
