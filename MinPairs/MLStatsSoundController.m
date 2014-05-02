//
//  MLStatsSoundController.m
//  MinPairs
//
//  Created by Brandon on 2014-05-02.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLStatsSoundController.h"
#import "MLBasicAudioPlayer.h"
#import "MLMainDataProvider.h"
#import "MLStatsSoundCell.h"

@interface MLStatsSoundController () <UITableViewDataSource, UITableViewDelegate, MLStatSoundDelegate>
@property (nonatomic, strong) MLBasicAudioPlayer* player;
@property (nonatomic, strong) NSArray* categories;
@end

@implementation MLStatsSoundController

-(void) initializeData
{
    MLMainDataProvider* provider = [[MLMainDataProvider alloc] initMainProvider];
    NSArray* arr = [provider getCategories];
    _categories = [arr subarrayWithRange: NSMakeRange(1, arr.count - 1)];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        if (!_player)
        {
            _player = [[MLBasicAudioPlayer alloc] init];
            [self initializeData];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!_player)
    {
        _player = [[MLBasicAudioPlayer alloc] init];
        [self initializeData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self categories] count] / 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MLStatsSoundCell* cell = [tableView dequeueReusableCellWithIdentifier:@"StatsSoundCellID" forIndexPath:indexPath];
    
    NSString* desc_left = nil;
    NSString* sound_left = nil;
    
    NSString* desc_right = nil;
    NSString* sound_right = nil;
    
    if (indexPath.row * 2 + 0 < [[self categories] count])
    {
        desc_left = [[[self categories] objectAtIndex: indexPath.row * 2 + 0] categoryDescription];
        sound_left = [[[self categories] objectAtIndex: indexPath.row * 2 + 0] categoryAudioFile];
    }
    
    if (indexPath.row * 2 + 1 < [[self categories] count])
    {
        desc_right = [[[self categories] objectAtIndex: indexPath.row * 2 + 1] categoryDescription];
        sound_right = [[[self categories] objectAtIndex: indexPath.row * 2 + 1] categoryAudioFile];
    }
    
    [cell setTitles: desc_left withRight: desc_right];
    [cell setSounds: sound_left withRight: sound_right];
    cell.delegate = self;

    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(void) onSoundSelected:(NSString*)soundToPlay
{
    [[self player] loadFileFromResource: soundToPlay withExtension: @"mp3"];
    [[self player] prepareToPlay];
    [[self player] play];
    
    UIBarButtonItem* next = [[UIBarButtonItem alloc] initWithTitle: @"Next" style:UIBarButtonItemStylePlain target: self action: @selector(onNextClicked:)];
    self.navigationItem.rightBarButtonItem = next;
}

- (IBAction)onNextClicked:(UIButton*)sender
{
    //TODO:
    //this page or previous page should display a dropdown or view with 4 options.
    //get selection title, save it in the database or pass it to the next view.
    //next view will display the time-settings page for the user to select the date-range filter.
}

@end
