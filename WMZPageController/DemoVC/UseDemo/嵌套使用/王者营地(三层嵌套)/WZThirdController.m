


//
//  WZThirdController.m
//  WMZPageController
//
//  Created by wmz on 2020/10/15.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WZThirdController.h"
#import "TopSuspensionVC.h"
#import "UIImageView+WebCache.h"
@interface WZThirdController ()<WMZPageProtocol>

@end

@implementation WZThirdController
- (void)viewDidLoad {
    [super viewDidLoad];
    WMZPageParam *param = PageParam()
    .wTitleArrSet(@[@"资讯",@"视频",@"其他"])
    .wViewControllerSet(^UIViewController *(NSInteger index) {
        return [TopSuspensionVC new];
    })
    ///如果第一层嵌套开启悬浮  二三层也要开启
    ///举一反三 只有第二层开启的话 第三层也要开启
    ///如果是最后一层开启则上级不需要开启
    .wTopSuspensionSet(YES)
    .wMenuIndicatorColorSet([UIColor orangeColor])
    .wMenuTitleSelectColorSet([UIColor orangeColor])
    .wMenuAnimalSet(PageTitleMenuPDD);
    self.param = param;
}

@end
