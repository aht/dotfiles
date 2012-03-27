all: ext/git-completion.bash ext/virtualenv.py

install:
	if [ ! -f $(HOME)/.bash_profile ]; then cp -v .bash_profile $(HOME)/; fi
	cp -iv  .bashrc .inputrc .gitconfig .pythonrc.py $(HOME)/; exit 0
	if [ "$(shell ls ext)" ]; then cp -v ext/* $(HOME)/bin/; fi

ext/git-completion.bash:
	cd ext && curl -O https://raw.github.com/git/git/master/contrib/completion/git-completion.bash

ext/django_bash_completion:
	cd ext && curl -O http://code.djangoproject.com/svn/django/trunk/extras/django_bash_completion

ext/virtualenv.py:
	cd ext && curl -O https://raw.github.com/pypa/virtualenv/master/virtualenv.py

ext: ext/git-completion.bash ext/django_bash_completion ext/virtualenv.py

clean:
	rm -f ext/*
