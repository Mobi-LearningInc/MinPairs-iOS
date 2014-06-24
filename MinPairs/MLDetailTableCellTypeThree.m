//
//  MLDetailTableCellTypeThree.m
//  MinPairs
//
//  Created by Oleksiy Martynov on 5/24/14.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLDetailTableCellTypeThree.h"
#import "MLBasicAudioPlayer.h"
@interface MLDetailTableCellTypeThree()

@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *readLabel;
@property (strong, nonatomic) MLItem* correctItem;
@property (strong, nonatomic) MLItem* wrongItem;
@property (strong,nonatomic)MLBasicAudioPlayer* audioPlayer;

@end
@implementation MLDetailTableCellTypeThree

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (IBAction)onListenLeft:(id)sender
{
    [self playItem:self.correctItem];
}
- (IBAction)onListenRight:(id)sender
{
    [self playItem:self.wrongItem];
}
-(void)setData:(int)index : (MLItem*)correctItem : (MLItem*) wrongItem
{
    self.audioPlayer=[[MLBasicAudioPlayer alloc]init];
    self.indexLabel.text=[NSString stringWithFormat:@"#%i",index];
    self.correctItem=correctItem;
    self.wrongItem=wrongItem;
    self.readLabel.text=correctItem.itemDescription;
}
-(void)playItem:(MLItem*)item
{
    
    [self.audioPlayer loadFileFromResource:item.itemAudioFile withExtension: @"mp3"];
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
