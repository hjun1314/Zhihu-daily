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
#import "ZHTopStoryModel.h"
#import "ZHHomePageCell.h"
#import "UIImageView+WebCache.h"
@interface ZHHomePagecController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
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
}
- (void)loadSDcycleViewData{
    [[UPSHttpNetWorkTool sharedApi]GET:@"http://news-at.zhihu.com/api/4/news/latest" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *topArr = responseObject[@"top_stories"];
        NSMutableArray *topData = [NSMutableArray array];
        NSMutableArray *themeArr = [NSMutableArray array];
        for (int i = 0; i < topArr.count; i++) {
            ZHTopStoryModel *model = [ZHTopStoryModel mj_objectWithKeyValues:topArr[i]];
            [topData addObject:model.image];
            [themeArr addObject:model.title];
        }
        NSMutableArray *storyArr = responseObject[@"stories"];
        NSMutableArray *storyData = [NSMutableArray array];
        for (int i = 0 ; i < storyArr.count; i++) {
            ZHStoryModel *model = [ZHStoryModel mj_objectWithKeyValues:storyArr[i]];
            [storyData addObject:model];
        }
        self.items = storyData;
        [self loadSdcycleViewImageArr:topData andTitleLabelArr:themeArr];
        [self.tableView reloadData];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark- 加载轮播图
- (void)loadSdcycleViewImageArr:(NSMutableArray *)imageArr andTitleLabelArr:(NSMutableArray *)titleLabelArr{
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT *0.3) delegate:self placeholderImage:[UIImage imageNamed:@"Comment_Share_Sina"]];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    
    cycleScrollView.localizationImageNamesGroup = imageArr;
    cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    cycleScrollView.titleLabelHeight = 80;
    cycleScrollView.titleLabelTextFont = [UIFont systemFontOfSize:16];
    cycleScrollView.titleLabelTextColor = [UIColor whiteColor];
    cycleScrollView.titleLabelBackgroundColor = [UIColor clearColor];
    cycleScrollView.titleLabelTextAlignment = NSTextAlignmentLeft;
    cycleScrollView.titlesGroup = titleLabelArr;
    self.tableView.tableHeaderView = cycleScrollView;
    
    
}
#pragma mark- tableViewDelegate&DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZHHomePageCell" owner:nil options:nil]lastObject];
    }
    ZHStoryModel *model = self.items[indexPath.row];
    cell.titleLabel.text = model.title;
    NSURL *url = [NSURL URLWithString:model.images[0]];
    [cell.iconView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"News_Avatar"]];
    cell.homeView.hidden = !model.isMutipic;
    
    return cell;
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    DLog(@"%ld",index);
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -kStatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 100;
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
