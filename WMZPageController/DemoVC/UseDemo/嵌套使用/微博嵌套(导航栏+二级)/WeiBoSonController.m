//
//  WeiBoSonController.m
//  WMZPageController
//
//  Created by wmz on 2020/10/15.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WeiBoSonController.h"
#import "TopSuspensionVC.h"
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
        TopSuspensionVC *vc = [TopSuspensionVC new];
         vc.page = index;
         return vc;
     })
    .wTopSuspensionSet(YES)
    .wMenuHeadViewSet(^UIView *{
        UIView *back = [UIView new];
        back.frame = CGRectMake(0, 0, PageVCWidth, 200);
        back.backgroundColor = UIColor.redColor;
        return back;
    })
    /// 如果设为NO 则自己需要根据实际场景手动调整 wCustomTabbarY wCustomNaviY 默认YES
    .wLazyLoadingSet(NO)
    .wMenuTitleSelectColorSet([UIColor orangeColor])
    .wMenuAnimalSet(PageTitleMenuNone);
    /// 根据实际情况设置
    param.wCustomTabbarY = ^CGFloat(CGFloat nowY) {
        return PageVCTabBarHeight;
    };
    /// 根据实际情况设置
    param.wCustomNaviBarY  = ^CGFloat(CGFloat nowY) {
        return 0;
    };
    self.param = param;
}

@end
