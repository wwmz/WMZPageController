
//
//  WMZCustomOnePage.m
//  WMZPageController
//
//  Created by wmz on 2019/12/13.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZCustomOnePage.h"
#import "TopSuspensionVC.h"
#import "UIImageView+WebCache.h"
#import "WKViewController.h"

@interface WMZCustomOnePage ()
@end

@implementation WMZCustomOnePage

- (void)viewDidLoad {
    [super viewDidLoad];
    //标题数组
    NSArray *data = @[@"热门",@"男装",@"美妆",@"手机",@"食品",@"电器",@"鞋包",@"百货",@"女装",@"汽车",@"电脑"];
    WMZPageParam *param =
    PageParam()
    //控制器数组
    .wViewControllerSet(^UIViewController *(NSInteger index) {
        /// 带滚动视图需实现协议 wkwebView需返回内容视图scrollview
        if (index == 2)  return WKViewController.new;
        TopSuspensionVC *vc = [TopSuspensionVC new];
        vc.page = index;
        return vc;
    })
    .wTitleArrSet(data)
    .wMenuAnimalSet(PageTitleMenuAiQY)
    .wMenuDefaultIndexSet(3)
    //悬浮开启
    .wTopSuspensionSet(YES)
    //头视图y坐标从导航栏开始
    .wFromNaviSet(YES)
    //头部
    .wMenuHeadViewSet(^UIView *{
        UIView *back = [UIView new];
        back.frame = CGRectMake(0, 0, PageVCWidth, 270);
        UIImageView *image = [UIImageView new];
        [image sd_setImageWithURL:[NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/9163368-02e26751674a3bc6.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"]];
        image.frame = back.bounds;
        [back addSubview:image];
        return back;
    });
    
    self.param = param;
    
    //   模拟更新头部
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.param.wMenuHeadViewSet(^UIView *{
//            UIView *back = [UIView new];
//            //如果要更新隐藏顶部 高度需设为CGFLOAT_MIN 不能设为0
//            back.frame = CGRectMake(0, 0, PageVCWidth, 200);
//            UIImageView *image = [UIImageView new];
//            [image sd_setImageWithURL:[NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/9163368-dc97bebf2f743a60.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"]];
//            image.frame = back.bounds;
//            [back addSubview:image];
//            return back;
//        });
//        [self updateHeadView];
//    });
    [self seekLineImageViewOn:self.navigationController.navigationBar].hidden = YES;
    
}
/// 查找导航栏下的横线
- (UIImageView *)seekLineImageViewOn:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) return (UIImageView *)view;
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self seekLineImageViewOn:subview];
        if (imageView) return imageView;
    }
    return nil;
}

@end
