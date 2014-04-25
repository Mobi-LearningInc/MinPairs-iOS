//
//  MLAudioPlayerQueue.m
//  MinPairs
//
//  Created by Brandon on 2014-04-24.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLAudioPlayerQueue.h"

@interface MLAudioPlayerQueue() <MLBasicAudioPlayerDelegate>
@property (nonatomic, weak) NSNumber* currentID;
@property (nonatomic, assign) bool replayAudioSet;
@property (nonatomic, strong) NSMutableDictionary* players;
@property (nonatomic, strong) NSMutableArray* queue;
@property (nonatomic, strong) NSMutableArray* IDs;
@end

@implementation MLAudioPlayerQueue

-(MLAudioPlayerQueue*) initWithCapacity:(NSUInteger)capacity
{
    self = [super init];
    if (self)
    {
        _currentID = 0;
        _replayAudioSet = false;
        
        if (!_players)
        {
            _players = [[NSMutableDictionary alloc] initWithCapacity: capacity];
            _queue = [[NSMutableArray alloc] initWithCapacity: capacity];
            _IDs = [[NSMutableArray alloc] initWithCapacity: capacity];
        }
    }
    return self;
}

-(void) onMLBasicAudioPlayerFinishPlaying:(MLBasicAudioPlayer*)sender
{
    if (![self replayAudioSet])
    {
        @synchronized([self queue])
        {
            if ([[self queue] count])
            {
                [[self queue] removeObjectAtIndex: 0];
                [[self IDs] removeObjectAtIndex: 0];
            }
        }
        
        if ([[self queue] count])
        {
            self.currentID = [[self IDs] objectAtIndex: 0];
            MLBasicAudioPlayer* player = [[self queue] objectAtIndex: 0];
            [player play];
        }
    }
    else
    {
        [sender play];
        self.replayAudioSet = false;
    }
}

-(void) replay
{
    self.replayAudioSet = true;
    if (![[self queue] count])
    {
        [self play: [[self currentID] unsignedIntegerValue]];
    }
}

-(void) play:(NSUInteger)fileID
{
    @synchronized([self queue])
    {
        NSNumber* ID = [NSNumber numberWithUnsignedInteger: fileID];
        
        if ([[self IDs] indexOfObject: ID] != NSNotFound)
        {
            return;
        }
        
        MLBasicAudioPlayer* player = [[self players] objectForKey: ID];
        [[self queue] addObject: player];
        [[self IDs] addObject: ID];
        
        if ([[self queue] count] && ![[[self queue] objectAtIndex: 0] isPlaying] && ![[[self queue] objectAtIndex: 0] isPaused])
        {
            self.currentID = [[self IDs] objectAtIndex: 0];
            MLBasicAudioPlayer* player = [[self queue] objectAtIndex: 0];
            [player prepareToPlay];
            [player play];
        }
    }
}

-(void) prepareToPlay: (NSUInteger)fileID
{
    [[[self players] objectForKey: [NSNumber numberWithUnsignedInteger: fileID]] prepareToPlay];
}

-(void) addFile:(NSUInteger)fileID withFileName:(NSString*)fileName withExtension:(NSString*)extension
{
    for (NSNumber* number in [self players])
    {
        if ([number unsignedIntegerValue] == fileID)
        {
            return;
        }
    }
    
    MLBasicAudioPlayer* player = [[MLBasicAudioPlayer alloc] init];
    player.delegate = self;
    [player loadFileFromResource: fileName withExtension: extension];
    
    [[self players] setObject: player forKey: [NSNumber numberWithUnsignedInteger: fileID]];
}
@end
