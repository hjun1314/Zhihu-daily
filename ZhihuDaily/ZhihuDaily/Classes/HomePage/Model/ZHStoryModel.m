//
//  ZHStoryModel.m
//  ZhihuDaily
//
//  Created by hjun on 2018/3/22.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "ZHStoryModel.h"

@implementation ZHStoryModel

@synthesize id = _id;
+ (NSDictionary *)mj_objectClassInArray{
    
        return @{@"stories" : [ZHStoryModel class],
    //             @"top_stories" : [ZHStoryModel class],
                 };
    }
@end

//@implementation SectionModel
//
//+ (NSDictionary *)mj_objectClassInArray{
//
//    return @{@"stories" : [ZHStoryModel class],
////             @"top_stories" : [ZHStoryModel class],
//             };
//}

//@end
