//
//  MLAudioBase.h
//  MinPairs
//
//  Created by Brandon on 2014-04-24.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  A protocol for which all audio player classes must conform to.
 *  Contains the minimum function declarations for an audio player.
 */
@protocol MLAudioBase <NSObject>

/** 
 *  Plays the audio file set by @see setAudioFile.
 */
-(void) play;


/** 
 *  Stops playing audio.
 */
-(void) stop;


/** 
 *  Pauses the current audio player. 
 */
-(void) pause;


/** 
 *  Sets the volume level of the audio player.
 *  @param volumeLevel An integer ranging from 0 to 100. Determines how loud the sound will be.
 */
-(void) setVolume: (NSUInteger) volumeLevel;


/**
 *  Loads a sound file from the application resources.
 *  \param fileName Name of the file to be loaded.
 *  \param extension File extension of the file to be loaded.
 *  \return True if the file is found in the resources. False otherwise.
 */
-(bool) loadFileFromResource:(NSString*)fileName withExtension:(NSString*)extension;

@end
