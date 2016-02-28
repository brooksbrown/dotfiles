
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'

alias tmux='tmux -2'

alias vagrant-ups='vagrant up && vagrant rsync-auto'

lipsum() {
  lynx -source http://www.lipsum.com/feed/xml?amount=3|perl -p -e 's/\n/\n\n/g'|sed -n '/<lipsum>/,/<\/lipsum>/p'|sed -e 's/<[^>]*>//g'
}
alias lipsum=lipsum

phplu() {
  python3 ~/Work/personal/scripts/phplu/phplu.py $1 $2 $3
}
alias phplu=phplu $1 $2 $3

DEFAULT_BROWSER='lynx'
google() {
  $DEFAULT_BROWSER http://google.com/#q="$1"
}
alias google=google
