//
//  MLSettingsViewController.m
//  MinPairs
//
//  Created by Brandon on 2014-04-26.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLSettingsViewController.h"
#import "MLSettingDatabase.h"
#import "MLPlatform.h"

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
    [MLPlatform setButtonsRound: [self view] withRadius: 5.0f];
    [super viewDidLoad];
    [self updateControls];
}

-(void)updateControls
{
    MLSettingDatabase * settingsDb=[[MLSettingDatabase alloc]initSettingDatabase];
    MLSettingsData* data = [settingsDb getSetting];
    [[self listenAndSelectBox] setText: [NSString stringWithFormat:@"%d", data.settingTimeSelect]];
    [[self listenAndReadBox] setText: [NSString stringWithFormat:@"%d", data.settingTimeRead]];
    [[self listenAndTypeBox] setText: [NSString stringWithFormat:@"%d", data.settingTimeType]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSaveClicked:(UIButton*)sender
{
    int selectTime = [self.listenAndSelectBox.text intValue];
    int readTime=[self.listenAndReadBox.text intValue];
    int typeTime =[self.listenAndTypeBox.text intValue];
    MLSettingDatabase * settingsDb=[[MLSettingDatabase alloc]initSettingDatabase];
    MLSettingsData* currentSetting =[settingsDb getSetting];
    MLSettingsData* data = [[MLSettingsData alloc]initSettingWithTimeSelect:selectTime timeRead:readTime timeType:typeTime filterSelection:currentSetting.settingFilterCatPair];
    
    [settingsDb saveSetting:data];
}

- (IBAction)onResetClicked:(UIButton*)sender
{
    MLSettingDatabase * settingsDb=[[MLSettingDatabase alloc]initSettingDatabase];
    [settingsDb saveDefaultSetting];
    [self updateControls];
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
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
