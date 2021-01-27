


//
//  SecondNextSonVC.m
//  WMZPageController
//
//  Created by wmz on 2021/1/7.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "SecondNextSonVC.h"
#import "TopSuspensionVC.h"
@interface SecondNextSonVC ()

@end

@implementation SecondNextSonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WMZPageParam *param = PageParam()
    .wTitleArrSet(@[@"推荐",@"赛事",@"短视频",@"专栏",@"新时代",@"电竞",@"游戏",@"汽车"])
    .wViewControllerSet(^UIViewController *(NSInteger index) {
        return [TopSuspensionVC new];
    })
    .wTopSuspensionSet(YES)
    .wMenuTitleSelectColorSet([UIColor orangeColor])
    .wMenuAnimalSet(PageTitleMenuCircle);
    self.param = param;
}


@end
