//
//  WeiBoController.m
//  WMZPageController
//
//  Created by wmz on 2020/10/15.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WeiBoController.h"
#import "WeiBoSonController.h"
#import "TestVC.h"
#import "MJRefresh.h"
@interface WeiBoController ()

@end

@implementation WeiBoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSInteger random = arc4random() % 2;
    WMZPageParam *headParam = PageParam()
    .wTitleArrSet(@[@"关注",@"推荐"])
    .wViewControllerSet(^UIViewController *(NSInteger num) {
        if (num == random) {
            return [WeiBoSonController new];
        }
        return [TestVC new];
    })
    .wMenuPositionSet(PageMenuPositionNavi)
    .wMenuAnimalSet(PageTitleMenuPDD)
    .wMenuWidthSet(150);
    self.param = headParam;
    
    
    __weak WeiBoController* weakSelf = self;
    self.downSc.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    __strong WeiBoController *strongSelf = weakSelf;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [strongSelf.downSc.mj_header endRefreshing];
        });
    }];
}



@end
