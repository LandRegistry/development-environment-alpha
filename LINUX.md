# Linux support

Slightly geared toward Ubuntu 12.04 + zsh + the latest enablement stack.

# Commands

The following sequence of commands (with comments) can be run on an Ubuntu machine as described before to get the dev env scripts to work.


		## git
		# for https support
		sudo apt-get install libcurl4-openssl-dev
		git clone https://github.com/git/git.git /path/to/git
		# remove system git
		apt-get remove git
		cd /path/to/git
		./configure
		make
		sudo make install
		exec $SHELL

		## pyenv

		# go home
		cd
		git clone git://github.com/yyuu/pyenv.git .pyenv
		echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshenv
		echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshenv
		echo 'eval "$(pyenv init -)"' >> ~/.zshenv
		exec $SHELL

		## pyenv virtualenvwrapper
		git clone https://github.com/yyuu/pyenv-virtualenvwrapper.git ~/.pyenv/plugins/pyenv-virtualenvwrapper
		# initialise
		pyenv virtualenvwrapper
		# always use pyvenv instead of usual virtualenvwrapper
		echo 'export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"' >> ~/.zshenv
		exec $SHELL

		# mkvirtualenv should now use pyvenv (the pyenv virtualenvwrapper)
		cd myproject
		mkvirtualenv myproject


		## or when using the development environment
		git clone git@github.com:LandRegistry/development-environment.git
		cd development-environment
		pyenv virtualenvwrapper
		# etc etc the dev env scripts
