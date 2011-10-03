bin/git-completion.bash:
	curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash > bin/git-completion.bash

bin/django_bash_completion:
	curl -O http://code.djangoproject.com/svn/django/trunk/extras/django_bash_completion > bin/django_bash_completion

all: bin/git-completion.bash bin/django_bash_completion

install: all
	cp .bashrc .inputrc .gitconfig $(HOME)
	mkdir -p $(HOME)/bin && cp bin/* $(HOME)/bin/
