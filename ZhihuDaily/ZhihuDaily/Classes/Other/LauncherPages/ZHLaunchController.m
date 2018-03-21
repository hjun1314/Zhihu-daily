//
//  ZHLaunchController.m
//  ZhihuDaily
//
//  Created by hjun on 2018/3/21.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "ZHLaunchController.h"
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "ZHLanchImage.h"
static CGFloat const animationDuration = 3.0;

@interface ZHLaunchController ()
@property (nonatomic,strong)UIImageView *launchImage;
@property (nonatomic,strong)UIImageView *logoImage;
@property (nonatomic,strong)UILabel *imageTitle;



@end

@implementation ZHLaunchController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.launchImage];
    [self.view bringSubviewToFront:self.launchImage];
    [self.view addSubview:self.imageTitle];
}

- (void)updateLaunchImage{
    
    [[UPSHttpNetWorkTool sharedApi]GET:@"http://news-at.zhihu.com/api/4/start-image/1080*1776" params:nil success:^(NSURLSessionDataTask *task, id json) {
        ZHLanchImage *lanunchImage = [ZHLanchImage mj_objectWithKeyValues:json];
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager loadImageWithURL:[NSURL URLWithString:lanunchImage.img] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            [self.view addSubview:self.logoImage];
            self.launchImage.image = image;
            self.imageTitle.text = lanunchImage.text;
            [self.imageTitle sizeToFit];
            _imageTitle.centerX = self.view.centerX;
            _imageTitle.y = self.view.height - 30;
            
            [UIView animateWithDuration:animationDuration animations:^{
                _launchImage.transform = CGAffineTransformMakeScale(1.2, 1.2);
            } completion:^(BOOL finished) {
                [self.view removeFromSuperview];
            }];
            
        }];
        
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
#pragma mark - getter and setter

- (UIImageView *)launchImage{
    
    if (_launchImage == nil) {
        _launchImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _launchImage.image = [UIImage imageNamed:@"Default"];
    }
    
    return _launchImage;
}

- (UIImageView *)logoImage{
    
    if (_logoImage == nil) {
        _logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth(95), kHeight(458), kWidth(128), kHeight(49))];
        _logoImage.image = [UIImage imageNamed:@"Login_Logo"];
    }
    
    return _logoImage;
}

- (UILabel *)imageTitle{
    
    if (_imageTitle == nil) {
        _imageTitle = [[UILabel alloc] init];
        _imageTitle.textColor = [UIColor whiteColor];
        _imageTitle.font = [UIFont systemFontOfSize:14];
    }
    
    return _imageTitle;
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
