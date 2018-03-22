//
//  ZHLeftTableViewCell.m
//  ZhihuDaily
//
//  Created by hjun on 2018/3/22.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "ZHLeftTableViewCell.h"
#import "ZHThemeModel.h"
@implementation ZHLeftTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = [UIColor clearColor];
        self.selectedBackgroundView = [[UIView alloc]initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = RGBA(31, 38, 46, 1);
        self.textLabel.textColor = RGBA(128, 133, 140, 1);
        self.textLabel.highlightedTextColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setTheme:(ZHThemeModel *)theme{
    _theme = theme;
    self.textLabel.text = theme.name;

}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
}


@end
