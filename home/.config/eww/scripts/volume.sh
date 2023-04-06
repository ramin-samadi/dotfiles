#!/usr/bin/env bash

VOLUME_STATE=$(pamixer --get-volume)

echo "${VOLUME_STATE}"

if [[ $1 == "set" ]]; then
  increase_volume="XF86AudioRaiseVolume"
  decrease_volume="XF86AudioLowerVolume"

  if ! pamixer --increase $increase_volume; then
    echo "Error increasing volume"
  fi

  if ! pamixer --decrease $decrease_volume; then
    echo "Error decreasing volume"
  fi

  if ! xdotool key $increase_volume; then
    echo "Error simulating key press for increasing volume"
  fi

  if ! xdotool key $decrease_volume; then
    echo "Error simulating key press for decreasing volume"
  fi
fi
