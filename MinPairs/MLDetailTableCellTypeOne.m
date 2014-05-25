//
//  MLDetailTableCellTypeOne.m
//  MinPairs
//
//  Created by Oleksiy Martynov on 5/24/14.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLDetailTableCellTypeOne.h"
#import "MLBasicAudioPlayer.h"
@interface MLDetailTableCellTypeOne()
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewLeft;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewRight;
@property (strong, nonatomic) MLItem* correctItem;
@property (strong,nonatomic)MLBasicAudioPlayer* audioPlayer;
@end

@implementation MLDetailTableCellTypeOne

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (IBAction)onListenBtn:(id)sender
{
    [self playItem:self.correctItem];
}
-(void)setData:(int)index : (MLItem*)correctItem : (MLItem*) wrongItem
{
    self.audioPlayer=[[MLBasicAudioPlayer alloc]init];
    self.indexLabel.text=[NSString stringWithFormat:@"#%i",index];
    UIImage* imgLeft =[UIImage imageNamed:correctItem.itemImageFile];
    if(imgLeft)
    {
        self.imgViewLeft.image=imgLeft;
    }
    UIImage* imgRight =[UIImage imageNamed:wrongItem.itemImageFile];
    if(imgRight)
    {
        self.imgViewRight.image=imgRight;
    }
    self.correctItem=correctItem;
}
-(void)playItem:(MLItem*)item
{
    
    [self.audioPlayer loadFileFromResource:item.itemAudioFile withExtension: @"mp3"];
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
