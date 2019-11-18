#!/bin/bash
echo "Converting JPEG files from folder $1 to clipname $2"
if [ -z $1]; then
    echo "Parameters required: folder $1 | clipname $2"
else
    #ffmpeg -f concat -safe 0  -i "$1" -codec copy "$1_join.mp4"
    ffmpeg -framerate 1/5 -pattern_type glob -i "$1/*.jpg" -c:v libx264 -r 30 -pix_fmt yuv420p -y "$1/$2.mp4"
fi        