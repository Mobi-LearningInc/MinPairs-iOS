//
//  MLStatisticsViewController.m
//  MinPairs
//
//  Created by Brandon on 2014-04-26.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLStatisticsViewController.h"

@interface MLStatisticsViewController ()
@property (nonatomic, strong) UIView* dropDown;
@property (nonatomic, strong) UIDatePicker* date_picker;
@property (nonatomic, strong) NSDate* minDate;
@property (nonatomic, strong) NSDate* maxDate;
@property (nonatomic, strong) NSDateFormatter* formatter;
@property (nonatomic, assign) bool dropDownFinished;
@end

@implementation MLStatisticsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

-(void)animate:(UIView*)view withOffset:(float)offset withCompletion:(void(^)(BOOL finished))completion_func
{
    [UIView animateWithDuration: 0.7f animations: ^{
        CGRect rect = [view frame];
        rect.size.height = offset;
        view.frame = rect;
    } completion: completion_func];
}

-(UIDatePicker*)allocDatePicker
{
    UIView* view = [self dropDown];
    UIDatePicker* date_picker = [[UIDatePicker alloc] init];
    CGRect date_bounds = CGRectMake(0, view.frame.size.height - 162.0f, [date_picker sizeThatFits: CGSizeZero].width, 162.0f);
    [date_picker setAutoresizingMask: UIViewAutoresizingFlexibleWidth];
    [date_picker setDatePickerMode: UIDatePickerModeDate];
    [date_picker setFrame: date_bounds];
    [date_picker setBackgroundColor: [UIColor grayColor]];
    
    [date_picker setMinimumDate: nil];
    [date_picker setMaximumDate: nil];
    [date_picker setDatePickerMode: UIDatePickerModeDate];
    return date_picker;
}

