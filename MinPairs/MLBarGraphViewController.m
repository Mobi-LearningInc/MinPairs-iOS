//
//  MLBarGraphViewController.m
//  MinPairs
//
//  Created by Brandon on 2014-05-20.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLBarGraphViewController.h"
#import "MLStatsTabBarViewController.h"

@interface MLBarGraphViewController ()
@property (weak, nonatomic) IBOutlet MLBarGraphView *hostView;

@end

@implementation MLBarGraphViewController

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
    MLStatsTabBarViewController* controller = (MLStatsTabBarViewController*)[self tabBarController];
    [[self hostView] setGraphData: [controller barGraphResults]];
    [[self hostView] createGraph];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
