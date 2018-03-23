//
//  ZHTopStoryModel.h
//  ZhihuDaily
//
//  Created by hjun on 2018/3/23.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHTopStoryModel : NSObject
/** title 新闻标题 */
@property (nonatomic,copy) NSString *title;
/** images 图像地址 */
@property (nonatomic, strong) NSArray *images;
/** image  界面顶部的图片 */
@property (nonatomic, strong) NSString *image;
/** id  内容id */
@property (nonatomic, strong) NSNumber *id;
/** multipic   是否多图 */
@property (nonatomic, assign, getter=isMutipic) BOOL multipic;
@end
