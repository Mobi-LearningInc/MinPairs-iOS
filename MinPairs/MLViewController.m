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
    UIImage* helpicon = [UIImage imageNamed:@"help.png"];
    UIImage* helpiconnormal = [MLPlatform imageWithColor:helpicon withColour:[UIColor colorWithRed:0.0f green:120.0f/0xFF blue:1.0f alpha:1.0f]];
    UIImage* helpiconhighlighted = [MLPlatform imageWithColor:helpicon withColour:[UIColor colorWithRed:0.0f green:120.0f/0xFF blue:1.0f alpha:0.25f]];
    
    UIButton* aboutbtn = [UIButton buttonWithType:UIButtonTypeInfoLight];
    UIButton* helpbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    
    [aboutbtn setFrame:CGRectMake(0, 0, 28, 28)];
    [helpbtn setFrame:CGRectMake(0, 0, 28, 28)];
    
    [aboutbtn addTarget: self action: @selector(onAboutClicked:) forControlEvents: UIControlEventTouchUpInside];
    [helpbtn addTarget: self action: @selector(onHelpClicked:) forControlEvents: UIControlEventTouchUpInside];
    
    [helpbtn setBackgroundImage:helpiconnormal forState: UIControlStateNormal];
    [helpbtn setBackgroundImage:helpiconhighlighted forState:UIControlStateHighlighted];
    
    UIBarButtonItem* about = [[UIBarButtonItem alloc] initWithCustomView:aboutbtn];
    UIBarButtonItem* help = [[UIBarButtonItem alloc] initWithCustomView:helpbtn];
    
    self.navigationItem.rightBarButtonItems = @[about];
    self.navigationItem.leftBarButtonItems = @[help];
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

-(IBAction)onAboutClicked:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"AppInfo" sender: @"Info"];
}

-(IBAction)onHelpClicked:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"AppHelp" sender: @"Help"];
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
