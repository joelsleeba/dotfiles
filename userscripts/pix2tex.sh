#!/bin/bash

grim -g "$(slurp)" "/tmp/pix2tex.jpg"
pix2tex '/tmp/pix2tex.jpg' | cut -d " " -f2- | sed 's/.$//' | wl-copy
