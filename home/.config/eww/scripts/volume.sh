#!/bin/bash

pamixer --set-volume "$2"
echo $(pamixer --get-volume)
