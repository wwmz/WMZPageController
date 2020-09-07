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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    if (!self.customView) {
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        view.backgroundColor = [UIColor redColor];
        [view setTitle:@"我是自定义导航栏" forState:UIControlStateNormal];
        [view setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        view.frame = CGRectMake(0, 0, PageVCWidth, PageVCNavBarHeight);
        [self.view addSubview:view];
        self.customView = view;
        
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        [back setTitle:@"返回>" forState:UIControlStateNormal];
        [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.customView addSubview:back];
        [back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        back.frame = CGRectMake(20, PageVCStatusBarHeight, 60, 30);
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     //标题数组
    NSArray *data = @[@"热门",@"男装",@"美妆",@"手机",@"食品",@"电器",@"鞋包",@"百货",@"女装",@"汽车",@"电脑"];
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
    //悬浮开启
    .wTopSuspensionSet(YES)
    //头视图y坐标从0开始
    .wFromNaviSet(YES)
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
}

@end
