//
//  MLResultsViewController.m
//  MinPairs
//
//  Created by Brandon on 2014-05-09.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLResultsViewController.h"
#import "MLPlatform.h"

@interface MLResultsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *correctLabel;
@property (weak, nonatomic) IBOutlet UILabel *wrongLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end

@implementation MLResultsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowOffset = CGSizeMake(0.0, 8.0);
    self.view.layer.shadowOpacity = 0.5;
    self.view.layer.shadowRadius = 10.0;
    self.view.layer.cornerRadius = 5.0;
    //self.view.layer.masksToBounds = YES;
    
    [MLPlatform setButtonBorder: [self continueButton] withBorderWidth: 1.0f withColour: [UIColor whiteColor]];
    [MLPlatform setButtonRound: [self continueButton] withRadius: 10.0f];
    
    self.titleLabel.text = [[self text] capitalizedString];
    self.correctLabel.text = [NSString stringWithFormat: @"%@ %@", self.correctLabel.text, [self correct]];
    self.wrongLabel.text = [NSString stringWithFormat: @"%@ %@", self.wrongLabel.text, [self wrong]];
    self.totalLabel.text = [NSString stringWithFormat: @"%@ %@", self.totalLabel.text, [self total]];
    self.timeLabel.text = [NSString stringWithFormat: @"%@ %@s", self.timeLabel.text, [self time]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onContinueClicked:(UIButton *)sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
