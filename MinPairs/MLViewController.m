//
//  MLViewController.m
//  MinPairs
//
//  Created by ituser on 4/23/2014.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLViewController.h"
#import "MLPQOneViewController.h"
#import "MLPQTwoViewController.h"
#import "MLPQThreeViewController.h"
#import "MLSettingDatabase.h"
#import "MLCategory.h"
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
        }
    }
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
    [self pushSequeOnStack: [NSNumber numberWithBool: true]];
}

- (IBAction)onQuizzesClicked:(UIButton *)sender
{
    [self pushSequeOnStack: [NSNumber numberWithBool: false]];
}

-(void) pushSequeOnStack:(NSNumber*)mode
{
    unsigned int r = arc4random_uniform(30);
    
    if (r < 10)
    {
        [self performSegueWithIdentifier:@"PQOne" sender: mode];
        
    }
    else if (r < 20)
    {
        [self performSegueWithIdentifier:@"PQTwo" sender: mode];
    }
    else
    {
        [self performSegueWithIdentifier:@"PQThree" sender: mode];
    }
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
    if([[segue identifier]isEqualToString:@"PQOne"]||[[segue identifier]isEqualToString:@"PQTwo"]||[[segue identifier]isEqualToString:@"PQThree"])
    {
    NSString* typeStr = ([sender boolValue])?ML_TEST_TYPE_PRACTICE:ML_TEST_TYPE_QUIZ;
    NSDate* now = [NSDate date];
    NSDateFormatter* formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy MMM dd HH:mm:ss"];
    NSString* dateStr = [formatter stringFromDate:now];
    MLTestResult* initialResult= [[MLTestResult alloc]initTestResultWithCorrect:0 wrong:0 type:typeStr date:dateStr timeInSec:0 extraInfo:@"testing"];
    if([[segue identifier]isEqualToString:@"PQOne"])
    {
        MLPQOneViewController* vc = [segue destinationViewController];
        vc.practiceMode = [sender boolValue];
        vc.previousResult=initialResult;
        vc.questionCount=1;
    }
    else if([[segue identifier]isEqualToString:@"PQTwo"])
    {
        MLPQTwoViewController* vc = [segue destinationViewController];
        vc.practiceMode = [sender boolValue];
        vc.previousResult=initialResult;
        vc.questionCount=1;
    }
    else if ([[segue identifier]isEqualToString:@"PQThree"])
    {
        MLPQThreeViewController* vc = [segue destinationViewController];
        vc.practiceMode = [sender boolValue];
        vc.previousResult=initialResult;
        vc.questionCount=1;
    }
    }
}

@end
