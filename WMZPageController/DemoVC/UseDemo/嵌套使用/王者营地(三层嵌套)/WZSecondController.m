//
//  WZSecondController.m
//  WMZPageController
//
//  Created by wmz on 2020/10/15.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WZSecondController.h"
#import "TestVC.h"
#import "WZThirdController.h"
@interface WZSecondController ()

@end

@implementation WZSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WMZPageParam *param = PageParam()
    .wTitleArrSet(@[@"推荐",@"赛事",@"短视频",@"专栏",@"新时代",@"电竞",@"游戏",@"汽车"])
    .wViewControllerSet(^UIViewController *(NSInteger index) {
        if (index == 1) {
            return [WZThirdController new];
        }
        return [TestVC new];
    })
    .wMenuTitleSelectColorSet([UIColor orangeColor])
    .wMenuAnimalSet(PageTitleMenuCircle);
    self.param = param;
}

@end
