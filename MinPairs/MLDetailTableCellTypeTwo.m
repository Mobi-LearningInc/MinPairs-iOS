//
//  MLDetailTableCellTypeTwo.m
//  MinPairs
//
//  Created by Oleksiy Martynov on 5/24/14.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLDetailTableCellTypeTwo.h"
#import "MLBasicAudioPlayer.h"
@interface MLDetailTableCellTypeTwo()
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordLabelLeft;
@property (weak, nonatomic) IBOutlet UILabel *wordLabelRight;
@property (strong, nonatomic) MLItem* correctItem;
@property (strong,nonatomic)MLBasicAudioPlayer* audioPlayer;
@end
@implementation MLDetailTableCellTypeTwo

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
    self.wordLabelLeft.text=correctItem.itemDescription;
    self.wordLabelRight.text=wrongItem.itemDescription;
    self.correctItem=correctItem;
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
