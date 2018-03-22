//
//  ZHThemeTool.m
//  ZhihuDaily
//
//  Created by hjun on 2018/3/22.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "ZHThemeTool.h"
#import "ZHThemeModel.h"
#import "MJExtension.h"

@implementation ZHThemeTool

+ (void)getThemeWithSuccessfulblock:(successful)successful{
    [[UPSHttpNetWorkTool sharedApi]GET:@"http://news-at.zhihu.com/api/4/themes" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [NSArray array];
        array = [ZHThemeModel mj_objectArrayWithKeyValuesArray:responseObject[@"others"]];
        successful(array);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

@end
