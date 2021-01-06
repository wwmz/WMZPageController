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
        @{@"name":@"首页",@"image":@"B"} ,
        @{@"name":@"收藏",@"badge":@(99),@"image":@"C"},
        @{@"name":@"消息",@"badge":@(9),@"image":@"D"},
        @{@"name":@"我的",@"image":@"B"}
    ])
    //自定义红点
    .wCustomRedViewSet(^(UILabel *redLa,NSDictionary *info) {
        NSString *num = [NSString stringWithFormat:@"%@",info[@"badge"]];
        redLa.text = num;
        redLa.backgroundColor = [UIColor clearColor];
        redLa.textColor = [UIColor redColor];
        CGRect rect = redLa.frame;
        rect.size.width = 25;
        rect.origin.x += (num.length*8);
        rect.size.height = 20;
        redLa.layer.masksToBounds = NO;
        redLa.frame = rect;
    })
     .wCustomTabbarYSet(^CGFloat(CGFloat nowY) {
         return nowY;
     })
    //菜单标题颜色
    .wMenuTitleColorSet(PageDarkColor(PageColor(0x333333), PageColor(0xffffff)))
    //菜单标题选中的颜色
    .wMenuTitleSelectColorSet(PageDarkColor(PageColor(0xffffff), [UIColor orangeColor]))
    //指示器颜色
    .wMenuIndicatorColorSet(PageDarkColor(PageColor(0xFFFAFA), PageColor(0xFFFAFA)))
    //菜单背景颜色
    .wMenuBgColorSet([UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.5])
    //使用特殊样式1
    .wMenuSpecifialSet(PageSpecialTypeOne)
    .wMenuIndicatorWidthSet(self.view.frame.size.width / 9)
    .wMenuAnimalSet(PageTitleMenuAiQY)
    .wMenuPositionSet(PageMenuPositionBottom)
    .wMenuTitleWidthSet(self.view.frame.size.width / 4)
    .wControllersSet(@[[[UINavigationController alloc]initWithRootViewController:[WMZDemoOneSonVC new]],[WMZDemoOneSonVC new],[WMZDemoOneSonVC new],[WMZDemoOneSonVC new]]);
     self.param = param;
}

@end
