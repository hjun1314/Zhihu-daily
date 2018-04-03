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
#import "ZHStoryModelTool.h"
#import "ZHBeforeModel.h"
#import "ZHHeadView.h"
@interface ZHHomePagecController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *wheelView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,strong)UIView *navBar;

@property (nonatomic,strong)NSMutableArray *items;
@property (nonatomic,strong)NSMutableArray *beforeArr;
@property (nonatomic,strong)NSDate *dict;

@property (nonatomic,strong)ZHStoryModelTool *tool;
//@property (strong, nonatomic) NSMutableArray<ZHStoryModel*>* topStories;
//@property (strong, nonatomic) NSMutableDictionary* stories;
//@property (strong, nonatomic) NSMutableArray* dates;
//@property (assign, nonatomic) BOOL isRequesting;
//

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
    [self loadBeforeData];
//    [self loadLatestData];
}
- (void)setupTableViewData:(id)obj{
    self.items = obj;
//    SectionModel *model = self.items.firstObject;
    
}
#pragma mark- 加载顶部轮播和当天日报内容
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
        NSDictionary *dict = responseObject[@"date"];
//        self.dict = dict;
        [[NSUserDefaults standardUserDefaults]setObject:dict forKey:@"dict"];
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
#pragma mark- 加载昨天以前日报内容
- (void)loadBeforeData{
    NSDate *date;
    NSString *url = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/news/before/20180327"];
//    DLog(@"dict%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"dict"]);
    [[UPSHttpNetWorkTool sharedApi]GET:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *storyArr = responseObject[@"stories"];
        NSMutableArray *storyData = [NSMutableArray array];
        for (int i = 0 ; i < storyArr.count; i++) {
            ZHBeforeModel *model = [ZHBeforeModel mj_objectWithKeyValues:storyArr[i]];
            [storyData addObject:model];
        }
        self.beforeArr = storyData;
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
    cycleScrollView.titleLabelHeight = 60;
    cycleScrollView.titleLabelTextFont =  [UIFont fontWithName:@"STHeitSC-Medium" size:34];
    cycleScrollView.titleLabelTextColor = [UIColor whiteColor];
    cycleScrollView.titleLabelBackgroundColor = [UIColor clearColor];
    cycleScrollView.titleLabelTextAlignment = NSTextAlignmentLeft;
    cycleScrollView.titlesGroup = titleLabelArr;
    self.tableView.tableHeaderView = cycleScrollView;
    
    
}
#pragma mark- tableViewDelegate&DataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
//{
//    return self.stories.count;
//}
- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section
{
//    if (self.dates.count == 0)
//        return 0;
//
//    NSUInteger rowCountInSection = [self.stories[self.dates[section]] count];
//    return rowCountInSection;
    return self.items.count;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//   return  self.items.count + self.beforeArr.count;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZHHomePageCell" owner:nil options:nil]lastObject];
    }
    if (self.dict) {
        ZHBeforeModel *Smodel = self.beforeArr[indexPath.row];
                cell.titleLabel.text = Smodel.title;
                NSURL *url = [NSURL URLWithString:Smodel.images[0]];
                [cell.iconView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"News_Avatar"]];
                cell.homeView.hidden = !Smodel.isMutipic;
    }else{
        ZHStoryModel *model = self.items[indexPath.row];
               cell.titleLabel.text = model.title;
                    NSURL *url = [NSURL URLWithString:model.images[0]];
                    [cell.iconView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"News_Avatar"]];
                    cell.homeView.hidden = !model.isMutipic;
    }
//    ZHStoryModel* storiesOfADay =
//    self.stories[self.dates[indexPath.section]];
//                   cell.titleLabel.text = storiesOfADay.title;

//    cell.story = storiesOfADay[indexPath.row];

//    cell.textLabel.text = [NSString stringWithFormat:@"....%ld",(long)indexPath.row];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ZHHeadView *headView = [ZHHeadView HomeHeaderViewWithTableView:tableView];
//    ZHStoryModel *model = self.items[section];
//    headView.date = model.date;
    return headView;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    if (section == 0) {
        _navBar.height = kTopHeight;
        _titleLabel.alpha = 1;
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
    if (section == 0) {
        _navBar.height = 20;
        _titleLabel.alpha = 0;
    }
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

- (ZHStoryModelTool *)tool{
    if (_tool == nil) {
        _tool = [[ZHStoryModelTool alloc]init];
    }
    return _tool;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//- (NSDate*)stringToDate:(NSString*)dateString format:(NSString*)format
//{
//    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
//    dateFormatter.dateFormat = format;
//    return [dateFormatter dateFromString:dateString];
//}
//- (NSMutableDictionary*)stories
//{
//    if (_stories == nil) {
//        _stories = [NSMutableDictionary dictionary];
//    }
//    return _stories;
//}
//- (NSMutableArray*)dates
//{
//    if (_dates == nil) {
//        _dates = [NSMutableArray array];
//    }
//    return _dates;
//}
//- (void)loadLatestData
//{
//    if (self.isRequesting)
//    return;
//    self.isRequesting = true;
//    [self.tool newslatest:^(BOOL neesToLoad) {
//        if (!neesToLoad && self.topStories.count != 0)
//            return;
//        self.topStories = self.tool.topStories;
//        [self.stories setObject:self.tool.stories forKey:self.tool.date];
//        [self.dates addObject:self.tool.date];
//        [self loadSdcycleViewImageArr:self.topStories andTitleLabelArr:nil];
//        [self.tableView reloadData];
//        self.isRequesting = false;
//
//      }];
//}
//- (void)loadBeforeDatas{
//    if (self.isRequesting || self.topStories.count == 0)
//        return;
//    NSDate *beforeDate = [self stringToDate:self.dates.lastObject format:@"yyyyMMdd"];
//    if ([self.dates containsObject:[self dateString:beforeDate withFormat:@"yyyyMMdd"]]) {
//        return;
//    }
//    self.isRequesting = true;
//    [self.tool newsBefore:self.dates.lastObject completion:^{
//        [self.stories setObject:self.tool.stories forKey:self.tool.date];
//        [self.dates addObject:self.tool.date];
//        [self.tableView beginUpdates];
//        [self.tableView
//         insertSections:[NSIndexSet indexSetWithIndex:self.stories.count - 1]
//         withRowAnimation:UITableViewRowAnimationNone];
//        [self.tableView endUpdates];
//        self.isRequesting = false;
//
//    }];
//}
//- (NSString*)dateString:(NSDate*)date withFormat:(NSString*)format
//{
//    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
//    dateFormatter.dateFormat = format;
//    NSString* dateToString = [dateFormatter stringFromDate:date];
//    return dateToString;
//}

@end
