//
//  ZHThemeTool.h
//  ZhihuDaily
//
//  Created by hjun on 2018/3/22.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^successful)(id obj);
@interface ZHThemeTool : NSObject

//获得主题日报

+ (void)getThemeWithSuccessfulblock:(successful)successful;

@end
