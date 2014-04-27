//
//  MLSettingsViewController.m
//  MinPairs
//
//  Created by Brandon on 2014-04-26.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLSettingsViewController.h"
#import "MLSettingDatabase.h"
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
    [self updateControls];
    /*
    uint32_t timelistenAndSelect = 0;
    uint32_t timeListenAndRead = 0;
    uint32_t timeListenAndType = 0;
    
    if ([MLSettings getSettings: &timelistenAndSelect withTimeListenAndRead: &timeListenAndRead withListenAndTypeQuestion: &timeListenAndType])
    {
        [[self listenAndSelectBox] setText: [NSString stringWithFormat:@"%d", timelistenAndSelect]];
        [[self listenAndReadBox] setText: [NSString stringWithFormat:@"%d", timeListenAndRead]];
        [[self listenAndTypeBox] setText: [NSString stringWithFormat:@"%d", timeListenAndType]];
    }
    else
    {
        [MLSettings getDefaultSettings: &timelistenAndSelect withTimeListenAndRead: &timeListenAndRead withListenAndTypeQuestion: &timeListenAndType];
        
        [[self listenAndSelectBox] setText: [NSString stringWithFormat:@"%d", timelistenAndSelect]];
        [[self listenAndReadBox] setText: [NSString stringWithFormat:@"%d", timeListenAndRead]];
        [[self listenAndTypeBox] setText: [NSString stringWithFormat:@"%d", timeListenAndType]];
    }*/
}
-(void)updateControls
{
    MLSettingDatabase * settingsDb=[[MLSettingDatabase alloc]initSettingDatabase];
    MLSettingsData* data = [settingsDb getSetting];
    [[self listenAndSelectBox] setText: [NSString stringWithFormat:@"%i", data.settingTimeSelect]];
    [[self listenAndReadBox] setText: [NSString stringWithFormat:@"%i", data.settingTimeRead]];
    [[self listenAndTypeBox] setText: [NSString stringWithFormat:@"%i", data.settingTimeType]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onSaveClicked:(id)sender
{
    int selectTime = [self.listenAndSelectBox.text intValue];
    int readTime=[self.listenAndReadBox.text intValue];
    int typeTime =[self.listenAndTypeBox.text intValue];
    MLSettingsData* data = [[MLSettingsData alloc]initSettingWithTimeSelect:selectTime timeRead:readTime timeType:typeTime];
    MLSettingDatabase * settingsDb=[[MLSettingDatabase alloc]initSettingDatabase];
    [settingsDb saveSetting:data];
}
- (IBAction)onResetClicked:(UIButton *)sender
{
    MLSettingDatabase * settingsDb=[[MLSettingDatabase alloc]initSettingDatabase];
    [settingsDb saveDefaultSetting];
    [self updateControls];
    /*
    uint32_t timelistenAndSelect = 0;
    uint32_t timeListenAndRead = 0;
    uint32_t timeListenAndType = 0;
    NSLog(@"here 1");
    [MLSettings getDefaultSettings: &timelistenAndSelect withTimeListenAndRead: &timeListenAndRead withListenAndTypeQuestion: &timeListenAndType];
    NSLog(@"here 2");
    if ([MLSettings updateSettings: timelistenAndSelect withTimeListenAndRead: timeListenAndRead withListenAndTypeQuestion: timeListenAndType])
    {
        [[self listenAndSelectBox] setText: [NSString stringWithFormat:@"%d", timelistenAndSelect]];
        [[self listenAndReadBox] setText: [NSString stringWithFormat:@"%d", timeListenAndRead]];
        [[self listenAndTypeBox] setText: [NSString stringWithFormat:@"%d", timeListenAndType]];
    }
    NSLog(@"here 3");
     */
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //hides keyboard
    [self.view endEditing:YES];
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
