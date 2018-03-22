//
//  ZHStoryModelTool.h
//  ZhihuDaily
//
//  Created by hjun on 2018/3/22.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^CallBack)(id obj);
@interface ZHStoryModelTool : NSObject
//加载最新数据
- (void)loadNewStoriesWithCallBack:(CallBack)callBack;
@end
