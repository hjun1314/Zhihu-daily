//
//  ZHTopStoryModel.m
//  ZhihuDaily
//
//  Created by hjun on 2018/3/23.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "ZHTopStoryModel.h"

@implementation ZHTopStoryModel
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{
             @"top_stories" : [ZHTopStoryModel class],
             };
}
@end
