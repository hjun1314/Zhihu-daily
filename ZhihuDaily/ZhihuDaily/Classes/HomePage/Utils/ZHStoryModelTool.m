//
//  ZHStoryModelTool.m
//  ZhihuDaily
//
//  Created by hjun on 2018/3/22.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "ZHStoryModelTool.h"
#import "UPSHttpNetWorkTool.h"
#import "MJExtension.h"
#import "ZHStoryModel.h"
@interface ZHStoryModelTool()
@property (nonatomic,strong)NSMutableArray *items;

@end

@implementation ZHStoryModelTool
- (void)loadNewStoriesWithCallBack:(CallBack)callBack{
    [[UPSHttpNetWorkTool sharedApi]GET:@"http://news-at.zhihu.com/api/4/news/latest" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        SectionModel *sectionM = [SectionModel mj_objectWithKeyValues:responseObject];
        [self.items addObject:sectionM];
        
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

@end
