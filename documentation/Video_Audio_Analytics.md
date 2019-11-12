# Video & Audio Analytics Training

A single Media Server instance is capable of running many analytics. Each must be enabled in the mediaserver.cfg and also permitted by your license key in order to be used. The relevant sections to look at in your mediaserver.cfg are:

## Modules
1. Modules. The Modules section list the engines that will be available to Media Server on startup: 

    ```ini
    [Modules]
    Enable=demographics,facedetect,facestate,facerecognize,...
    ```

## Channels
2. Channels: The Channels instruct Media Server to request license seats from License Server. Media Server has four license flavours: Audio, Surveillance, Visual e Video Management. To enable the face analytics required for this tutorial, you need to enable at least one channel of either Surveillance or Visual

    ```ini
    [Channels]
    VisualChannels=1
    ```
## Processes
3. Concurrent Processes: Media Server is directed to process a video, audio or image source with a process configuration file that defines how Media Server should ingest, analyze, output and otherwise manipulate the content and any resulting information. Media Server can run multiple processes concurrently if licensed to do so. The number of concurrent processes is limited by the parameter:

    ```ini
    [Process]
    MaximumThreads=2
    ```

# Process configuration

The format of a process configuration file is typically laid out in the following sections:
* Ingest
* Analysis
* Event Processing
* Transform
* Encoding
* Output

## 1. Ingest
1. Ingest: To configure the Ingest engine to accept video from your file, stream or webcam:

    ```ini
    [Session]
    Engine0=VideoIngest

    [VideoIngest]
    Type = Video
    //Format dshow
    Format = v4l2
    ```

## 2. Analysis
2. Analysis: To detect faces:

    ```ini
    [Session]
    Engine1 = FaceDetection

    [FaceDetection]
    Type = FaceDetect
    ```

## 3. Output
3. Output: To output results, we can to include the following:

    ```ini
    [Session]
    Engine2 = OutputTrackedFaces

    [OutputTrackedFaces]
    Type = xml
    Mode = singleRecord
    Input = FaceDetection.Result
    XMLOutputPath=./output/faces1/%segment.startTime.timestamp%.xml
    ```

- Display ongoing analytics in Activity user interface: Media Server's Activity user interface is a single-page web application intended for the display of running analytics on your Media Server. 
The app makes use of two Media Server calls to get the list of channels and then to get the latest record for the channel you select:

action=getStatus&showTracksStatistics
action=getLatestRecord

- Stop analysis: To stop processing, paste the following into test-action then click Test Action to see the response:
http://localhost:14000/a=queueInfo&queueAction=stop&queueName=process



- You can manually load the ENUK language pack with the action http://127.0.0.1:14000/action=LoadSpeechLanguageResource&LanguagePack=ENUK.
- If you skip this manual load, Media Server will automatically load the language (if installed) when processing begins but doing this will add latency to the processing. Now review the list of loaded language pack(s) with the action http://127.0.0.1:14000/action=ListSpeechLanguageResources.