//
//  MLResultsViewController.m
//  MinPairs
//
//  Created by Brandon on 2014-05-09.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLResultsViewController.h"
#import "MLPlatform.h"
#import "MLShareViewController.h"
#import "MLTinCanConnector.h"
#import "MLLrsCredentialsDatabase.h"
#import "MLTheme.h"
#import "MLDetailTableViewController.h"
@interface MLResultsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreInfoLabel;

@end

@implementation MLResultsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [MLTheme setTheme: self];
    [super viewDidLoad];
    
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowOffset = CGSizeMake(0.0, 8.0);
    self.view.layer.shadowOpacity = 0.5;
    self.view.layer.shadowRadius = 10.0;
    self.view.layer.cornerRadius = 5.0;
    //self.view.layer.masksToBounds = YES;
    
    //[MLPlatform setButtonBorder: [self continueButton] withBorderWidth: 1.0f withColour: [UIColor whiteColor]];
    //[MLPlatform setButtonRound: [self continueButton] withRadius: 10.0f];
    
    
    self.titleLabel.text = [[self text] capitalizedString];
    self.scoreInfoLabel.text = [NSString stringWithFormat:@"Score: %@ / %@\n\nTime taken: %@s", [self correct], [self total], [self time]];
    
    NSNumber *c = [NSNumber numberWithInt:[[self correct] intValue]];
    NSNumber *t = [NSNumber numberWithInt:[[self total] intValue]];
    NSNumber *p = [NSNumber numberWithFloat:([c floatValue]/[t floatValue])];
    
    MLTinCanConnector *tincan = [[MLTinCanConnector alloc]initWithCredentials:[[[MLLrsCredentialsDatabase alloc]initLmsCredentialsDatabase] getLmsCredentials]];
    [tincan saveQuizResults:p points:c max:t time:[NSString stringWithFormat:@"PT%@.00S", [self time]]];

    
}
- (IBAction)onDetailsBtn:(id)sender
{
    MLDetailTableViewController* dtvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsTableViewController"];
    dtvc.array=self.detailsArray;
    [self presentViewController:dtvc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onContinueClicked:(UIButton *)sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}
- (IBAction)onShareClicked:(id)sender
{
    MLShareViewController* msvc=[self.storyboard instantiateViewControllerWithIdentifier: @"ShareViewController"];
    msvc.socialMessage=[NSString stringWithFormat:@"I am using MinPairs app to improve my english."];
    msvc.isModal=true;
    msvc.socialImage = [self captureScreen:self.view];
    [self presentViewController:msvc animated:YES completion:nil];
}
-(UIImage*)captureScreen:(UIView*) viewToCapture
{
    UIGraphicsBeginImageContext(viewToCapture.bounds.size);
    [viewToCapture.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /*
    if([segue.identifier isEqualToString:@"goToDetails"])
    {
        if([[segue destinationViewController] isKindOfClass:[MLDetailTableViewController class ]])
        {
            MLDetailTableViewController* dtvc =[segue destinationViewController];
            dtvc.array=self.detailsArray;
        }
    }
     */
    /*
    if([segue.identifier isEqualToString:@"fromResultsGoToShare"])
    {
        if ([[segue destinationViewController] isKindOfClass:[MLShareViewController class]])
        {
            MLShareViewController* msvc=[segue destinationViewController];
            msvc.socialMessage=[NSString stringWithFormat:@"I am using MinPairs app to improve my english."];
            msvc.isModal=false;
            msvc.socialImage = [self captureScreen:self.view];
        }
    }*/
}

@end
