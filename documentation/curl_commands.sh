#!/bin/bash
curl http://localhost:24000/a=getlicenseinfo
curl http://localhost:24000/a=licenseinfo
curl http://localhost:24000/a=help

curl http://localhost:14000/a=getstatus
curl http://localhost:14000/a=getlicenseinfo
curl http://localhost:14000/a=activity
curl http://localhost:14000/a=process&source=/dev/video0&configName=faceDetection
curl http://localhost:14000/a=process&source=/dev/video0&configName=faceDemoState
curl http://localhost:14000/a=process&source=/dev/video0&configName=faceAnalysis

curl http://localhost:14000/a=process&source=http://english.streaming.aljazeera.net/aljazeera/english2/index576.m3u8&configName=speechAnalysis

#sudo apt-get install v4l-utils
#v4l2-ctl --list-devices
curl http://localhost:14000/action=QueueInfo&QueueName=process&QueueAction=getstatus&Token=MTI3LjAuMS4xOjE0MDAwOlBST0NFU1M6MTU3MzUwOTQyOTMxNjAwNDg4OTQ1MTI0
curl http://localhost:14000/action=QueueInfo&QueueName=process&QueueAction=progress&Token=MTI3LjAuMS4xOjE0MDAwOlBST0NFU1M6MTU3MzUwOTQyOTMxNjAwNDg4OTQ1MTI0
curl http://localhost:14000/action=QueueInfo&QueueName=process&QueueAction=stop

ffmpeg -f video4linux2 -i /dev/video0 -c:v libx264 -an -f flv rtmp://localhost:1935/app/unique_stream_name