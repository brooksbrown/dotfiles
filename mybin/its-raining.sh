#!/bin/bash

source "$HOME/.latlng"
weather_url="http://forecast.weather.gov/MapClick.php?lat=$LATITUDE&lon=$LONGITUDE&FcstType=json"
weather_data=$(curl -s "$weather_url")
humdity=$($HOME/.mybin/text2jsonlookup.py "['currentobservation']['Relh']" "$weather_data")
if [ "$humdity" == "'100'" ]; then
  if [ ! -f "$HOME/.rainflag" ]; then
    espeak "brooks, it's raining"
    touch $HOME/.rainflag
  fi
else
  if [ -f "$HOME/.rainflag" ]; then
    espeak "brooks, it's stopped raining"
    rm $HOME/.rainflag
  fi
fi
