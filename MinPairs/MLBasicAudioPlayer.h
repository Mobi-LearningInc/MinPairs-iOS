//
//  MLBasicAudioPlayer.h
//  MinPairs
//
//  Created by Brandon on 2014-04-24.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVAudioSession.h>
#import <AVFoundation/AVAudioPlayer.h>
#import "MLAudioBase.h"
#import "MLBasicAudioPlayerDelegate.h"

/**
 *  A basic audio player using the AVAudioPlayer internally.
 *  Conforms to MLAudioBase Protocol
 */
@interface MLBasicAudioPlayer : NSObject<MLAudioBase>

/**
 *  Calls implemented delegate methods when an event occurs.
 */
@property (nonatomic, weak) id <MLBasicAudioPlayerDelegate> delegate;

/**
 *  Determines if the current player's state is playing.
 *  @return True if audio is playing. False otherwise.
 */
-(bool) isPlaying;

/**
 *  Determines if the current player's state is paused.
 *  @return True if audio is playing. False otherwise.
 */
-(bool) isPaused;


/**
 *  Prepares the audio player for playback by preloading its buffers.
 *  Calling this method preloads buffers and acquires the audio hardware needed 
 *  for playback, which minimizes the lag between calling the play method and the start of sound output.
 *  Calling the stop method, or allowing a sound to finish playing, undoes this setup.
 *  @return True if successful. False otherwise.
 */
-(bool) prepareToPlay;

/**
 *  Loads an audio file from a given path.
 *  @param filePath The path of the fil to be loaded. Paths must include the file extension.
 *  @return True if the file is loaded. False otherwise.
 */
-(bool) loadFile:(NSString*)filePath;

/**
 *  Initialises the class's internal data.
 *  @return Returns the a pointer to the initialised instance.
 */
-(id<MLAudioBase>) init;
@end
