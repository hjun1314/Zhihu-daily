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
static NSString * const leftCell = @"leftCell";

@interface ZHLeftController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *nightBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *themes;


@end

@implementation ZHLeftController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
