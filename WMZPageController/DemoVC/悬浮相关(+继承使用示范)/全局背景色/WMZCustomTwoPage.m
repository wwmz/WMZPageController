//
//  WMZCustomTwoPage.m
//  WMZPageController
//
//  Created by wmz on 2019/12/13.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZCustomTwoPage.h"
#import "TopSuspensionVC.h"
#import "UIImageView+WebCache.h"
@interface WMZCustomTwoPage ()

@end

@implementation WMZCustomTwoPage

- (void)viewDidLoad {
    [super viewDidLoad];
        self.view.backgroundColor = [UIColor whiteColor];
    
     //标题数组
        NSArray *data = @[@"热门",@"男装",@"美妆",@"手机",@"食品",@"电器",@"鞋包",@"百货",@"女装",@"汽车",@"电脑"];
        //控制器数组
        NSMutableArray *vcArr = [NSMutableArray new];
        [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TopSuspensionVC *vc = [TopSuspensionVC new];
            vc.page = idx;
            [vcArr addObject:vc];
        }];
        
        WMZPageParam *param = PageParam()
        .wTitleArrSet(data)
        .wControllersSet(vcArr)
        //悬浮开启
        .wTopSuspensionSet(YES)
        //头视图y坐标从0开始
        .wFromNaviSet(NO)
        //导航栏透明度变化
        .wNaviAlphaSet(YES)
        //背景层
        .wInsertHeadAndMenuBgSet(^(UIView *bgView) {
            //全局背景示例
            bgView.layer.contents = (id)[UIImage imageNamed:@"11111"].CGImage;
        })
        //头部
        .wMenuHeadViewSet(^UIView *{
            UIView *back = [UIView new];
            back.frame = CGRectMake(0, 0, PageVCWidth, 270+PageVCStatusBarHeight);
            UIImageView *image = [UIImageView new];
            [image sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576232579081&di=29b77f2a5119755d3c1c3c7ce2595527&imgtype=0&src=http%3A%2F%2Fi2.bangqu.com%2Fr2%2Fnews%2F20180810%2F304a6c35725753744e48.jpg"]];
            image.frame = CGRectMake(100, 100, 100, 100);
            [back addSubview:image];
            return back;
        });
        
        self.param = param;
    
}
@end
