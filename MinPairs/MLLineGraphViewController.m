//
//  MLLineGraphViewController.m
//  MinPairs
//
//  Created by Brandon on 2014-05-20.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLLineGraphViewController.h"

@interface MLLineGraphViewController ()
@property (weak, nonatomic) IBOutlet MLLineGraphView *hostView;

@end

@implementation MLLineGraphViewController

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
    [[self hostView] createGraph];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end