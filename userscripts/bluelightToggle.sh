#!/bin/bash

active=$(ps aux | grep hypr | grep sunset)
if [[ -z "$active" ]]; then
  hyprsunset -t 4500
else
  pkill hyprsunset
fi
