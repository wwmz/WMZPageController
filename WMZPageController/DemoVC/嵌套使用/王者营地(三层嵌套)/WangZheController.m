//
//  WangZheController.m
//  WMZPageController
//
//  Created by wmz on 2020/10/15.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WangZheController.h"
#import "TestVC.h"
#import "WZSecondController.h"
@interface WangZheController ()

@end

@implementation WangZheController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WMZPageParam *param = PageParam()
    .wTitleArrSet(@[@"关注",@"推荐"])
    .wMenuWidthSet(PageVCWidth - 40)
    .wMenuPositionSet(PageMenuPositionCenter)
    .wMenuFixShadowSet(NO)
    .wMenuFixRightDataSet(@[@{@"name":@"固定",@"selectName":@"固定1",@"titleColor":[UIColor redColor],@"titleSelectColor":[UIColor blueColor]},@{@"image":@"C"}])
    .wViewControllerSet(^UIViewController *(NSInteger index) {
        if (index == 1) {
            return [WZSecondController new];
        }
        return [TestVC new];
     })
    .wMenuIndicatorColorSet([UIColor orangeColor])
    .wMenuTitleSelectColorSet([UIColor orangeColor])
    .wMenuAnimalSet(PageTitleMenuPDD);
    self.param = param;
}

@end
