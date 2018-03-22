//
//  ZHLeftController.m
//  ZhihuDaily
//
//  Created by hjun on 2018/3/21.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "ZHLeftController.h"
#import "ZHLeftTableViewCell.h"
#import "ZHThemeModel.h"
#import "ZHThemeTool.h"
#import "ZHLoginController.h"
#import "ZHThemeController.h"
#import "ZHMainController.h"
static NSString * const leftCell = @"leftCell";

@interface ZHLeftController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *nightBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *themes;
@property (nonatomic,strong)UINavigationController *nav;
@property (nonatomic,strong)ZHThemeController *themeVC;



@end

@implementation ZHLeftController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 50;
    [ZHThemeTool getThemeWithSuccessfulblock:^(id obj) {
        [self.themes addObjectsFromArray:obj];
        [self.tableView reloadData];
    }];
}


#pragma mark- tableViewDelegate&dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.themes.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHLeftTableViewCell *cell = [[ZHLeftTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftCell];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:leftCell];
    }
    ZHThemeModel *model = self.themes[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self.mainVC setCenterViewController:self.mainVC.nav withCloseAnimation:YES completion:nil];
    }else{
        [self.mainVC setCenterViewController:self.nav withCloseAnimation:YES completion:nil];
    }
    
}
#pragma mark- 登录和夜间按钮点击
- (IBAction)didLoginBtn:(id)sender {
    ZHLoginController *loginVC = [[ZHLoginController alloc]init];
    [self presentViewController:loginVC animated:YES completion:nil];
}
- (IBAction)didNightBtn:(UIButton *)sender {
}

#pragma mark - setter and getter
- (NSMutableArray *)themes{
    if (_themes == nil) {
        _themes = [NSMutableArray array];
        ZHThemeModel *theme = [[ZHThemeModel alloc] init];
         theme.name =  @"首页";
        [_themes addObject:theme];
    }
    return _themes;
}
- (UINavigationController *)nav{
    if (_nav == nil) {
        _nav = [[UINavigationController alloc]initWithRootViewController:self.themeVC];
        _nav.navigationBar.hidden = YES;
    }
    return _nav;
}
- (ZHThemeController *)themeVC{
    if (_themeVC == nil) {
        _themeVC = [[ZHThemeController alloc]init];
    }
    return _themeVC;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
