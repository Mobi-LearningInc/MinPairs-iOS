//
//  MLSettingsViewController.m
//  MinPairs
//
//  Created by Brandon on 2014-04-26.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLSettingsViewController.h"

@interface MLSettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField* listenAndSelectBox;
@property (weak, nonatomic) IBOutlet UITextField* listenAndReadBox;
@property (weak, nonatomic) IBOutlet UITextField* listenAndTypeBox;
@end

@implementation MLSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    uint32_t timelistenAndSelect = 0;
    uint32_t timeListenAndRead = 0;
    uint32_t timeListenAndType = 0;
    
    /*if ([MLSettings getSettings: &timelistenAndSelect withTimeListenAndRead: &timeListenAndRead withListenAndTypeQuestion: &timeListenAndType])
    {
        [[self listenAndSelectBox] setText: [NSString stringWithFormat:@"%d", timelistenAndSelect]];
        [[self listenAndReadBox] setText: [NSString stringWithFormat:@"%d", timeListenAndRead]];
        [[self listenAndTypeBox] setText: [NSString stringWithFormat:@"%d", timeListenAndType]];
    }
    else*/
    {
        [MLSettings getDefaultSettings: &timelistenAndSelect withTimeListenAndRead: &timeListenAndRead withListenAndTypeQuestion: &timeListenAndType];
        
        [[self listenAndSelectBox] setText: [NSString stringWithFormat:@"%d", timelistenAndSelect]];
        [[self listenAndReadBox] setText: [NSString stringWithFormat:@"%d", timeListenAndRead]];
        [[self listenAndTypeBox] setText: [NSString stringWithFormat:@"%d", timeListenAndType]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onResetClicked:(UIButton *)sender
{
    uint32_t timelistenAndSelect = 0;
    uint32_t timeListenAndRead = 0;
    uint32_t timeListenAndType = 0;
    
    [MLSettings getDefaultSettings: &timelistenAndSelect withTimeListenAndRead: &timeListenAndRead withListenAndTypeQuestion: &timeListenAndType];
    
    if ([MLSettings updateSettings: timelistenAndSelect withTimeListenAndRead: timeListenAndRead withListenAndTypeQuestion: timeListenAndType])
    {
        [[self listenAndSelectBox] setText: [NSString stringWithFormat:@"%d", timelistenAndSelect]];
        [[self listenAndReadBox] setText: [NSString stringWithFormat:@"%d", timeListenAndRead]];
        [[self listenAndTypeBox] setText: [NSString stringWithFormat:@"%d", timeListenAndType]];
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
