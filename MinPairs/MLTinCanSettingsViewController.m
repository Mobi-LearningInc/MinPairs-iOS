//
//  MLTinCanSettingsViewController.m
//  MinPairs
//
//  Created by Oleksiy Martynov on 5/29/14.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLTinCanSettingsViewController.h"
#import "MLLrsCredentialsDatabase.h"
@interface MLTinCanSettingsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextBox;
@property (weak, nonatomic) IBOutlet UITextField *emailTextBox;

@property (weak, nonatomic) IBOutlet UITextField *lrsAuthTextBox;
@property (weak, nonatomic) IBOutlet UITextField *lrsPasswordTextBox;
@property (weak, nonatomic) IBOutlet UITextField *lrsUrlTextBox;
@property (weak, nonatomic) IBOutlet UISegmentedControl *toggleBtn;

@end

@implementation MLTinCanSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.userNameTextBox.delegate=self;
    self.emailTextBox.delegate=self;
    self.lrsAuthTextBox.delegate=self;
    self.lrsPasswordTextBox.delegate=self;
    self.lrsUrlTextBox.delegate=self;
    [self loadAndFillPage];
}
- (IBAction)onHomeClicked:(UIBarButtonItem *)sender
{
    [[self navigationController] popViewControllerAnimated:true];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadAndFillPage
{
    MLLrsCredentialsDatabase* credDb =[[MLLrsCredentialsDatabase alloc]initLmsCredentialsDatabase];
    MLLsrCredentials* loadedCreds = [credDb getLmsCredentials];
    self.lrsAuthTextBox.text=loadedCreds.userName;
    self.lrsPasswordTextBox.text=loadedCreds.password;
    self.lrsUrlTextBox.text=loadedCreds.address;
    //todo create ways of enabling/disabling tincan
    self.toggleBtn.selectedSegmentIndex=0;
}
- (IBAction)tinCanToggleBtnTap:(id)sender
{
    if([sender selectedSegmentIndex]==0)
    {
        NSLog(@"turning on/off TinCan not yet implemented");
        [self.userNameTextBox setEnabled:YES];
        [self.emailTextBox setEnabled:YES];
        [self.lrsAuthTextBox setEnabled:YES];
        [self.lrsPasswordTextBox setEnabled:YES];
        [self.lrsUrlTextBox setEnabled:YES];
    }
    else if([sender selectedSegmentIndex]==1)
    {
        NSLog(@"turning on/off TinCan not yet implemented");
        [self.userNameTextBox setEnabled:NO];
        [self.emailTextBox setEnabled:NO];
        [self.lrsAuthTextBox setEnabled:NO];
        [self.lrsPasswordTextBox setEnabled:NO];
        [self.lrsUrlTextBox setEnabled:NO];
    }
}

- (IBAction)onResetBtnTap:(id)sender
{
    [self resetTinCanSettingsToDefaults];
}
- (IBAction)onSaveBtnTap:(id)sender
{
    NSLog(@"USERNAME and EMAIL are not saved. Everything else is saved.");//todo save username and email
    //todo validate LRS credentials before saving
    MLLsrCredentials* newCreds = [[MLLsrCredentials alloc]initCredentialsWithId:1 appName:ML_DB_CREDENTIALS_DEFAULT_APPNAME userName:self.lrsAuthTextBox.text password:self.lrsPasswordTextBox.text address:self.lrsUrlTextBox.text];
    [self saveTinCanSettingsData:newCreds];
    
    [[self navigationController] popViewControllerAnimated:true];
}
-(void)saveTinCanSettingsData:(MLLsrCredentials*)creds
{
    MLLrsCredentialsDatabase* credDb = [[MLLrsCredentialsDatabase alloc]initLmsCredentialsDatabase];
    [credDb saveLmsCredentials:creds];
}
-(void)resetTinCanSettingsToDefaults
{
    MLLrsCredentialsDatabase* credDb = [[MLLrsCredentialsDatabase alloc]initLmsCredentialsDatabase];
    [credDb saveDefaultCredentials];
    [self loadAndFillPage];
}
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    //hides keyboard
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
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
