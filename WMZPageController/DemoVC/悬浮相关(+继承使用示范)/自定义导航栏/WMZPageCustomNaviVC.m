//
//  WMZPageCustomNaviVC.m
//  WMZPageController
//
//  Created by wmz on 2020/9/7.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZPageCustomNaviVC.h"
#import "TopSuspensionVC.h"
#import "UIImageView+WebCache.h"
#import "WMZPageController.h"
@interface WMZPageCustomNaviVC ()
@property(nonatomic,strong)UIButton *customView;
@end

@implementation WMZPageCustomNaviVC
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏导航栏 (如果隐藏导航栏放在viewWillAppeal里 则会默认悬浮到导航栏下面)
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
     //标题数组
    NSArray *data = @[@"热门",@{@"name":@"男装",@"onlyClick":@(YES)},
                      @"美妆",@"手机",@"食品",@"电器",@"鞋包",@"百货",@"女装",@"汽车",@"电脑"];
    WMZPageParam *param =
    PageParam()
    //控制器数组
    .wViewControllerSet(^UIViewController *(NSInteger index) {
        TopSuspensionVC *vc = [TopSuspensionVC new];
        vc.page = index;
        return vc;
    })
    .wTitleArrSet(data)
    .wMenuAnimalSet(PageTitleMenuPDD)
    .wMenuDefaultIndexSet(3)
//    //调整顶部悬浮的位置 可调到悬浮至状态栏的位置
//    .wCustomNaviBarYSet(^CGFloat(CGFloat nowY) {
//       return nowY;
//     })
//    //调整距离底部的位置
//     .wCustomTabbarYSet(^CGFloat(CGFloat nowY) {
//         return nowY;
//     })
    // 正常的话是会悬浮到状态栏那里，改变这里减掉一部分就会自动悬浮到自定义导航栏那里)
    .wCustomDataViewHeightSet(^CGFloat(CGFloat nowY) {
        return nowY- PageVCStatusBarHeight;
    })
    //悬浮开启
    .wTopSuspensionSet(YES)
    //No为从自定义导航栏顶部开始 yes为从自定义导航栏底部开始
    .wFromNaviSet(NO)
    .wMenuHeadViewSet(^UIView *{
        UIView *back = [UIView new];
        back.frame = CGRectMake(0, 0, PageVCWidth, 270);
        UIImageView *image = [UIImageView new];
        [image sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576233638482&di=3ffdd857afe701f6e763c02deccb5ee9&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D3992719440%2C1178361773%26fm%3D214%26gp%3D0.jpg"]];
        image.frame = back.bounds;
        [back addSubview:image];
        return back;
    });
    self.param = param;
    
    [self.view addSubview:self.customView];
}

- (UIButton *)customView{
    if (!_customView) {
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        view.backgroundColor = [UIColor redColor];
        [view setTitle:@"我是自定义导航栏" forState:UIControlStateNormal];
        [view setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        view.frame = CGRectMake(0, 0, PageVCWidth, PageVCNavBarHeight);
        _customView = view;
              
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        [back setTitle:@"返回>" forState:UIControlStateNormal];
        [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.customView addSubview:back];
        [back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        back.frame = CGRectMake(20, PageVCStatusBarHeight, 60, 30);
    }
    return _customView;
}

@end
