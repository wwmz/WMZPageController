//
//  WMZPageRadiosVC.m
//  WMZPageController
//
//  Created by wmz on 2020/12/18.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZPageRadiosVC.h"
#import "TestVC.h"
@interface WMZPageRadiosVC ()

@end

@implementation WMZPageRadiosVC

- (void)viewDidLoad {
    [super viewDidLoad];

    WMZPageParam *param = PageParam()
    .wMenuAnimalSet(PageTitleMenuCircleBg)
       //圆角
//    .wMenuTitleRadiosSet(5)
       //标题背景颜色
//    .wMenuTitleBackgroundSet([UIColor clearColor])
       //标题选中背景
//    .wMenuSelectTitleBackgroundSet([UIColor blueColor])
    .wMenuTitleColorSet([UIColor orangeColor])
    .wViewControllerSet(^UIViewController *(NSInteger index) {
        return [TestVC new];
    })
    .wMenuHeightSet(40)
    .wMenuWidthSet(PageVCWidth*0.75)
    .wMenuPositionSet(PageMenuPositionCenter)
    .wMenuTitleWidthSet(PageVCWidth/4*0.75)
    .wTitleArrSet(@[
                    @"热门",
                    @"男装",
                    @"女装",
                    @"推荐",
    ]);
    self.param = param;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.upSc.mainView.layer.masksToBounds = YES;
        self.upSc.mainView.layer.cornerRadius = 20;
        self.upSc.mainView.layer.borderWidth = PageK1px;
        self.upSc.mainView.layer.borderColor = [UIColor orangeColor].CGColor;
    });
}


@end
