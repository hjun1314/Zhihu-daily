//
//  ZHThemeModel.h
//  ZhihuDaily
//
//  Created by hjun on 2018/3/22.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHThemeModel : NSObject
/** thumbnail  图片地址*/
@property (nonatomic, copy) NSString *thumbnail;

/** id  编号*/
@property (nonatomic, copy) NSNumber *id;

/** name  名称*/
@property (nonatomic, copy) NSString *name;
@end
