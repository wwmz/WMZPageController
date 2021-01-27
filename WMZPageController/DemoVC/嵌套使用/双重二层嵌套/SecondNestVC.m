//
//  SecondNestVC.m
//  WMZPageController
//
//  Created by wmz on 2021/1/7.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "SecondNestVC.h"
#import "SecondNextSonVC.h"
@interface SecondNestVC ()

@end

@implementation SecondNestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WMZPageParam *param = PageParam()
    .wTitleArrSet(@[@"推荐",@"赛事",@"短视频",@"专栏",@"新时代",@"电竞",@"游戏",@"汽车"])
    .wViewControllerSet(^UIViewController *(NSInteger index) {
        return [SecondNextSonVC new];
    })
    .wMenuTitleSelectColorSet([UIColor orangeColor])
    .wMenuAnimalSet(PageTitleMenuCircle);
    self.param = param;
}

@end
