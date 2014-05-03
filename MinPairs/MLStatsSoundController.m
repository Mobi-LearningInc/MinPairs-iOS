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
#import "MLStatisticsViewController.h"

@interface MLStatsSoundController () <UITableViewDataSource, UITableViewDelegate, MLStatSoundDelegate>
@property (nonatomic, strong) MLBasicAudioPlayer* player;
@property (nonatomic, strong) NSArray* categories;
@property (nonatomic, strong) UIView* dropDown;
@property (nonatomic, assign) NSUInteger dropDownSelectedOption;
@property (nonatomic, assign) NSUInteger selectedSoundIndex;
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

-(void)animate:(UIView*)view withOffset:(float)offset withCompletion:(void(^)(BOOL finished))completion_func
{
    [UIView animateWithDuration: 0.7f animations: ^{
        CGRect rect = [view frame];
        rect.size.height = offset;
        view.frame = rect;
    } completion: completion_func];
}

-(void)addDropDownControls
{
    UIView* view = [self dropDown];
    
    CGFloat padding = 8.0f;
    
    CGFloat x = view.frame.origin.x + padding;
    CGFloat y = view.frame.origin.y + padding;
    CGFloat width = view.frame.size.width - (padding * 2.0f); //8 padding on the left and right.
    CGFloat height = [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f ? 30.0f : 50.0f;
    
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
    {
        padding = 15.0f;
    }
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        height = view.frame.size.height;
        
        if (![[[self navigationController] navigationBar] isHidden])
        {
            height -= [[self navigationController] navigationBar].frame.size.height;
        }
        
        height = (height / 4.0f) - (padding * 2.0f);
    }
    
    UIButton* all_option = [[UIButton alloc] initWithFrame: CGRectMake(x, y, width, height)];
    UIButton* listen_select_option = [[UIButton alloc] initWithFrame: CGRectMake(x, y += height + padding, width, height)];
    UIButton* listen_type_option = [[UIButton alloc] initWithFrame: CGRectMake(x, y += height + padding, width, height)];
    UIButton* read_select_option = [[UIButton alloc] initWithFrame: CGRectMake(x, y += height + padding, width, height)];
    
    [all_option setTitle: @"All" forState: UIControlStateNormal];
    [listen_select_option setTitle: @"Listen and Select" forState: UIControlStateNormal];
    [listen_type_option setTitle: @"Listen and Type" forState: UIControlStateNormal];
    [read_select_option setTitle: @"Read and Select" forState: UIControlStateNormal];
    
    UIColor* titleColour = [UIColor whiteColor];
    [all_option setTitleColor: titleColour forState: UIControlStateNormal];
    [listen_select_option setTitleColor: titleColour forState: UIControlStateNormal];
    [listen_type_option setTitleColor: titleColour forState: UIControlStateNormal];
    [read_select_option setTitleColor: titleColour forState: UIControlStateNormal];
    
    UIColor* bgColour = [UIColor colorWithRed: 99.0f/0xFF green: 116.0f/0xFF blue: 1.0f alpha:1];
    [all_option setBackgroundColor: bgColour];
    [listen_select_option setBackgroundColor: bgColour];
    [listen_type_option setBackgroundColor: bgColour];
    [read_select_option setBackgroundColor: bgColour];
    
    [all_option setTag: 1];
    [listen_select_option setTag: 2];
    [listen_type_option setTag: 3];
    [read_select_option setTag: 4];
    
    [all_option addTarget:self action:@selector(onDropdownSelection:) forControlEvents: UIControlEventTouchUpInside];
    [listen_select_option addTarget:self action:@selector(onDropdownSelection:) forControlEvents: UIControlEventTouchUpInside];
    [listen_type_option addTarget:self action:@selector(onDropdownSelection:) forControlEvents: UIControlEventTouchUpInside];
    [read_select_option addTarget:self action:@selector(onDropdownSelection:) forControlEvents: UIControlEventTouchUpInside];
    
    [[self dropDown] addSubview: all_option];
    [[self dropDown] addSubview: listen_select_option];
    [[self dropDown] addSubview: listen_type_option];
    [[self dropDown] addSubview: read_select_option];
}

-(void)initDropDown
{
    UITableView* view = (UITableView*)[self view];
    [view setScrollEnabled: false];
    
    CGRect frame = [[self view] frame];
    frame.size.height = 0;
    
    self.dropDown = [[UIView alloc] initWithFrame: frame];
    [[self dropDown] setBackgroundColor: [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.8f]];
    
    [[self view] addSubview: [self dropDown]];
    [self animate: [self dropDown] withOffset: self.view.frame.size.height withCompletion: nil];
    [self addDropDownControls];
}

-(void)destroyDropDown
{
    for (UIView* view in [[self dropDown] subviews])
    {
        [view removeFromSuperview];
    }
    
    [self animate: [self dropDown] withOffset: 0 withCompletion: ^(BOOL finished){
        if (finished)
        {
            [[self dropDown] removeFromSuperview];
            self.dropDown = nil;
            UITableView* view = (UITableView*)[self view];
            [view setScrollEnabled: true];
        }
    }];
}

- (IBAction)onDropdownSelection:(UIButton*)sender
{
    self.dropDownSelectedOption = [sender tag];
    [self destroyDropDown];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [[self dropDown] removeFromSuperview];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if (![self dropDownSelectedOption])
    {
        [self initDropDown];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initDropDown];
    
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
    NSString* desc_right = nil;
    
    NSUInteger sound_left_index = 0;
    NSUInteger sound_right_index = 0;
    
    if (indexPath.row * 2 + 0 < [[self categories] count])
    {
        sound_left_index = indexPath.row * 2 + 0;
        desc_left = [[[self categories] objectAtIndex: sound_left_index] categoryDescription];
    }
    
    if (indexPath.row * 2 + 1 < [[self categories] count])
    {
        sound_right_index = indexPath.row * 2 + 1;
        desc_right = [[[self categories] objectAtIndex: sound_right_index] categoryDescription];
    }
    
    [cell setTitles: desc_left withRight: desc_right];
    [cell setIndices: sound_left_index withRightIndex: sound_right_index];
    cell.delegate = self;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MLStatsSoundCell* cell = (MLStatsSoundCell*)[tableView cellForRowAtIndexPath: indexPath];
    if (cell.selectionStyle != UITableViewCellSelectionStyleNone)
    {
    }
}

-(void) onSoundSelected:(NSUInteger)soundIndex
{
    self.selectedSoundIndex = soundIndex;
    NSString* soundToPlay = [[[self categories] objectAtIndex: soundIndex] categoryAudioFile];
    [[self player] loadFileFromResource: soundToPlay withExtension: @"mp3"];
    [[self player] prepareToPlay];
    [[self player] play];
    
    UIBarButtonItem* next = [[UIBarButtonItem alloc] initWithTitle: @"Next" style:UIBarButtonItemStylePlain target: self action: @selector(onNextClicked:)];
    self.navigationItem.rightBarButtonItem = next;
}

- (IBAction)onNextClicked:(UIButton*)sender
{
    [self performSegueWithIdentifier: @"stats_graph_segue" sender: [NSNumber numberWithUnsignedInteger: [self selectedSoundIndex]]];
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier]isEqualToString:@"stats_graph_segue"])
    {
        MLStatisticsViewController* vc = [segue destinationViewController];
        vc.categories = [self categories];
        vc.dropDownSelectedOption = [self dropDownSelectedOption];
        vc.categoryIndex = [sender unsignedIntegerValue];
    }
}

@end
