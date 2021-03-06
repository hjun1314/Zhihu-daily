//
//  AppDelegate.h
//  ZhihuDaily
//
//  Created by hjun on 2018/1/24.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ZHMainController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

@property (nonatomic,strong)ZHMainController *main;


@end

