//
//  ZHHomePageCell.h
//  ZhihuDaily
//
//  Created by hjun on 2018/3/23.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHStoryModel.h"
@interface ZHHomePageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *homeView;
@property (nonatomic,strong)ZHStoryModel *story;

@end
