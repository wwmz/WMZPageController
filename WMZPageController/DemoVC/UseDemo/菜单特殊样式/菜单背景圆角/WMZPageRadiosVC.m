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
      // 标题背景颜色
//    .wMenuTitleBackgroundSet([UIColor clearColor])
      // 标题选中背景
    .wMenuSelectTitleBackgroundSet([UIColor blueColor])
    .wMenuTitleColorSet([UIColor orangeColor])
    .wViewControllerSet(^UIViewController *(NSInteger index) {
        return [TestVC new];
    })
    .wMenuHeightSet(40)
    .wMenuWidthSet(PageVCWidth*0.75 + 8)
    .wMenuPositionSet(PageMenuPositionCenter)
    .wMenuTitleWidthSet(PageVCWidth/4*0.75)
    .wTitleArrSet(@[
        @{WMZPageKeyName:@"男装",WMZPageKeyTitleMarginY:@(4),WMZPageKeyTitleMarginX:@(2)},
        @{WMZPageKeyName:@"女装",WMZPageKeyTitleMarginY:@(4)},
        @{WMZPageKeyName:@"热门",WMZPageKeyTitleMarginY:@(4)},
        @{WMZPageKeyName:@"精选",WMZPageKeyTitleMarginY:@(4)},
    ]);
    self.param = param;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIView *contailView = self.upSc.mainView.containView;
        
        /// 不贴着标题
        CGRect rect = contailView.frame;
        rect.origin.x -= 2;
        rect.origin.y -= 2;
        rect.size.width += 4;
        rect.size.height += 4;
        contailView.frame = rect;
        
        contailView.layer.masksToBounds = YES;
        contailView.layer.cornerRadius = 20;
        contailView.layer.borderWidth = PageK1px;
        contailView.layer.borderColor = [UIColor orangeColor].CGColor;
    });
}


@end
