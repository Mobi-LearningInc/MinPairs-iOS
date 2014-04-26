//
//  MLAllvsAllControllerViewController.m
//  MinPairs
//
//  Created by Brandon on 2014-04-26.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLAllvsAllControllerViewController.h"

@interface MLAllvsAllControllerViewController () <MLDataProviderEventListener>
@property (nonatomic, strong) id<MLAudioBase> player;
@property (nonatomic, strong) NSArray* categories;
@end

@implementation MLAllvsAllControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)onLoadStart
{
    
}

-(void)onLoadFinish
{

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MLMainDataProvider* provider = [[MLMainDataProvider alloc] initMainProvider];
    
    _categories = [provider getCategoriesCallListener: self];
    
    MLCategory* category = [[self categories] objectAtIndex: arc4random_uniform([[self categories] count])];
    
    
    
    _player = [[MLBasicAudioPlayer alloc] init];
    
    [[self player] loadFileFromResource: @"" withExtension: @"mp3"];
    
    [[self player] prepareToPlay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPlayClicked:(UIButton *)sender
{
    if (![[self player] isPlaying])
    {
        [[self player] play];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
