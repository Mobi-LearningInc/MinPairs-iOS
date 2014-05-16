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
@property (weak, nonatomic) IBOutlet UIStepper* listenAndSelectStepper;
@property (weak, nonatomic) IBOutlet UIStepper* listenAndReadStepper;
@property (weak, nonatomic) IBOutlet UIStepper* listenAndTypeStepper;
@property (weak, nonatomic) IBOutlet UILabel *listenAndSelectLabel;
@property (weak, nonatomic) IBOutlet UILabel *listenAndReadLabel;
@property (weak, nonatomic) IBOutlet UILabel *listenAndTypeLabel;
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
    
    [[self listenAndSelectStepper] setValue: data.settingTimeSelect];
    [[self listenAndReadStepper] setValue: data.settingTimeRead];
    [[self listenAndTypeStepper] setValue: data.settingTimeType];
    
    [[self listenAndSelectLabel] setText: [NSString stringWithFormat:@"%d seconds", data.settingTimeSelect]];
    [[self listenAndReadLabel] setText: [NSString stringWithFormat:@"%d seconds", data.settingTimeRead]];
    [[self listenAndTypeLabel] setText: [NSString stringWithFormat:@"%d seconds", data.settingTimeType]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSaveClicked:(UIButton*)sender
{
    int selectTime = [[self listenAndSelectStepper] value];
    int readTime = [[self listenAndReadStepper] value];
    int typeTime = [[self listenAndTypeStepper] value];
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

- (IBAction)onStepperChanged:(UIStepper *)sender
{
    if (sender == [self listenAndSelectStepper])
    {
        [[self listenAndSelectLabel] setText: [NSString stringWithFormat:@"%lu seconds", (unsigned long)[sender value]]];
    }
    else if (sender == [self listenAndReadStepper])
    {
        [[self listenAndReadLabel] setText: [NSString stringWithFormat:@"%lu seconds", (unsigned long)[sender value]]];
    }
    else
    {
        [[self listenAndTypeLabel] setText: [NSString stringWithFormat:@"%lu seconds", (unsigned long)[sender value]]];
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
