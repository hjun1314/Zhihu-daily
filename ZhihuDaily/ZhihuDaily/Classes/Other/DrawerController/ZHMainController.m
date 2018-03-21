//
//  ZHMainController.m
//  ZhihuDaily
//
//  Created by hjun on 2018/3/21.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "ZHMainController.h"
#import "ZHHomePagecController.h"
#import "ZHLeftController.h"
@interface ZHMainController ()

@end

@implementation ZHMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    ///设置状态栏字体颜色为白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    ZHHomePagecController *homePageVC = [[ZHHomePagecController alloc]init];
    homePageVC.view.backgroundColor = [UIColor redColor];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:homePageVC];
    self.nav = nav;
    nav.navigationBar.hidden = YES;
    
    ZHLeftController *leftVC = [[ZHLeftController alloc]init];
    leftVC.mainVC = self;
    
    self.centerViewController = nav;
    self.leftDrawerViewController = leftVC;
    [self setMaximumLeftDrawerWidth:220];
    [self setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [self setShouldStretchDrawer:NO];
    [self setShowsShadow:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
