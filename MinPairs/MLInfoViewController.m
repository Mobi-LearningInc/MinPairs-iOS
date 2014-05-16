//
//  MLInfoViewController.m
//  MinPairs
//
//  Created by Brandon on 2014-05-10.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLInfoViewController.h"
#import "MLPlatform.h"

@interface MLInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextView* InfoView;
@property (weak, nonatomic) IBOutlet UILabel* CopyrightLabel;
@end

@implementation MLInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString* build = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString* version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    NSMutableAttributedString* text = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:self.InfoView.text, version, build, @"Aga Palalas", @"Przemyslaw Pawluk", @"..."]];
    
    self.InfoView.attributedText = [MLPlatform parseBBCodes:text withFontSize:self.InfoView.font.pointSize];
    self.InfoView.dataDetectorTypes = UIDataDetectorTypeLink;
    
    self.CopyrightLabel.text = @"Copyright © 2014. Mobi-Learning™ Inc.";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
