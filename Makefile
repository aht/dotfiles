install:
	cp .bash_profile .bashrc .inputrc .gitconfig $(HOME)
	mkdir -p $(HOME)/bin && cp bin/* $(HOME)/bin/

bin/git-completion.bash:
	cd bin && curl -O https://raw.github.com/git/git/master/contrib/completion/git-completion.bash

bin/django_bash_completion:
	cd bin && curl -O http://code.djangoproject.com/svn/django/trunk/extras/django_bash_completion

completion: bin/git-completion.bash bin/django_bash_completion

clean:
	rm -f bin/git-completion.bash bin/django_bash_completion
