export PATH=$PATH:~/dotfiles/bin:~/bin

case $TERM in
    9term)
        export PS1='\u ---> (\h) \w\nexpr $?; '
        
        alias ls='ls -1F'
        
        # no column width wrapping or truncation for ps command etc.
        stty cols 32067
        
        # but we still want man pages nicely formatted
        export MANWIDTH=80
        
        # cut the bs
        export PAGER=nobs
        
        ;;
    xterm*)
        export PS1='\[\033[1;32m\]\u\[\033[0m\] ---> (\h) \[\033[1;32m\]\w\[\033[1;34m\]\nexpr $?;\[\033[0m\] '
        
        alias ls='ls -F'
        
        9 fortune 2>/dev/null || fortune
        ;;
esac

shopt -s histappend
shopt -s checkwinsize
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTIGNORE="[ ]*:ls:ps:exit"
export HISTFILESIZE=1000000
export VIRTUAL_ENV_DISABLE_PROMPT=true

# cycle through completion
bind '"\t":menu-complete'

alias ..='cd ..'
alias ...='cd ../..'
alias +=pushd
alias r='pushd +1'
alias -- -='popd >/dev/null || cd -'

alias ds='dirs -v'
alias sudoe='sudo env PATH=$PATH'

function h() {
    if [ -z "$@" ]
    then
        history 20
    else
        history | grep "$@" | grep -vE "^ *[0-9]+ +h $@" | tail -n 20
    fi
}

rgrep () {
    grep -n "$1" $(find . -name "$2")
}

pg () {
    ps -fp $(pgrep $@) 2>/dev/null
}

ext () {
	echo ${1##*.}
}

filename () {
	echo ${1%.*}
}

bashrc() {
	if [[ $1 != '-r' ]]; then
		$EDITOR ~/.bashrc_extras
	fi
	if test -e ~/.bashrc_extras; then
		source ~/.bashrc_extras
	fi
}

venv () {
    echo $VIRTUAL_ENV
}

includes=(
	~/.bashrc_local
	~/bin/git-completion.bash
	~/bin/django_bash_completion
)

for f in ${includes[*]}; do
	if test -e "$f"; then
		if [ "$TERM" != "dumb" ]; then echo ".bashrc: including $f"; fi
		source "$f"
	fi
done
