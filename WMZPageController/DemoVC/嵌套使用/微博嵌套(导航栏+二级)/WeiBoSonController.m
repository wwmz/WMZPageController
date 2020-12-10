//
//  WeiBoSonController.m
//  WMZPageController
//
//  Created by wmz on 2020/10/15.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WeiBoSonController.h"
#import "TestVC.h"
#import "MJRefresh.h"
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
    .wMenuTitleSelectColorSet([UIColor orangeColor])
//    //减掉导航栏高度+tabbar高度(根据实际情况)
    .wCustomDataViewHeightSet(^CGFloat(CGFloat nowY) {
        return nowY ;
    })
    .wMenuAnimalSet(PageTitleMenuNone);
    self.param = param;
}

@end
