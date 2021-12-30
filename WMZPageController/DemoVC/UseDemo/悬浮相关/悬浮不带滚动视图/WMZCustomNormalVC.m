//
//  WMZCustomNormalVC.m
//  WMZPageController
//
//  Created by wmz on 2021/10/26.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZCustomNormalVC.h"
#import "UIImageView+WebCache.h"
#import "TopSuspensionVC.h"

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
@interface WMZCustomNormalVC ()

@end

@implementation WMZCustomNormalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //标题数组
    NSArray *data = @[@"热门",@"男装",@"美妆",@"手机",@"食品",@"电器",@"鞋包",@"百货",@"女装",@"汽车",@"电脑"];
    WMZPageParam *param = PageParam()
    .wTitleArrSet(data)
    .wMenuBgColorSet([UIColor blackColor])
    .wMenuTitleColorSet([[UIColor whiteColor] colorWithAlphaComponent:0.3])
    .wMenuTitleSelectColorSet([UIColor whiteColor])
    .wMenuAnimalTitleGradientSet(YES)
    //控制器数组
    .wViewControllerSet(^UIViewController *(NSInteger index) {
        /// 有滚动视图的实现协议 区分
        if (index == 3) return TopSuspensionVC.new;
        /// 普通控制器 无需使用协议
        UIViewController*vc = UIViewController.new;
        vc.view.backgroundColor = randomColor;
        return vc;
    })
    //悬浮开启
    .wTopSuspensionSet(YES)
    //顶部可下拉
    .wBouncesSet(YES)
    //头视图y坐标从导航栏开始
    .wFromNaviSet(NO)
    //导航栏透明度变化
    .wNaviAlphaSet(YES)
    .wMenuAnimalSet(PageTitleMenuAiQY)
    //头部
    .wMenuHeadViewSet(^UIView *{
        UIImageView *image = [UIImageView new];
        [image sd_setImageWithURL:[NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/9163368-02e26751674a3bc6.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"]];
        image.frame = CGRectMake(0, 0, PageVCWidth, 300);
        return image;
    });
    self.param = param;
}

@end
