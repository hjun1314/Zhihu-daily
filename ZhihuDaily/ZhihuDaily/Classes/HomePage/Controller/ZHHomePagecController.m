//
//  ZHHomePagecController.m
//  ZhihuDaily
//
//  Created by hjun on 2018/3/21.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "ZHHomePagecController.h"
#import <SDCycleScrollView.h>
#import "UPSHttpNetWorkTool.h"
#import "MJExtension.h"
#import "ZHStoryModel.h"
#import "AppDelegate.h"
#import "MMDrawerController.h"

@interface ZHHomePagecController ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *wheelView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,strong)UIView *navBar;

@property (nonatomic,strong)NSMutableArray *items;




@end

@implementation ZHHomePagecController




- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.navBar];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.leftBtn];
    [self loadSDcycleViewData];
    [self loadSdcycleView];
}
- (void)loadSDcycleViewData{
    [[UPSHttpNetWorkTool sharedApi]GET:@"http://news-at.zhihu.com/api/4/news/latest" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        SectionModel *sectionM = [SectionModel mj_objectWithKeyValues:responseObject];
        [self.items addObject:sectionM];
        
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark- 加载轮播图
- (void)loadSdcycleView{
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 200) delegate:self placeholderImage:[UIImage imageNamed:@"Comment_Share_Sina"]];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.localizationImageNamesGroup = @[@"Comment_Share_Sina_Cancel_Highlight",@"Comment_Share_Sina_Cancel",@"Comment_Share_Sina_Highlight"];
    cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    
    self.tableView.tableHeaderView = cycleScrollView;

   
    
}
#pragma mark 左侧按钮点击
- (void)clickLeftBtn{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
 [app.main toggleDrawerSide:MMDrawerSideLeft
animated:YES
completion:nil];
}
#pragma mark -- 懒加载

- (UITableView *)tableView{
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - 20) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        
    }
    return _tableView;
}
- (UIView *)navBar{
    if (_navBar == nil) {
        _navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kTopHeight)];
        _navBar.backgroundColor = RGBA(23, 144, 211, 1);
        _navBar.alpha = 0;
    }
    return _navBar;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.attributedText = [[NSAttributedString alloc]initWithString:@"今日新闻" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [_titleLabel sizeToFit];
        _titleLabel.centerX = self.view.centerX;
        if (iPhoneX) {
            _titleLabel.centerY = 65;
        }else{
            _titleLabel.centerY = 45;
        }
    }
    return _titleLabel;
}
- (UIButton *)leftBtn{
    if (_leftBtn == nil) {
        _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, kStatusBarHeight, 30, 30)];
        [_leftBtn setImage:[UIImage imageNamed:@"Home_Icon"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
