//
//  ZHStoryModelTool.h
//  ZhihuDaily
//
//  Created by hjun on 2018/3/22.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZHStoryModel;
typedef void(^CallBack)(id obj);
typedef void (^updataBack)(id obj);
@interface ZHStoryModelTool : NSObject

@property (strong, nonatomic) NSMutableArray<ZHStoryModel*>* topStories;
@property (strong, nonatomic) NSString* date;
@property (strong, nonatomic) NSArray* stories;
@property (assign, nonatomic) BOOL isRequesting;

//加载最新数据(头部轮播图)
- (void)loadNewStoriesWithCallBack:(CallBack)callBack;
//加载当天数据
- (void)loadNowStoriesWithUpdateBack:(updataBack)updataBack;
//加载之前数据
- (void)loadBeforeStoriesWithUpdateBack:(updataBack)updataBack;
- (void)newslatest:(void(^)(BOOL neesToLoad))completion;
- (void)newsBefore:(NSString *)date completion:(void(^)(void))completion;
@end
