//
//  ReplaceParentSonVC.m
//  WMZPageController
//
//  Created by wmz on 2021/8/11.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "ReplaceParentSonVC.h"
#import "MJRefresh.h"
#import "TopSuspensionVC.h"
#import "UIImageView+WebCache.h"
@interface ReplaceParentSonVC ()
@property(nonatomic,assign)CGRect rect;
@property(nonatomic,assign)CGRect sRect;
@property(nonatomic,assign)CGRect ssRect;
@end

@implementation ReplaceParentSonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak ReplaceParentSonVC *weakSelf = self;
    CGFloat parentMenuHeight = 55.0;
    WMZPageParam *param = PageParam()
    .wTitleArrSet(@[@"热门",@"同城",@"榜单",@"抽奖",@"新时代",@"电竞",@"游戏",@"汽车"])
    .wMenuFixRightDataSet(@" + ")
    .wViewControllerSet(^UIViewController *(NSInteger index) {
        TopSuspensionVC *vc = [TopSuspensionVC new];
         vc.page = index;
         return vc;
     })
    .wTopSuspensionSet(YES)
    .wMenuTitleSelectColorSet([UIColor orangeColor])
    //头部
    .wMenuHeadViewSet(^UIView *{
        UIView *back = [UIView new];
        back.frame = CGRectMake(0, 0, PageVCWidth, 270);
        UIImageView *image = [UIImageView new];
        [image sd_setImageWithURL:[NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/9163368-02e26751674a3bc6.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"]];
        image.frame = back.bounds;
        [back addSubview:image];
        return back;
    })
    .wMenuAnimalSet(PageTitleMenuNone);
    param.wEventChildVCDidSroll = ^(UIViewController * _Nullable pageVC, CGPoint oldPoint, CGPoint newPonit, UIScrollView * _Nullable currentScrollView) {
        __strong ReplaceParentSonVC *stongSelf = weakSelf;
        WMZPageController *parentVC = (WMZPageController*)stongSelf.parentViewController;
        if (CGRectIsEmpty(stongSelf.rect)) stongSelf.rect = parentVC.upSc.dataView.frame;
        if (CGRectIsEmpty(stongSelf.sRect)) stongSelf.sRect = parentVC.upSc.dataView.frame;
        if (CGRectIsEmpty(stongSelf.ssRect)) stongSelf.ssRect = stongSelf.downSc.frame;
        if (newPonit.y >= 270) {  //置顶临界值
            [UIView animateWithDuration:0.15 animations:^{
                [parentVC.upSc.dataView page_y:0];
                [parentVC.upSc.dataView page_height:stongSelf.sRect.size.height + parentMenuHeight];
                [stongSelf.downSc page_height:stongSelf.ssRect.size.height + parentMenuHeight];
            }];
        }else{
            if (!CGRectEqualToRect(parentVC.downSc.frame, stongSelf.rect)) {
                [UIView animateWithDuration:0.15 animations:^{
                    parentVC.upSc.dataView.frame = stongSelf.rect;
                }];
            }
        }
    };
    param.wCustomDataViewHeight = ^CGFloat(CGFloat nowY) {
        return nowY + parentMenuHeight;
    };
    self.param = param;
}
@end
