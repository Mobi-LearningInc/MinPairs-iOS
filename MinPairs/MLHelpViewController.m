//
//  MLHelpViewController.m
//  MinPairs
//
//  Created by Brandon on 2014-05-11.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLHelpViewController.h"
#import "MLPlatform.h"

@interface MLHelpViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation MLHelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView* listen_select_img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 75, 75)];
    UIImageView* listen_select_word = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 75, 75)];
    UIImageView* listen_type_word = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, 75, 75)];
    
    [listen_select_img setImage: [UIImage imageNamed:@"picture.png"]];
    [listen_select_word setImage: [UIImage imageNamed:@"sound.png"]];
    [listen_type_word setImage: [UIImage imageNamed:@"write.png"]];
    
    UIBezierPath* listen_select_img_path = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(listen_select_img.frame), CGRectGetMinY(listen_select_img.frame), CGRectGetWidth(listen_select_img.frame), CGRectGetHeight(listen_select_img.frame))];
    
    UIBezierPath* listen_select_word_path = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(listen_select_word.frame), CGRectGetMinY(listen_select_word.frame), CGRectGetWidth(listen_select_word.frame), CGRectGetHeight(listen_select_word.frame))];
    
    UIBezierPath* listen_type_word_path = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(listen_type_word.frame), CGRectGetMinY(listen_type_word.frame), CGRectGetWidth(listen_type_word.frame), CGRectGetHeight(listen_type_word.frame))];
    
    UIBezierPath* fill_one = [UIBezierPath bezierPathWithRect:CGRectMake(0, CGRectGetMinY(listen_select_img.frame) + CGRectGetHeight(listen_select_img.frame), self.textView.frame.size.width, 25)];
    
    UIBezierPath* fill_two = [UIBezierPath bezierPathWithRect:CGRectMake(0, CGRectGetMinY(listen_select_word.frame) + CGRectGetHeight(listen_select_word.frame), self.textView.frame.size.width, 12.5)];
    self.textView.textContainer.exclusionPaths = @[listen_select_img_path, listen_select_word_path, listen_type_word_path, fill_one, fill_two];
    
    
    [[self textView] addSubview: listen_select_img];
    [[self textView] addSubview: listen_select_word];
    [[self textView] addSubview: listen_type_word];
    
    NSMutableAttributedString* text = [[NSMutableAttributedString alloc] initWithString:self.textView.text];
    self.textView.attributedText = [MLPlatform parseBBCodes:text withFontSize:self.textView.font.pointSize];
    self.textView.dataDetectorTypes = UIDataDetectorTypeLink;
    self.textView.selectable = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end