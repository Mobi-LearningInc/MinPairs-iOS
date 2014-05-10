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
#import "MLPlatform.h"

@interface MLViewController ()
@property (nonatomic, assign) int theme;
@property (nonatomic, strong) UIColor* colour;
@property (nonatomic, strong) UIColor* btnColour;
@end

@implementation MLViewController

- (IBAction)onResetThemeClicked:(UIButton *)sender
{
    self.theme = 0;
    self.view.backgroundColor = self.colour;
    for (UIView* view in [[self view] subviews])
    {
        if ([view isKindOfClass: [UIButton class]])
        {
            [((UIButton*)view) setBackgroundColor: _btnColour];
            [((UIButton*)view) setBackgroundImage: nil forState: UIControlStateNormal];
        }
    }
    
    [MLPlatform setButtonsRound: [self view] withRadius: 0.0f];
    [MLPlatform setButtonsBorder: [self view] withBorderWidth: 1.0f withColour: [UIColor whiteColor]];
}

- (IBAction)onTestThemeClicked:(UIButton *)sender
{
    UIImage* img = nil;
    switch(_theme)
    {
        case 2:
            img = [UIImage imageNamed:@"lblack.png"];
            break;
            
        case 3:
            img = [UIImage imageNamed:@"lblue.png"];
            break;
            
        case 4:
            img = [UIImage imageNamed:@"lmagenta.png"];
            break;
            
        case 5:
            img = [UIImage imageNamed:@"lorange.png"];
            break;
            
        case 6:
            img = [UIImage imageNamed:@"lyellow.png"];
            break;
            
        case 7:
            img = [UIImage imageNamed:@"lyelloworange.png"];
            break;
            
        case 8:
            img = [UIImage imageNamed:@"dblack.png"];
            break;
            
        case 9:
            img = [UIImage imageNamed:@"dblue.png"];
            break;
            
        case 10:
            img = [UIImage imageNamed:@"dmagenta.png"];
            break;
            
        case 11:
            img = [UIImage imageNamed:@"dorange.png"];
            break;
            
        case 12:
            img = [UIImage imageNamed:@"dyellow.png"];
            break;
            
        case 13:
            img = [UIImage imageNamed:@"dyelloworange.png"];
            break;
    }
    
    if (_theme == 0)
    {
        [MLPlatform setButtonsRound: [self view] withRadius: 0.0f];
        [MLPlatform setButtonsBorder: [self view] withBorderWidth: 1.0f withColour: [UIColor whiteColor]];
    }
    else
    {
        [MLPlatform setButtonsRound: [self view] withRadius: 5.0f];
    }
    
    if (_theme > 1 && _theme <= 7)
    {
        [MLPlatform setButtonsBorder: [self view] withBorderWidth: 0.0f withColour: nil];
        self.view.backgroundColor = self.colour;
    }
    else
    {
        self.view.backgroundColor = [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1];
    }
    
    for (UIView* view in [[self view] subviews])
    {
        if ([view isKindOfClass: [UIButton class]])
        {
            [((UIButton*)view) setBackgroundImage:img forState:UIControlStateNormal];
            
            if (_theme > 1)
            {
                [((UIButton*)view) setBackgroundColor: nil];
            }
        }
    }
    
    ++_theme;
    
    if (_theme == 14)
    {
        _theme = 0;
    }
    [[self view] setNeedsDisplay];
}

-(void) viewWillAppear:(BOOL)animated
{
    if (!_theme)
    {
        self.colour = self.view.backgroundColor;
        [MLPlatform setButtonsBorder: [self view] withBorderWidth: 1.0f withColour: [UIColor whiteColor]];
        
        for (UIView* view in [[self view] subviews])
        {
            if ([view isKindOfClass: [UIButton class]])
            {
                _btnColour = [((UIButton*)view) backgroundColor];
                break;
            }
        }
    }
    
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
    [super viewDidLoad];
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
