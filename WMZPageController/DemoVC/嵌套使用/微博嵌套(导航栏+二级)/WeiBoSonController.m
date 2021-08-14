//
//  WeiBoSonController.m
//  WMZPageController
//
//  Created by wmz on 2020/10/15.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WeiBoSonController.h"
#import "TestVC.h"
@interface WeiBoSonController ()
@end

@implementation WeiBoSonController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WMZPageParam *param = PageParam()
    .wTitleArrSet(@[@"热门",@"同城",@"榜单",@"抽奖",@"新时代",@"电竞",@"游戏",@"汽车"])
    .wMenuFixRightDataSet(@" + ")
    .wViewControllerSet(^UIViewController *(NSInteger index) {
         TestVC *vc = [TestVC new];
         vc.page = index;
         return vc;
     })
    /// 设为NO 则自己需要根据实际场景手动调整 wCustomTabbarY wCustomNaviY
    .wLazyLoadingSet(NO)
    .wMenuTitleSelectColorSet([UIColor orangeColor])
    .wMenuAnimalSet(PageTitleMenuNone);
    param.wCustomTabbarY = ^CGFloat(CGFloat nowY) {
        return PageVCTabBarHeight;
    };
    self.param = param;
}

@end
