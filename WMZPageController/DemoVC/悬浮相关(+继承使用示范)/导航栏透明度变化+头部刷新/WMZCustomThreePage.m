

//
//  WMZCustomThreePage.m
//  WMZPageController
//
//  Created by wmz on 2019/12/13.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZCustomThreePage.h"
#import "CollectionViewPopDemo.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "TopSuspensionVC.h"
@interface WMZCustomThreePage ()

@end

@implementation WMZCustomThreePage

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak WMZCustomThreePage* weakSelf = self;
    self.navigationItem.title = @"导航栏标题";
    //默认标题透明度0
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:10/255.0 green:10/255.0 blue:20/255.0 alpha:0]}];
     
    //标题数组
    NSArray *data = @[@"热门",@"男装",@"美妆",@"手机",@"食品",@"电器",@"鞋包",@"百货",@"女装",@"汽车",@"电脑"];
    WMZPageParam *param = PageParam()
    .wTitleArrSet(data)
    //控制器数组
    .wViewControllerSet(^UIViewController *(NSInteger index) {
        TopSuspensionVC *vc = [TopSuspensionVC new];
        vc.page = index;
        return vc;
    })
    //悬浮开启
    .wTopSuspensionSet(YES)
    //顶部可下拉
    .wBouncesSet(YES)
    //头视图y坐标从导航栏开始
    .wFromNaviSet(NO)
    //导航栏透明度变化
    .wNaviAlphaSet(YES)
    //头部
    .wMenuHeadViewSet(^UIView *{
        UIImageView *image = [UIImageView new];
        [image sd_setImageWithURL:[NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/9163368-02e26751674a3bc6.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"]];
        image.frame = CGRectMake(0, 0, PageVCWidth, 300);
        return image;
    })
    //导航栏标题透明度变化
    .wEventChildVCDidSrollSet(^(UIViewController *pageVC, CGPoint oldPoint, CGPoint newPonit, UIScrollView *currentScrollView) {
        __strong WMZCustomThreePage* strongSelf = weakSelf;
        [strongSelf.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:10/255.0 green:10/255.0 blue:20/255.0 alpha:newPonit.y/(300-PageVCNavBarHeight)]}];
    });
    self.param = param;
    
    self.downSc.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong WMZCustomThreePage *strongSelf = weakSelf;
        //模拟更新数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSArray *data1 = @[@"热门",@"男装",@"美妆"];
                strongSelf.param.wTitleArrSet(data1)
                   //控制器数组
                .wViewControllerSet(^UIViewController *(NSInteger index) {
                    CollectionViewPopDemo *vc = [CollectionViewPopDemo new];
                    return vc;
                });
                //模拟更新菜单数据
                [strongSelf updateMenuData];
                [strongSelf.downSc.mj_header endRefreshing];
            });
        }];
}
@end
