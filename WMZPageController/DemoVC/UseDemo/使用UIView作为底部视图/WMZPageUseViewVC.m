//
//  WMZPageUseViewVC.m
//  WMZPageController
//
//  Created by wmz on 2021/8/12.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZPageUseViewVC.h"
#import "TopSuspensionView.h"
#import "UIImageView+WebCache.h"
@interface WMZPageUseViewVC ()

@end

@implementation WMZPageUseViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WMZPageParam *param = WMZPageParam.new;
    param.wTitleArr = @[@"TestOne",@"TestTwo",@"TestThree",@"TestFour",@"TestFive",@"TestSix"];
    param.wViewController = ^UIViewController * _Nullable(NSInteger index) {
        /// WMZPageProtocol协议里有完整的生命周期 实现pageViewWillAppear等方法即可 默认UIView的frame和使用控制器的一样
        /// 带滚动视图需实现协议
        TopSuspensionView *view = TopSuspensionView.new;
        view.page = index;
        /// 这里为了方便使用 使用同一个属性 所以这里为了去除警告强转一下类型 但是实际类型还是UIView
        return (UIViewController*)view;
    };
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
        /// 若有其他子视图 则在image上添加
        return image;
    };
    self.param = param;
}


@end
