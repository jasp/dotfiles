# For config custom for each machine
[ -f ~/.envconf ] && . ~/.envconf

alias profedit='$EDITOR ~/.bash_profile && source ~/.bash_profile'
alias l='ls'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias gitxc='gitx --commit'
if [ -d /opt/nginx ] ; then
  alias nginx='sudo /opt/nginx/sbin/nginx'
  alias stopnginx='sudo /opt/nginx/sbin/nginx -s stop'
fi

# Write current git branch in prompt
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
PS1="\u@\h: \W\$(parse_git_branch) $ "

## Make handy JRuby aliases
for f in $JRUBY_HOME/bin/*; do
  f=$(basename $f)
  case $f in jruby*|jirb*|*.bat|*.rb|_*) continue
  esac
  eval "alias j$f='jruby -S $f'"
done

export PATH="~/bin:$PATH"

# bash completion helpers
if [ -x `which brew` ] ; then
  [ -f `brew --prefix`/etc/bash_completion ] && . `brew --prefix`/etc/bash_completion
fi
[ -f ~/.git-bash-completion.sh ] && . ~/.git-bash-completion.sh

if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi
