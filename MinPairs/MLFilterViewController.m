//
//  MLFilterViewController.m
//  MinPairs
//
//  Created by Brandon on 2014-04-26.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLFilterViewController.h"

@interface MLFilterViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, weak) NSMutableArray* leftSide;
@property (nonatomic, assign) bool chosen;
@end

@implementation MLFilterViewController

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
    
    self.chosen = false;
    self.leftSide = [MLSynchronousFilter getCategoriesLeft];
    
    //self.view.transform = CGAffineTransformMakeScale(1, 2);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[self leftSide] count];
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
            return [[[self leftSide] objectAtIndex: row] categoryDescription];
            
        case 1:
            if ([self chosen])
            {
                NSMutableArray* cat = [MLSynchronousFilter getCorrespondingCategories: [[self leftSide] objectAtIndex: row]];
                self.chosen = false;
                return [[cat objectAtIndex: 0] categoryDescription];
            }
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch(component)
    {
        case 0: self.chosen = true; [pickerView reloadComponent: 1];
    }
}

 - (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
 {
     return self.view.frame.size.width / 2;
 }
 
 - (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
 {
     return 50;
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