-(void)addDropDownControls
{
    UIView* view = [self dropDown];
    
    /** Calculate offsets **/
    
    CGFloat padding = 8.0f;
    CGFloat x = view.frame.origin.x + padding;
    CGFloat y = view.frame.origin.y + padding;
    CGFloat width = view.frame.size.width - (padding * 2.0f); //8 padding on the left and right.
    CGFloat height = [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f ? 30.0f : 50.0f;
    
    
    /** Create start-date label, field and button **/
    
    UILabel* start_label = [[UILabel alloc] initWithFrame: CGRectMake(x, y, width, 30.0f)];
    UITextField* start_field = [[UITextField alloc] initWithFrame: CGRectMake(x, y += padding + 30.0f, (width / 1.5f) - (2 * padding), 30.0f)];
    UIButton* start_button = [[UIButton alloc] initWithFrame: CGRectMake(start_field.frame.size.width + (padding * 2), start_field.frame.origin.y, 30.0f, 30.0f)];
    
    
    /** Create end-date label, field and button **/
    
    y += 50.0f;
    UILabel* end_label = [[UILabel alloc] initWithFrame: CGRectMake(x, y += padding + 30.0f, width, 30.0f)];
    UITextField* end_field = [[UITextField alloc] initWithFrame: CGRectMake(x, y += padding + 30.0f, (width / 1.5f) - (2 * padding), 30.0f)];
    UIButton* end_button = [[UIButton alloc] initWithFrame: CGRectMake(end_field.frame.size.width + (padding * 2), end_field.frame.origin.y, 30.0f, 30.0f)];
    
    
    /** Create Finish button **/
    
    UIButton* ok_button = [[UIButton alloc] initWithFrame: CGRectMake(x, view.frame.size.height - height - padding, width, height)];
    
    
    UIColor* okBtnTitleColour = [UIColor whiteColor];
    UIColor* fieldBtnTitleColour = [UIColor whiteColor];
    UIColor* okBtnBgColour = [UIColor colorWithRed: 99.0f/0xFF green: 116.0f/0xFF blue: 1.0f alpha:1];
    UIColor* fieldBtnBgColour = [UIColor colorWithRed: 99.0f/0xFF green: 116.0f/0xFF blue: 1.0f alpha:1];
    
    [start_field setBorderStyle: UITextBorderStyleBezel];
    [end_field setBorderStyle: UITextBorderStyleBezel];
    [start_field setEnabled: false];
    [end_field setEnabled: false];
    
    
    [start_button setTag: 1];
    [start_button setBackgroundColor: fieldBtnBgColour];
    [start_button setTitleColor: fieldBtnTitleColour forState: UIControlStateNormal];
    [start_button setTitle: @"..." forState: UIControlStateNormal];
    [start_button addTarget:self action:@selector(onDropdownSelection:) forControlEvents: UIControlEventTouchUpInside];
    
    
    [end_button setTag: 2];
    [end_button setBackgroundColor: fieldBtnBgColour];
    [end_button setTitleColor: fieldBtnTitleColour forState: UIControlStateNormal];
    [end_button setTitle: @"..." forState: UIControlStateNormal];
    [end_button addTarget:self action:@selector(onDropdownSelection:) forControlEvents: UIControlEventTouchUpInside];
    
    
    [ok_button setTag: 3];
    [ok_button setTitle: @"Finished" forState: UIControlStateNormal];
    [ok_button setTitleColor: okBtnTitleColour forState: UIControlStateNormal];
    [ok_button setBackgroundColor: okBtnBgColour];
    [ok_button addTarget:self action:@selector(onDropdownSelection:) forControlEvents: UIControlEventTouchUpInside];
    

    [start_field setText: [[self formatter] stringFromDate: [self minDate]]];
    [end_field setText: [[self formatter] stringFromDate: [self maxDate]]];
    
    
    [start_label setText: @"Start Date:"];
    [end_label setText: @"End Date:"];
    [start_field setTag: 4];
    [end_field setTag: 5];

    [[self dropDown] addSubview: start_label];
    [[self dropDown] addSubview: start_field];
    [[self dropDown] addSubview: start_button];
    [[self dropDown] addSubview: end_label];
    [[self dropDown] addSubview: end_field];
    [[self dropDown] addSubview: end_button];
    [[self dropDown] addSubview: ok_button];
}

-(void)initDropDown
{
    CGRect frame = [[self view] frame];
    frame.size.height = 0;
    
    self.dropDown = [[UIView alloc] initWithFrame: frame];
    [[self dropDown] setBackgroundColor: [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.9f]];
    
    [[self view] addSubview: [self dropDown]];
    [self animate: [self dropDown] withOffset: self.view.frame.size.height withCompletion: nil];
    [self addDropDownControls];
    
    self.date_picker = [self allocDatePicker];
}

-(void)destroyDropDown
{
    for (UIView* view in [[self dropDown] subviews])
    {
        [view removeFromSuperview];
    }
    
    [self animate: [self dropDown] withOffset: 0 withCompletion: ^(BOOL finished){
        if (finished)
        {
            [[self dropDown] removeFromSuperview];
            self.dropDown = nil;
            self.dropDown = nil;
        }
    }];
}

- (IBAction)onDropdownSelection:(UIButton*)sender
{
    static float btn_width = 0;
    UIButton* start_btn = (UIButton*)[[self dropDown] viewWithTag: 1];
    UIButton* end_btn = (UIButton*)[[self dropDown] viewWithTag: 2];
    
    UITextField* start_field = (UITextField*)[[self dropDown] viewWithTag: 4];
    UITextField* end_field = (UITextField*)[[self dropDown] viewWithTag: 5];
    
    switch ([sender tag])
    {
        case 1:
        {
            if ([[start_btn currentTitle] isEqualToString: @"..."])
            {
                NSDate* date = [[self formatter] dateFromString: [start_field text]];
                
                [[self date_picker] setMinimumDate: [self minDate]];
                [[self date_picker] setMaximumDate: [self maxDate]];
                [[self date_picker] setDate: date];
                
                [[self dropDown] addSubview: [self date_picker]];
                [start_btn setTitle: @"done" forState: UIControlStateNormal];
                [end_btn setEnabled: false];
                
                CGRect frame = start_btn.frame;
                btn_width = frame.size.width;
                frame.size.width = 50.0f;
                start_btn.frame = frame;
            }
            else
            {
                CGRect frame = start_btn.frame;
                frame.size.width = btn_width;
                start_btn.frame = frame;
                
                [end_btn setEnabled: true];
                [start_btn setTitle: @"..." forState: UIControlStateNormal];
                [[self date_picker] removeFromSuperview];
                
                NSDate* date = [[self date_picker] date];
                [start_field setText: [[self formatter] stringFromDate: date]];
                
                if ([date compare: [[self formatter] dateFromString: [end_field text]]] == NSOrderedDescending)
                {
                    [end_field setText: [[self formatter] stringFromDate: date]];
                }
            }
        }
        break;
            
        case 2:
        {
            if ([[end_btn currentTitle] isEqualToString: @"..."])
            {
                NSDate* date = [[self formatter] dateFromString: [start_field text]];
                
                [[self date_picker] setMinimumDate: date];
                [[self date_picker] setMaximumDate: [self maxDate]];
                [[self date_picker] setDate: [[self formatter] dateFromString: [end_field text]]];
                [[self dropDown] addSubview: [self date_picker]];
                [end_btn setTitle: @"done" forState: UIControlStateNormal];
                [start_btn setEnabled: false];
                
                CGRect frame = end_btn.frame;
                btn_width = frame.size.width;
                frame.size.width = 50.0f;
                end_btn.frame = frame;
            }
            else
            {
                CGRect frame = end_btn.frame;
                frame.size.width = btn_width;
                end_btn.frame = frame;
                
                [start_btn setEnabled: true];
                [end_btn setTitle: @"..." forState: UIControlStateNormal];
                [[self date_picker] removeFromSuperview];
                
                NSDate* date = [[self date_picker] date];
                [end_field setText: [[self formatter] stringFromDate: date]];
            }
        }
        break;
            
        case 3:
        {
            self.minDate = [[self formatter] dateFromString: [start_field text]];
            self.maxDate = [[self formatter] dateFromString: [end_field text]];
            
            self.dropDownFinished = true;
            [self destroyDropDown];
        }
        break;
            
        default:
            break;
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [[self dropDown] removeFromSuperview];
    
    
    for (UIView* view in [[self view] subviews])
    {
        [view setNeedsDisplay];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if (![self dropDownFinished])
    {
        [self initDropDown];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /** Create fake date for testing -- TODO: get dates from the database. **/
    
    self.formatter = [[NSDateFormatter alloc] init];
    [[self formatter] setDateFormat: @"MM/dd/yyyy"];
    self.minDate = [[self formatter] dateFromString: @"01/01/1990"];
    self.maxDate = [[self formatter] dateFromString: @"12/31/2014"];
    
    [self initDropDown];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [[self navigationController] setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [[self navigationController] setNavigationBarHidden:NO];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
