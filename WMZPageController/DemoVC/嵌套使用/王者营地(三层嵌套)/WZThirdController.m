


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
        [image sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1602673230263&di=c9290650541d8edf911ff008a3bfa4dc&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2Ff%2F33%2F648011013.jpg"]];
        image.frame = back.bounds;
        [back addSubview:image];
        return back;
    })
    .wMenuAnimalSet(PageTitleMenuPDD);
    self.param = param;
}

@end
