//
//  ADAudioRecorder.m
//  AudioDinary
//
//  Created by Chen Duanjin on 9/8/13.
//  Copyright (c) 2013 iLife. All rights reserved.
//

#import "ADAudioRecorder.h"


ADAudioRecorder::ADAudioRecorder(NSString* filePath)
{
    this->mFilePath = [filePath cStringUsingEncoding:NSASCIIStringEncoding];
    this->misRunning = false;
    this->mCurrentPacket = 0;
    this->init();
}

ADAudioRecorder::~ADAudioRecorder()
{
    AudioQueueDispose(mQueue, false);
    
}

void ADAudioRecorder::init()
{
    this->setupAudioFormat();//set audio format
    CFURLRef fileRef = CFURLCreateFromFileSystemRepresentation(NULL, (const UInt8*)mFilePath, strlen(mFilePath), false);
    
    AudioFileCreateWithURL(fileRef, kAudioFileAIFFType, &this->mAudioFormat, kAudioFileFlags_EraseFile, &this->mFile);//create audio file id
    CFRelease(fileRef);
    
    AudioQueueNewInput(&mAudioFormat, audioInputCallback, this, NULL, NULL, 0, &mQueue);
    
    UInt32 size = sizeof(mAudioFormat);
    AudioQueueGetProperty(mQueue, kAudioQueueProperty_StreamDescription, &mAudioFormat, &size);
    
    this->writeMagicCookie();
    
    long bufferSize;
    this->deriveBufferSize(.5, &bufferSize);
    for (int i = 0; i < BUFFER_SIZE; ++i) {
        AudioQueueAllocateBuffer(mQueue, bufferSize, &mBuffer[i]);
        AudioQueueEnqueueBuffer(mQueue, mBuffer[i], 0, NULL);
    }

}

void ADAudioRecorder::setupAudioFormat()
{
    mAudioFormat.mFormatID = kAudioFormatLinearPCM;
    mAudioFormat.mFramesPerPacket = 1;
    mAudioFormat.mChannelsPerFrame = 2;
    mAudioFormat.mSampleRate = 44100.0;
    mAudioFormat.mBitsPerChannel = 16;
    mAudioFormat.mBytesPerFrame = mAudioFormat.mBytesPerPacket = mAudioFormat.mChannelsPerFrame * (mAudioFormat.mBitsPerChannel / 8);
    mAudioFormat.mFormatFlags = kLinearPCMFormatFlagIsBigEndian | kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked;
    
}
void ADAudioRecorder::deriveBufferSize(float seconds,long *size)
{
    int frames = ceil(seconds * mAudioFormat.mSampleRate);
    *size = frames * this->mAudioFormat.mBytesPerFrame;   
    
}

void ADAudioRecorder::audioInputCallback(void *aqData,
                                         AudioQueueRef audioQueue,
                                         AudioQueueBufferRef audioBUffer,
                                         const AudioTimeStamp *audioTime,
                                         UInt32 inNumPackets,
                                         const AudioStreamPacketDescription* packetDes)
{
    ADAudioRecorder* recorder = (ADAudioRecorder*) aqData;
    if (inNumPackets > 0) {
        
        AudioFileWritePackets(recorder->mFile, false, audioBUffer->mAudioDataByteSize, packetDes, recorder->mCurrentPacket, &inNumPackets, audioBUffer->mAudioData);
        recorder->mCurrentPacket += inNumPackets;
        
        if (recorder->misRunning) {
            AudioQueueEnqueueBuffer(recorder->mQueue, audioBUffer, 0, NULL);
        }
    }
    
}

void ADAudioRecorder::writeMagicCookie()
{
    UInt32 cookieSize;
    AudioQueueGetPropertySize(mQueue, kAudioQueueProperty_MagicCookie, &cookieSize);
    if (cookieSize > 0) {
        char* magicCookie = (char*)malloc(cookieSize);
        AudioQueueGetProperty(mQueue, kAudioQueueProperty_MagicCookie, magicCookie, &cookieSize);
        AudioFileSetProperty(mFile, kAudioFilePropertyMagicCookieData, cookieSize, magicCookie);
    }
}

void ADAudioRecorder::start()
{
    misRunning = true;
    AudioQueueStart(mQueue, NULL);
}

void ADAudioRecorder::pause()
{
    
}

void ADAudioRecorder::stop()
{
    misRunning = false;
    AudioQueueStop(mQueue, false);
}
