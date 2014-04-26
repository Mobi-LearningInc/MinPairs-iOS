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

@interface MLViewController ()
@end

@implementation MLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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

-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if([[segue identifier]isEqualToString:@"PQOne"])
    {
        MLPQOneViewController* vc = [segue destinationViewController];
        vc.practiceMode = [sender boolValue];
    }
    else if([[segue identifier]isEqualToString:@"PQTwo"])
    {
        MLPQTwoViewController* vc = [segue destinationViewController];
        vc.practiceMode = [sender boolValue];
    }
    else if ([[segue identifier]isEqualToString:@"PQThree"])
    {
        MLPQThreeViewController* vc = [segue destinationViewController];
        vc.practiceMode = [sender boolValue];
    }
}

@end
