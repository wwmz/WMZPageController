//
//  WMZDemoOne.m
//  WMZPageController
//
//  Created by wmz on 2020/6/4.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZDemoOne.h"
#import "WMZDemoOneSonVC.h"
@interface WMZDemoOne ()

@end

@implementation WMZDemoOne

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WMZPageParam *param = PageParam()
    .wTitleArrSet(@[
        @{WMZPageKeyName:@"首页",WMZPageKeyImage:@"B",WMZPageKeyBadge:@(YES)} ,
        @{WMZPageKeyName:@"收藏",WMZPageKeyBadge:@"99+",WMZPageKeyImage:@"C"},
        @{WMZPageKeyName:@"消息",WMZPageKeyBadge:@(99),WMZPageKeyImage:@"D"},
        @{WMZPageKeyName:@"我的",WMZPageKeyImage:@"B"}
    ])
    //自定义红点
    .wCustomRedViewSet(^(UILabel *redLa,NSDictionary *info) {

    })
     .wCustomTabbarYSet(^CGFloat(CGFloat nowY) {
         return nowY;
     })
    /// 不自动隐藏红点
    .wHideRedCircleSet(NO)
    //菜单标题颜色
    .wMenuTitleColorSet(PageDarkColor(PageColor(0x333333), PageColor(0xffffff)))
    //菜单标题选中的颜色
    .wMenuTitleSelectColorSet(PageDarkColor(UIColor.orangeColor, [UIColor orangeColor]))
    //菜单背景颜色
    .wMenuBgColorSet(UIColor.whiteColor)
    .wMenuIndicatorWidthSet(self.view.frame.size.width / 9)
    .wMenuAnimalSet(PageTitleMenuNone)
    .wMenuHeightSet(PageVCTabBarHeight)
    .wMenuPositionSet(PageMenuPositionBottom)
    .wMenuTitleWidthSet(self.view.frame.size.width / 4)
    .wControllersSet(@[[[UINavigationController alloc]initWithRootViewController:[WMZDemoOneSonVC new]],[WMZDemoOneSonVC new],[WMZDemoOneSonVC new],[WMZDemoOneSonVC new]]);
     self.param = param;
}

@end
