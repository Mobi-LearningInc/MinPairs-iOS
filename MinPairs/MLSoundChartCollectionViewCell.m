//
//  MLSoundChartCollectionViewCell.m
//  MinPairs
//
//  Created by Oleksiy Martynov on 4/24/14.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLSoundChartCollectionViewCell.h"

@interface MLSoundChartCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *soundLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) MLCategory* category;

@end
@implementation MLSoundChartCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setCellCategory:(MLCategory*)category
{
    self.category=category;
    self.soundLabel.text=category.categoryDescription;
    UIImage *image = [UIImage imageNamed: category.categoryImageFile];
    if(!image)
    {
        image = [UIImage imageNamed:SOUND_CHART_CELL_DEFAULT_IMAGE];
    }
    [self.imageView setImage:image];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
