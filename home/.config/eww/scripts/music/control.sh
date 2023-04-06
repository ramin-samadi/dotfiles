#!/bin/bash

if [[ $1 == "prev" ]]; then
	playerctl previous
fi

notify-send $1

if [[ $1 == "play-pause" ]]; then
	playerctl play-pause
fi

if [[ $1 == "next" ]]; then
	playerctl next
fi
