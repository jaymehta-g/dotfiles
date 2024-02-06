#!/bin/bash

# passed by the nemo action
directory=$1

pimg g $directory/$(date +"%Y-%m-%d_%H:%M").png
