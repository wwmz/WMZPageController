//
//  WMZHeadScalingVC.m
//  WMZPageController
//
//  Created by wmz on 2021/8/9.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZHeadScalingVC.h"
#import "UIImageView+WebCache.h"
#import "TopSuspensionVC.h"
@interface WMZHeadScalingVC ()

@end

@implementation WMZHeadScalingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:10/255.0 green:10/255.0 blue:20/255.0 alpha:0]}];
    NSArray *data = @[@"热门",@"男装",@"美妆",@"手机",@"食品",@"电器",@"鞋包",@"百货",@"女装",@"汽车",@"电脑"];
    WMZPageParam *param = WMZPageParam.new;
    param.wTitleArr = data;
    param.wViewController = ^UIViewController * _Nullable(NSInteger index) {
        /// 带滚动视图需实现协议
        TopSuspensionVC *vc = [TopSuspensionVC new];
        vc.page = index;
        return vc;
    };
    ///头部缩放
    param.wHeadScaling = YES;
    param.wTopSuspension = YES;
    param.wBounces = YES;
    param.wFromNavi = NO;
    param.wNaviAlpha = YES;
    ///头部
    param.wMenuHeadView = ^UIView * _Nullable{
        UIImageView *image = [UIImageView new];
        [image sd_setImageWithURL:[NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/9163368-02e26751674a3bc6.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"]];
        image.frame = CGRectMake(0, 0, PageVCWidth, 300);
        /// 必须返回一个UIImageView
        return image;
    };
    
    /// 自定义固定视图加在 headView上
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIView *view = UIView.new;
        view.backgroundColor = UIColor.redColor;
        view.frame = CGRectMake(0, 0, PageVCWidth, 150);
        UILabel *la = UILabel.new;
        la.text = @"测试";
        [view addSubview:la];
        la.frame = CGRectMake(30, 30, 100, 100);
        [self.headView addSubview:view];
    });
    self.param = param;
}

@end
