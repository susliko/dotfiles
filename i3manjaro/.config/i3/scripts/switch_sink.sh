#!/usr/bin/env bash

all_sinks=$(pactl list short sinks | cut -f 2)
all_short_sinks=$(pactl list short sinks | cut -f 2 |  sed 's/.analog-stereo//' | sed 's/alsa_output.//')
echo "$all_short_sinks"

default_sink=$(pactl info | grep 'Default Sink' | cut -d : -f 2)

active_sink=$(echo "$all_sinks" | grep -n $default_sink | cut -d : -f 1)

selected_short_sink=$(echo "$all_short_sinks" | rofi -dmenu -i -a $(($active_sink - 1)) -p 'Select a device: ')

short_sink=$(echo "$all_sinks" | grep "$selected_short_sink")

pactl set-default-sink $short_sink
