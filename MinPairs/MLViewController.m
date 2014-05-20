//
//  MLViewController.m
//  MinPairs
//
//  Created by ituser on 4/23/2014.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLViewController.h"
#import "MLInstructionsViewController.h"
#import "MLCategory.h"
#import "MLSettingDatabase.h"
#import "MLTestResultDatabase.h"
#import "MLTheme.h"
#import "MLPlatform.h"
#import "MLTinCanConnector.h"
#import "MLLsrCredentials.h"
#import "MLLrsCredentialsDatabase.h"

@interface MLViewController ()
@property (nonatomic, strong) MLLrsCredentialsDatabase* lrsDatabase;
@property (nonatomic, strong) MLTinCanConnector* tincan;
@end

@implementation MLViewController

- (MLLrsCredentialsDatabase *)lrsDatabase{
    if(!_lrsDatabase){
        _lrsDatabase = [[MLLrsCredentialsDatabase alloc]initLmsCredentialsDatabase];
        [_lrsDatabase saveDefaultCredentials];
    }
    
    return _lrsDatabase;
}

- (MLTinCanConnector *)tincan{

    if (!_tincan) {
        _tincan = [[MLTinCanConnector alloc] initWithCredentials:[self.lrsDatabase getLmsCredentials]];
    }
    return _tincan;
}

-(void) viewWillAppear:(BOOL)animated
{
    UIImage* infoicon = [UIImage imageNamed:@"info.PNG"];
    UIImage* helpicon = [UIImage imageNamed:@"help.PNG"];
    UIImage* filtericon = [UIImage imageNamed:@"filter.PNG"];
    
    UIButton* infobtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    UIButton* helpbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    UIButton* filterbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    
    [infobtn setFrame:CGRectMake(0, 0, 28, 28)];
    [helpbtn setFrame:CGRectMake(0, 0, 28, 28)];
    [filterbtn setFrame:CGRectMake(0, 0, 28, 28)];
    
    [infobtn setImage:infoicon forState:UIControlStateNormal];
    [helpbtn setImage:helpicon forState:UIControlStateNormal];
    [filterbtn setImage:filtericon forState:UIControlStateNormal];
    
    [infobtn addTarget:self action:@selector(onInfoClicked:) forControlEvents:UIControlEventTouchUpInside];
    [helpbtn addTarget:self action:@selector(onHelpClicked:) forControlEvents:UIControlEventTouchUpInside];
    [filterbtn addTarget:self action:@selector(onFilterClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* info = [[UIBarButtonItem alloc] initWithCustomView:infobtn];
    UIBarButtonItem* help = [[UIBarButtonItem alloc] initWithCustomView:helpbtn];
    UIBarButtonItem* filter = [[UIBarButtonItem alloc] initWithCustomView:filterbtn];
    
    self.navigationItem.rightBarButtonItems = @[help, filter];
    self.navigationItem.leftBarButtonItems = @[info];
}

- (void)viewDidLoad
{
    [MLTheme setTheme: self];
    [super viewDidLoad];
    [self.tincan saveSampleActivity];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPracticeClicked:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"TestInstructions" sender: [NSNumber numberWithBool: true]];
}

- (IBAction)onQuizzesClicked:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"TestInstructions" sender: [NSNumber numberWithBool: false]];
}

-(IBAction)onInfoClicked:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"AppInfo" sender: @"Info"];
}

-(IBAction)onHelpClicked:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"AppHelp" sender: @"Help"];
}

-(IBAction)onFilterClicked:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"AppFilter" sender: @"Filter"];
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"stats_settings_segue"] &&  ![[[MLTestResultDatabase alloc] initTestResultDatabase] getCount])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Statistics" message:@"There are currently no statistics to display." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
        [self.navigationController popToRootViewControllerAnimated:TRUE];
        return false;
    }
    return true;
}

-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString: @"TestInstructions"])
    {
        MLInstructionsViewController* vc = [segue destinationViewController];
        vc.mode = sender;
    }
}

@end
