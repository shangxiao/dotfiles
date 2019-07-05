set -o vi
alias ls="ls -FG"
alias l="ls -FG"
alias ll='ls -l'
alias la='ls -aFG'
alias serve='python -m SimpleHTTPServer'
alias activate=". env/bin/activate"
alias pom="git pom"
alias install="npm install --save-dev"
alias link-site-packages="find .direnv -type d -name site-packages -exec ln -s \{\} ./site-packages \;"

function watch() {
    fswatch --exclude .pytest_cache . | xargs -n1 -I \{\} sh -c "clear ;  $* ;"
}

export PYTHONDONTWRITEBYTECODE=1
export HISTCONTROL=ignoredups
export GREP_OPTIONS='--exclude=tags -p'  # not sure why need to specify -p as it's supposed to be the default?

if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
. `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi

if [ -f `brew --prefix`/etc/bash_completion.d/git-prompt.sh ]; then
    . `brew --prefix`/etc/bash_completion.d/git-prompt.sh
fi

PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[0;35m\]$(__git_ps1 "(%s)")\[\e[m\]\[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
