//
//  MLSplitViewController.m
//  MinPairs
//
//  Created by Brandon on 2014-04-30.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLSplitViewController.h"

@interface MLSplitViewController ()
@property (nonatomic, strong) id leftViewController;
@property (nonatomic, strong) id rightViewController;
@end

@implementation MLSplitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _leftViewController = [self.viewControllers firstObject];
    _rightViewController = [self.viewControllers lastObject];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
