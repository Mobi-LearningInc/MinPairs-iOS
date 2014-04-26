//
//  MLViewController.m
//  MinPairs
//
//  Created by ituser on 4/23/2014.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLViewController.h"

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

- (IBAction)onRadioOne:(UIButton *)sender
{
    NSLog(@"%@", [sender currentTitle]);
}

- (IBAction)onRadioTwo:(UIButton *)sender
{
    NSLog(@"%@", [sender currentTitle]);
}

- (IBAction)onRadioThree:(UIButton *)sender
{
    NSLog(@"%@", [sender currentTitle]);
}


@end
