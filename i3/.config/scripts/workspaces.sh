#! /bin/bash
killall -9 i3-autodisplay; i3-autodisplay --config ${1} & feh --bg-fill ~/Pictures/wallpapers/rdr1.png
