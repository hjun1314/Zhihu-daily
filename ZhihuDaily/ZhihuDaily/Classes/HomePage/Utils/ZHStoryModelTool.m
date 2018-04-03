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
#import "ZHTopStoryModel.h"
@interface ZHStoryModelTool()
@property (nonatomic,strong)NSMutableArray *items;

@end

@implementation ZHStoryModelTool
- (void)loadNewStoriesWithCallBack:(CallBack)callBack{
    [[UPSHttpNetWorkTool sharedApi]GET:@"http://news-at.zhihu.com/api/4/news/latest" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        SectionModel *sectionM = [SectionModel mj_objectWithKeyValues:responseObject];
//        [self.items addObject:sectionM];
//        objc_setAssociatedObject([self class], @selector(items), sectionM.date, OBJC_ASSOCIATION_COPY_NONATOMIC);
        callBack(_items);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

//加载当天数据
- (void)loadNowStoriesWithUpdateBack:(updataBack)updataBack{
    [[UPSHttpNetWorkTool sharedApi]GET:@"http://news-at.zhihu.com/api/4/news/latest" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        SectionModel *sectionM = [SectionModel mj_objectWithKeyValues:responseObject];
        updataBack(self.items);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
//加载之前数据
- (void)loadBeforeStoriesWithUpdateBack:(updataBack)updataBack{
    id date = objc_getAssociatedObject([self class], @selector(items));
    NSString *url = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/news/before/%@",date];
    [[UPSHttpNetWorkTool sharedApi]GET:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        SectionModel *sectionM = [SectionModel mj_objectWithKeyValues:responseObject];
//        [self.items addObject:sectionM];
//        objc_setAssociatedObject([self class], @selector(items), sectionM.date, OBJC_ASSOCIATION_COPY_NONATOMIC);
        updataBack(_items);

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (NSMutableArray *)items{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)newslatest:(void(^)(BOOL neesToLoad))completion{
    [[UPSHttpNetWorkTool sharedApi]GET:@"http://news-at.zhihu.com/api/4/news/latest" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        BOOL needsToReload = false;

        self.topStories = responseObject[@"top_stories"];
        self.stories = responseObject[@"stories"];
        self.date = responseObject[@"date"];
        if (completion != nil) {
            completion(needsToReload);
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)newsBefore:(NSString *)date completion:(void(^)(void))completion{
    NSString *url = [NSString stringWithFormat:@"http://news.at.zhihu.com/api/4/news/before/%@",date];
    [[UPSHttpNetWorkTool sharedApi]GET:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

@end
