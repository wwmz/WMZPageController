//
//  UsePageViewController.m
//  WMZPageController
//
//  Created by wmz on 2021/10/20.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "UsePageViewController.h"
#import "WMZPageView.h"
#import "UIImageView+WebCache.h"

@interface UsePageViewController ()

@end

@implementation UsePageViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    WMZPageParam *param = PageParam()
    .wMenuHeadViewSet(^UIView *{
        UIImageView *image = [UIImageView new];
        [image sd_setImageWithURL:[NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/9163368-02e26751674a3bc6.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"]];
        image.frame = CGRectMake(0, 0, PageVCWidth, 300);
        return image;
    })
    .wTopSuspensionSet(YES)
    .wTitleArrSet(@[@"精选",@"好货",@"精选",@"好货"])
    .wViewControllerSet(^UIViewController * _Nullable(NSInteger index) {
        return NSClassFromString(@"TopSuspensionVC").new;
    });

    /// frame可以设置任意frame autoFix为YES
    WMZPageView *pageView = [[WMZPageView alloc]initWithFrame:self.view.bounds autoFix:YES param:param parentReponder:self];
    [self.view addSubview:pageView];

    
    /// autoFix为NO 自己调整frame
//    WMZPageView *pageView = [[WMZPageView alloc]initWithFrame:CGRectMake(0, 0, PageVCWidth, PageVCHeight - PageVCNavBarHeight) autoFix:NO param:param parentReponder:self];
//    [self.view addSubview:pageView];
}

@end
