//
//  ZHHeadView.m
//  ZhihuDaily
//
//  Created by hjun on 2018/3/28.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "ZHHeadView.h"

@implementation ZHHeadView
+ (instancetype)HomeHeaderViewWithTableView:(UITableView *)tableView{
    static NSString *headerID = @"homeHeader";
    ZHHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    if (!headView) {
        headView = [[ZHHeadView alloc]init];
        headView.contentView.backgroundColor = RGBA(23, 144, 21, 1);
    }
    return headView;
}
//必须在layoutsubviews 里边写
- (void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.centerX = self.centerX;
}

- (void)setDate:(NSString *)date{
    _date = date;
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
    [dataFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *dateStr = [dataFormatter dateFromString:date];
    [dataFormatter setDateFormat:@"MM月dd日 EEEE"];
    _date = [dataFormatter stringFromDate:dateStr];
    self.textLabel.attributedText = [[NSAttributedString alloc]
                                     initWithString:_date
                                     attributes:
                                     @{NSFontAttributeName:
                                           [UIFont systemFontOfSize:18] ,
                                       NSForegroundColorAttributeName:
                                           [UIColor whiteColor]}];
    
    
    
}

@end
