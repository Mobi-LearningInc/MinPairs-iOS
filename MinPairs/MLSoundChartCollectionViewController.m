//
//  MLSoundChartCollectionViewController.m
//  MinPairs
//
//  Created by Oleksiy Martynov on 4/24/14.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLSoundChartCollectionViewController.h"
#import "MLMainDataProvider.h"
#import "MLSoundChartCollectionViewCell.h"
#import "MLBasicAudioPlayer.h"
@interface MLSoundChartCollectionViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property NSArray* catArr;
@property (nonatomic, strong) MLBasicAudioPlayer* audioPlayer;
@end

@implementation MLSoundChartCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)onLoadStart
{
    NSLog(@"started");
    [self.loadingIndicator startAnimating];
    [self.loadingIndicator setHidesWhenStopped:YES];
}
-(void)onLoadFinish
{
    NSLog(@"finished");
    [self.loadingIndicator stopAnimating];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    MLMainDataProvider* dataProvider=[[MLMainDataProvider alloc]initMainProvider];
    self.catArr =[dataProvider getCategoriesCallListener:self];
    self.audioPlayer = [[MLBasicAudioPlayer alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Collection View Data Sources

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.catArr count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MLSoundChartCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"soundChartCellIdentifier" forIndexPath:indexPath];
    [cell setCellCategory:[self.catArr objectAtIndex:indexPath.row]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MLCategory* selectedCategory = [self.catArr objectAtIndex:indexPath.row];
    NSLog(@"sound selected %@",selectedCategory.categoryAudioFile);
    [self.audioPlayer loadFileFromResource:selectedCategory.categoryAudioFile withExtension: @"mp3"];
    //[self.audioPlayer loadFileFromResource:selectedCategory.categoryAudioFile withExtension:@"mp3"]; throws an exception
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
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
