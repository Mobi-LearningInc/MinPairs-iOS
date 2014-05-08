//
//  MLLearnTableViewController.m
//  MinPairs
//
//  Created by Oleksiy Martynov on 5/1/14.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLLearnTableViewController.h"
#import "MLLearnTableViewCell.h"
#import "MLMainDataProvider.h"
#import "MLSettingDatabase.h"

@interface MLLearnTableViewController() <UISearchDisplayDelegate, UISearchBarDelegate>
@property NSArray* learnPairsArr;
@property (strong, nonatomic) NSArray* searchResults;
@end

@implementation MLLearnTableViewController

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

    MLMainDataProvider* dataPro=[[MLMainDataProvider alloc]initMainProvider];
    MLSettingDatabase* settingDb=[[MLSettingDatabase alloc]initSettingDatabase];
    MLSettingsData* setting=[settingDb getSetting];
    MLPair* filterCatPair =setting.settingFilterCatPair;
    MLCategory* filterCatLeft=filterCatPair.first;
    MLCategory* filterCatRight=filterCatPair.second;
    self.title =[NSString stringWithFormat:@"Learn %@ vs %@",filterCatLeft.categoryDescription,filterCatRight.categoryDescription];
    NSArray* pairPairArr = [dataPro getPairs];
    NSMutableArray* filteredArr = [NSMutableArray array];
    for (int i=0; i<pairPairArr.count; i++)
    {
        MLPair* p=[pairPairArr objectAtIndex:i];
        MLPair * pl=p.first;
        MLPair* pr = p.second;
        MLCategory * cl = pl.first;
        MLItem* il = pl.second;
        MLCategory * cr=pr.first;
        MLItem* ir=pr.second;
        if (filterCatLeft.categoryId==0)//filter is set to 'all'
        {
            [filteredArr addObject:[[MLPair alloc]initPairWithFirstObject:il secondObject:ir]];
        }
        else
        {
            if ((filterCatLeft.categoryId==cl.categoryId&&filterCatRight.categoryId==cr.categoryId)||(filterCatLeft.categoryId==cr.categoryId&&filterCatRight.categoryId==cl.categoryId))
            {
                [filteredArr addObject:[[MLPair alloc]initPairWithFirstObject:il secondObject:ir]];
            }
        }
    }
    
    self.learnPairsArr = filteredArr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

/** Filters the category array and stores the results in searchResults array. **/
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate* resultPredicate = [NSPredicate predicateWithFormat:@"(SELF.%K.itemDescription contains[cd] %@) OR (SELF.%K.itemDescription contains[cd] %@)", @"first", searchText, @"second", searchText];
    self.searchResults = [self.learnPairsArr filteredArrayUsingPredicate:resultPredicate];
}

/** When the user types something. Called whenever the search string changes. **/
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.searchResults count];
    }
    return self.learnPairsArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MLLearnTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"LearnCell" forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[MLLearnTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LearnCell"];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        MLPair* itemPair = [self.searchResults objectAtIndex:indexPath.row];
        [cell setCellItemPair: itemPair];
    }
    else
    {
        MLPair* itemPair = [self.learnPairsArr objectAtIndex:indexPath.row];
        [cell setCellItemPair:itemPair];
    }
    
    return cell;
}

@end
