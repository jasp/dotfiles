# For config custom for each machine
[ -f ~/.envconf ] && . ~/.envconf

## Make handy JRuby aliases
if [ -n "$JRUBY_HOME" -a -d $JRUBY_HOME/bin ] ; then
  for f in $JRUBY_HOME/bin/*; do
    f=$(basename $f)
    case $f in jruby*|jirb*|*.bat|*.rb|_*) continue
    esac
    eval "alias j$f='jruby -S $f'"
  done
fi

if [ "$TERM" = "linux" ]; then
  _SEDCMD='s/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p'
  for i in $(sed -n "$_SEDCMD" $HOME/.Xdefaults | awk '$1 < 16 {printf "\\e"}')P%X%s", $1, $2"''; do
    echo -en "$i"
  done
  clear
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

# Google developer toools
if [ -d "$HOME/apps/depot_tools" ] ; then
    export PATH="$HOME/apps/depot_tools:$PATH"
fi

# The rest is only relevant for interactive shels
if [ ! -z "$PS1" ] ; then

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

function be {
  if [[ -a Gemfile ]]; then
    bundle exec $*
  else
    command $*
  fi
}

alias profedit='$EDITOR ~/.bash_profile && source ~/.bash_profile'
alias l='ls'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
if [ `which gitx 2> /dev/null` ]; then
  alias gitxc='gitx --commit'
fi
if [ `which gitg 2> /dev/null` ]; then
  alias gitgc='gitg --commit'
fi
if [ -d /opt/nginx ]; then
  alias nginx='sudo /opt/nginx/sbin/nginx'
  alias stopnginx='sudo /opt/nginx/sbin/nginx -s stop'
fi

# Alias definitions.
# For additional alias definitions put them in ~/.bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# bash completion helpers
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
if [ -f /etc/profile.d/bash-completion.sh ] && ! shopt -oq posix; then
    . /etc/profile.d/bash-completion.sh
fi
if [ `which brew 2> /dev/null` ] ; then
  [ -f `brew --prefix`/etc/bash_completion ] && . `brew --prefix`/etc/bash_completion
fi
[ -f ~/.git-bash-completion.sh ] && . ~/.git-bash-completion.sh
[ -f /usr/share/git/completion/git-completion.bash ] && . /usr/share/git/completion/git-completion.bash
[ -f /usr/share/git/completion/git-prompt.sh ] && . /usr/share/git/completion/git-prompt.sh

# Write current git branch in prompt
# Your branch is ahead of
if [ "$color_prompt" = yes ]; then
  PS1="\$? \$(if [[ \$? == 0 ]]; then echo '\[\033[0;32m\]:)'; else echo '\[\033[0;31m\]:('; fi) ${debian_chroot:+($debian_chroot)}\[\033[36m\]\u@\h\[\033[00m\]: \[\033[34m\]\W\[\033[00m\]\$(__git_ps1 '(\[\033[33m\]%s\[\033[00m\])') \$ "
else
    PS1="\$? \$(if [[ \$? == 0 ]]; then echo ':)'; else echo ':('; fi) ${debian_chroot:+($debian_chroot)}\u@\h: \W\$(__git_ps1 '(%s)') \$ "
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

export PATH=$PATH:/usr/local/mspgcc/bin

export PATH=$PATH:~/.local/bin
#[[ -f .local/lib/python3.3/site-packages/powerline/bindings/bash/powerline.sh ]] && source .local/lib/python3.3/site-packages/powerline/bindings/bash/powerline.sh

fi

# Improve ruby development performance
export RUBY_GC_MALLOC_LIMIT=90000000
export RUBY_FREE_MIN=200000

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
