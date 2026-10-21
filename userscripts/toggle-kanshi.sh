#!/bin/sh
if [[ -e $(kanshictl status | grep lab) ]]; then
  kanshictl switch lab
else
  kanshictl switch home
fi
