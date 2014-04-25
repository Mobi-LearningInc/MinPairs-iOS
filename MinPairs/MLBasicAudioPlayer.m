//
//  MLBasicAudioPlayer.m
//  MinPairs
//
//  Created by Brandon on 2014-04-24.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLBasicAudioPlayer.h"

@interface MLBasicAudioPlayer () <AVAudioPlayerDelegate>
@property (nonatomic, assign) bool paused;
@property (nonatomic, assign) bool wasInterupted;
@property (nonatomic, strong) AVAudioPlayer* player;
@end

@implementation MLBasicAudioPlayer
@synthesize delegate = _delegate;

-(id<MLAudioBase>) init
{
    self = [super init];
    if (self)
    {
        self.wasInterupted = false;
    }
    
    return self;
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer*)player successfully:(BOOL)flag
{
    [self.delegate onMLBasicAudioPlayerFinishPlaying: self];
}

-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer*)player error:(NSError*)error
{
}

-(void)audioPlayerBeginInterruption:(AVAudioPlayer*)player
{
    if ([player isPlaying])
    {
        self.wasInterupted = true;
        [player pause];
    }
}

-(void)audioPlayerEndInterruption:(AVAudioPlayer*)player withOptions:(NSUInteger)flags
{
    if (flags == AVAudioSessionInterruptionOptionShouldResume)
    {
        if ([self wasInterupted])
        {
            [player play];
        }
    }
}

-(bool) isPlaying
{
    return [[self player] isPlaying];
}

-(bool) isPaused
{
    return [self paused];
}

-(void) play
{
    self.paused = false;
    [[self player] play];
}

-(void) stop
{
    [[self player] stop];
}

-(void) pause
{
    [[self player] pause];
    self.paused = true;
}

-(void) setVolume: (NSUInteger) volumeLevel
{
    [[self player] setVolume: volumeLevel * 0.01f];
}

-(bool) prepareToPlay
{
    return [[self player] prepareToPlay];
}

-(bool) loadFile:(NSString*)filePath
{
    NSURL* fileURL = [NSURL fileURLWithPath:filePath];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL error: nil];
    [[self player] setDelegate: self];
    return [[NSFileManager defaultManager] fileExistsAtPath: filePath] && [self player];
}

-(bool) loadFileFromResource:(NSString*)fileName withExtension:(NSString*)extension
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource: fileName ofType: extension];
    return [self loadFile: filePath];
}
@end
