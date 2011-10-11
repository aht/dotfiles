install:
	cp .bash_profile .bashrc .inputrc .gitconfig $(HOME)
	mkdir -p $(HOME)/bin && cp bin/* $(HOME)/bin/ && cp ext/* $(HOME)/bin/

ext/git-completion.bash:
	cd ext && curl -O https://raw.github.com/git/git/master/contrib/completion/git-completion.bash

ext/django_bash_completion:
	cd ext && curl -O http://code.djangoproject.com/svn/django/trunk/extras/django_bash_completion

completion: ext/git-completion.bash ext/django_bash_completion

ext: completion

clean:
	rm -f ext/*
