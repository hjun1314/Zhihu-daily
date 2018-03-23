//
//  ZHHomePageCell.m
//  ZhihuDaily
//
//  Created by hjun on 2018/3/23.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "ZHHomePageCell.h"
#import "UIImageView+WebCache.h"
@implementation ZHHomePageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setStory:(ZHStoryModel *)story{
    _story = story;
    self.titleLabel.text = story.title;
    NSURL *url = [NSURL URLWithString:story.images[0]];
    [self.iconView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""]];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
