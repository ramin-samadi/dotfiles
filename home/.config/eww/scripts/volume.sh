#!/usr/bin/env bash

pamixer --set-volume "$2"
echo $(pamixer --get-volume)
