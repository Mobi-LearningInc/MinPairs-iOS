//
//  MLViewController.m
//  MinPairs
//
//  Created by ituser on 4/23/2014.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLViewController.h"
#import "MLAudioPlayerQueue.h"

@interface MLViewController ()
@property (nonatomic, strong) MLAudioPlayerQueue* queue;
@end

@implementation MLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if (!_queue)
    {
        _queue = [[MLAudioPlayerQueue alloc] initWithCapacity: 2];
        [_queue addFile: 1 withFileName: @"Bank1" withExtension: @"mp3"];
        [_queue addFile: 2 withFileName: @"Broom1" withExtension: @"mp3"];
        
        [_queue prepareToPlay: 1];
        [_queue prepareToPlay: 2];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSoundTestOne:(UIButton *)sender
{
    [[self queue] play: 1];
}

- (IBAction)onSoundTestTwo:(UIButton *)sender
{
    [[self queue] play: 2];
}

- (IBAction)onRadioOne:(UIButton *)sender
{
    NSLog(@"%@", [sender currentTitle]);
}

- (IBAction)onRadioTwo:(UIButton *)sender
{
    NSLog(@"%@", [sender currentTitle]);
}

- (IBAction)onRadioThree:(UIButton *)sender
{
    NSLog(@"%@", [sender currentTitle]);
}


@end
