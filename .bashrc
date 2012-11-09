export PATH=~/bin:~/dotfiles/bin:~/dotfiles/ext:$PATH

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
        
        (9 fortune || fortune) 2>/dev/null
        ;;
esac

shopt -s histappend
shopt -s checkwinsize
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTIGNORE="[ ]*:ls:exit:logout"
export HISTSIZE=10000
export HISTFILESIZE=1000000

export PYTHONSTARTUP=~/.pythonrc.py
export VIRTUAL_ENV_DISABLE_PROMPT=true
export PIP_RESPECT_VIRTUALENV=true

# cycle through completion
# bind '"\t":menu-complete'

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
        history
    else
        history $HISTSIZE | grep -E  "$@" | grep -vE "^ *[0-9]+ +h $@" 
    fi \
    | sed -E 's/^[0-9]+  //g' \
    | sort -u \
    | tail -n 20
}

rgrep () {
    grep -n "$1" $(find . -name "$2")
}

ext () {
	echo ${1##*.}
}

filename () {
	echo ${1%.*}
}

bashrc() {
	if [[ $1 != '-r' ]]; then
		$EDITOR ~/.bashrc_local
	fi
	if test -e ~/.bashrc_local; then
		source ~/.bashrc_local
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

for f in ${includes_local[*]}; do
	if test -e "$f"; then
		if [ "$TERM" != "dumb" ]; then echo ".bashrc: including $f"; fi
		source "$f"
	fi
done
