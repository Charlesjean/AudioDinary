//
//  ADAudioRecorder.h
//  AudioDinary
//
//  Created by Chen Duanjin on 9/8/13.
//  Copyright (c) 2013 iLife. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

#define BUFFER_SIZE 3

class ADAudioRecorder 
{
private:
    AudioStreamBasicDescription mAudioFormat;
    AudioQueueRef mQueue;
    AudioQueueBufferRef mBuffer[BUFFER_SIZE];
    AudioFileID  mFile;
    int mBufferSize;
    long mCurrentPacket;
    bool misRunning;
    const char* mFilePath;
    
    void init();
    void setupAudioFormat();
    void deriveBufferSize(float seconds,long *size);
    void writeMagicCookie();
public:
    ADAudioRecorder(NSString* filePath);
    ~ADAudioRecorder();
    void start();
    void pause();
    void stop();
private:
   static void audioInputCallback(void* aqData,
                                  AudioQueueRef audioQueue,
                                  AudioQueueBufferRef audioBUffer,
                                  const AudioTimeStamp *audioTime,
                                  UInt32 inNumPackets,
                                  const AudioStreamPacketDescription* packetDes);

};


