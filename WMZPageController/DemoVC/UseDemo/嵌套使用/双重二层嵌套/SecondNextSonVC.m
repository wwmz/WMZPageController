


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
    .wTitleArrSet(@[@"推荐",@"赛事",@"短视频",@"专栏"])
    .wViewControllerSet(^UIViewController *(NSInteger index) {
        return [TopSuspensionVC new];
    })
    .wTopSuspensionSet(YES)
    /// 设为NO 则需要手动调整
    .wLazyLoadingSet(NO)
    .wMenuTitleSelectColorSet([UIColor orangeColor])
    .wMenuAnimalSet(PageTitleMenuCircle);
    param.wCustomNaviBarY = ^CGFloat(CGFloat nowY) {
        return nowY;
    };
    param.wCustomTabbarY = ^CGFloat(CGFloat nowY) {
        return nowY;
    };
    param.wCustomDataViewHeight = ^CGFloat(CGFloat nowY) {
        /// 再减掉父类的菜单高度 
        return nowY - PageVCTabBarHeight - 55;
    };
    self.param = param;
}


@end
