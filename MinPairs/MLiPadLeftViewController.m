//
//  MLiPadLeftViewController.m
//  MinPairs
//
//  Created by Brandon on 2014-04-29.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLiPadLeftViewController.h"

@interface MLiPadLeftViewController ()
@property (nonatomic, strong) NSArray* Menu;
@end

@implementation MLiPadLeftViewController

-(NSArray*)Menu
{
    if (!_Menu)
    {
        _Menu = [[NSArray alloc] initWithObjects:@"Sound Chart", @"Learn", @"Practice", @"Quizzes", @"Statistics", @"Settings", @"Filter", nil];
    }
    return _Menu;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"LeftCellID" forIndexPath:indexPath];
    cell.textLabel.text = [[self Menu]  objectAtIndex: indexPath.row];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
