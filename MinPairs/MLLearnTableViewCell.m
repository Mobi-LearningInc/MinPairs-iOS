//
//  MLLearnTableViewCell.m
//  MinPairs
//
//  Created by Oleksiy Martynov on 5/1/14.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLLearnTableViewCell.h"
#import "MLItem.h"
#import "MLBasicAudioPlayer.h"
@interface MLLearnTableViewCell()
@property (weak, nonatomic) IBOutlet UIButton *btnLeft;
@property (strong,nonatomic) MLPair* itemPair;
@property (weak, nonatomic) IBOutlet UILabel *labelLeft;
@property (weak, nonatomic) IBOutlet UILabel *labelRight;
@property (weak, nonatomic) IBOutlet UIButton *btnRight;
@end
@implementation MLLearnTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}
-(void)setCellItemPair:(MLPair*)itemPair
{
    if(itemPair)
    {
    self.itemPair=itemPair;
    MLItem* itemLeft =itemPair.first;
    MLItem* itemRight = itemPair.second;
    self.labelLeft.text=itemLeft.itemDescription;
    self.labelRight.text=itemRight.itemDescription;
    UIImage* imgLeft = ![UIImage imageNamed:itemLeft.itemImageFile]?[UIImage imageNamed:@"na1.png"]:[UIImage imageNamed:itemLeft.itemImageFile];
    UIImage* imgRight=![UIImage imageNamed:itemRight.itemImageFile]?[UIImage imageNamed:@"na1.png"]:[UIImage imageNamed:itemRight.itemImageFile];
    [self.btnLeft setImage:imgLeft forState:UIControlStateNormal];
    [self.btnRight setImage:imgRight forState:UIControlStateNormal];
    }
}
- (IBAction)onLeftBtnTap:(id)sender
{
    [self playItem:self.itemPair.first];
}
- (IBAction)onRightBtnTap:(id)sender
{
    [self playItem:self.itemPair.second];
}
-(void)playItem:(MLItem*)item
{
    MLBasicAudioPlayer* audioPlayer = [[MLBasicAudioPlayer alloc]init];
    [audioPlayer loadFileFromResource:item.itemAudioFile withExtension: @"mp3"];
    [audioPlayer prepareToPlay];
    [audioPlayer play];
    NSLog(@"Played sound for %@",item.itemDescription);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
