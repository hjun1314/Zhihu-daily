//
//  ZHHeadView.h
//  ZhihuDaily
//
//  Created by hjun on 2018/3/28.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHStoryModel;
@interface ZHHeadView : UITableViewHeaderFooterView
@property (nonatomic,copy) NSString *date;
+ (instancetype)HomeHeaderViewWithTableView:(UITableView *)tableView;

@end
