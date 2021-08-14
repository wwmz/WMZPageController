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
    .wTitleArrSet(@[@"推荐",@"赛事",@"短视频",@"专栏"])
    .wViewControllerSet(^UIViewController *(NSInteger index) {
        return [SecondNextSonVC new];
    })
    /// 设为NO 则需要手动调整
    .wLazyLoadingSet(NO)
    .wMenuTitleSelectColorSet([UIColor orangeColor])
    .wMenuAnimalSet(PageTitleMenuCircle);
    
    self.param = param;
}

@end
