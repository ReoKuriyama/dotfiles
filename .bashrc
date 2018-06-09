eval "$(rbenv init -)"

# added by Anaconda3 5.0.1 installer
export PATH="/anaconda3/bin:$PATH"

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

PATH=/usr/local/git/bin:$PATH
export PATH
