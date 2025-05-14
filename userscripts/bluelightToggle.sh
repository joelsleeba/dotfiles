#!/bin/bash

active=$(ps aux | grep gamma | grep step)
if [[ -z "$active" ]]; then
	gammastep
else
	pkill gammastep
fi
