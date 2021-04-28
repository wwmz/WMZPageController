


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
    .wTopSuspensionSet(YES)
    .wMenuIndicatorColorSet([UIColor orangeColor])
    .wMenuTitleSelectColorSet([UIColor orangeColor])
//    //头部
    .wMenuHeadViewSet(^UIView *{
        UIView *back = [UIView new];
        back.frame = CGRectMake(0, 0, PageVCWidth, 200);
        UIImageView *image = [UIImageView new];
        [image sd_setImageWithURL:[NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/9163368-02e26751674a3bc6.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"]];
        image.frame = back.bounds;
        [back addSubview:image];
        return back;
    })
    .wMenuAnimalSet(PageTitleMenuPDD);
    self.param = param;
}

@end
