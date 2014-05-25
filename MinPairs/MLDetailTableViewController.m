//
//  MLDetailTableViewController.m
//  MinPairs
//
//  Created by Oleksiy Martynov on 5/24/14.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLDetailTableViewController.h"
#import "MLDetailsItem.h"
#import "MLDetailTableCellTypeOne.h"
#import "MLDetailTableCellTypeTwo.h"
#import "MLDetailTableCellTypeThree.h"
@interface MLDetailTableViewController ()
@property NSMutableArray* cellDataArr;
@end

@implementation MLDetailTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.cellDataArr=[NSMutableArray array];
    for(int i=0; i<self.array.count;i++)
    {
        MLDetailsItem* item = [self.array objectAtIndex:i];
        if(item.detailCorrect==false)
        {
            [self.cellDataArr addObject:item];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.cellDataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //available reuseItentifiers: detailCellTypeOne, detailCellTypeTwo, detailCellTypeTree
    MLDetailsItem* item=[self.cellDataArr objectAtIndex:indexPath.row];
    UITableViewCell *cell;
    switch (item.detailType) {
        case DETAIL_TYPE_ONE:
        {
           MLDetailTableCellTypeOne* tempCell = [tableView dequeueReusableCellWithIdentifier:@"detailCellTypeOne" forIndexPath:indexPath];
            [tempCell setData:item.detailNumber :item.correctItem :item.userItem];
            cell = tempCell;
            break;
        }
            
        case DETAIL_TYPE_TWO:
        {
            MLDetailTableCellTypeTwo* tempCell = [tableView dequeueReusableCellWithIdentifier:@"detailCellTypeTwo" forIndexPath:indexPath];
            [tempCell setData:item.detailNumber:item.correctItem :item.userItem];
            cell = tempCell;
            break;
        }
            
        case DETAIL_TYPE_THREE:
        {
            MLDetailTableCellTypeThree* tempCell = [tableView dequeueReusableCellWithIdentifier:@"detailCellTypeThree" forIndexPath:indexPath];
            [tempCell setData:item.detailNumber :item.correctItem :item.userItem];
            cell = tempCell;
            break;
        }
        default:
            NSLog(@"unknown detail type");
            break;
    }
    
    
    
    return cell;
}
- (IBAction)onDoneBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
