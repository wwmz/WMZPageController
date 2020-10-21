



//
//  IndicatorVC.m
//  WMZPageController
//
//  Created by wmz on 2019/10/10.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "IndicatorVC.h"
#import "TestVC.h"
@implementation IndicatorVC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //动画
    NSDictionary *animal = @{
        @(0):@(PageTitleMenuNone),
        @(1):@(PageTitleMenuLine),
        @(2):@(PageTitleMenuAiQY),
        @(3):@(PageTitleMenuTouTiao),
        @(4):@(PageTitleMenuCircle),
    };
       
    WMZPageParam *param = PageParam()
    .wTitleArrSet(@[@"推荐",@"LOOK直播",@"画画",@"现场",@"翻唱",@"MV",@"广场",@"游戏"])
    .wViewControllerSet(^UIViewController *(NSInteger index) {
           TestVC *vc = [TestVC new];
           vc.page = index;
            return vc;
    })
    .wMenuAnimalSet([animal[self.index] integerValue]);
    self.param = param;
}
@end
