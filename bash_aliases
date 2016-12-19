
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'

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

lipsum() {
  lynx -source http://www.lipsum.com/feed/xml?amount=3|perl -p -e 's/\n/\n\n/g'|sed -n '/<lipsum>/,/<\/lipsum>/p'|sed -e 's/<[^>]*>//g'
}
alias lipsum=lipsum


alias spd-say-alfred="spd-say -t male2 -r -10 -p -25 $@"
alias spd-say-ada="spd-say -t female2 -r -10 -p -25 $@"

saye() {
  cmd=$@
  processname=$(echo "$cmd" | head -n1 | awk '{print $1}')
  $cmd && spd-say-alfred "brooks, the $processname process has finished" || spd-say-alfred "brooks, the $processname process has failed"
}
alias saye=saye

refreshLatLng() {
  latlng_file="$HOME/.latlng"
  data=$(curl -s --get http://freegeoip.net/json/)
  lat=$(echo "$data" | grep -Po '(?<="latitude":)[^,}]*')
  lng=$(echo "$data" | grep -Po '(?<="longitude":)[^,}]*')

  if [ -f "$latlng_file" ]; then rm "$latlng_file"; fi
  touch $latlng_file
  echo "export LATITUDE=$lat" >> $latlng_file
  echo "export LONGITUDE=$lng" >> $latlng_file
}
refreshLatLng=refreshLatLng
refreshLatLng

weather() {
  lat=$(curl -s --get http://freegeoip.net/json/ | grep -Po '(?<="latitude":)[^,}]*')
  lng=$(curl -s --get http://freegeoip.net/json/ | grep -Po '(?<="longitude":)[^,}]*')
  weather_url="http://forecast.weather.gov/MapClick.php?lat=$lat&lon=$lng&FcstType=json"
  weather_data=$(curl -s "$weather_url")

  place=$(text2jsonlookup.py "['currentobservation']['name']" "$weather_data")
  forecast_0_label=$(text2jsonlookup.py "['time']['startPeriodName'][0]" "$weather_data")
  forecast_0=$(text2jsonlookup.py "['data']['text'][0]" "$weather_data")
  forecast_1_label=$(text2jsonlookup.py "['time']['startPeriodName'][1]" "$weather_data")
  forecast_1=$(text2jsonlookup.py "['data']['text'][1]" "$weather_data")
  forecast_2_label=$(text2jsonlookup.py "['time']['startPeriodName'][2]" "$weather_data")
  forecast_2=$(text2jsonlookup.py "['data']['text'][2]" "$weather_data")

  spd-say-alfred -w "forecast for $place"
  spd-say-alfred -w "$forecast_1_label, $forecast_1"
  spd-say-alfred -w "$forecast_2_label, $forecast_2"
}
alias weather=weather

sayfor() {
  fortune > /tmp/fortune && cat /tmp/fortune && spd-say-ada "$(cat /tmp/fortune)" && rm /tmp/fortune
}
alias sayfor=sayfor
