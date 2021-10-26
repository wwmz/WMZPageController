//
//  WMZCustomAddMenuVC.m
//  WMZPageController
//
//  Created by wmz on 2021/10/26.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZCustomAddMenuVC.h"
#import "TopSuspensionVC.h"
#import "UIImageView+WebCache.h"

@interface WMZCustomAddMenuVC ()
@end

@implementation WMZCustomAddMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WMZPageParam *param = PageParam()
    .wViewControllerSet(^UIViewController *(NSInteger index) {
        /// 带滚动视图需实现协议
        return [TopSuspensionVC new];
    })
    .wTitleArrSet(@[@"热门",@"男装",@"美妆",@"手机",@"食品",@"电器",@"鞋包",@"百货",@"女装",@"汽车",@"电脑"])
    .wMenuAnimalSet(PageTitleMenuAiQY)
    .wTopSuspensionSet(YES)
    /// 自定义内间距
    .wMenuInsetsSet(UIEdgeInsetsMake(10, 10, 10, 10))
    .wMenuHeadViewSet(^UIView *{
        UIView *back = [UIView new];
        back.frame = CGRectMake(0, 0, PageVCWidth, 270);
        UIImageView *image = [UIImageView new];
        [image sd_setImageWithURL:[NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/9163368-02e26751674a3bc6.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"]];
        image.frame = back.bounds;
        [back addSubview:image];
        return back;
    })
    /// 在菜单栏插入一个固定的自定义视图 例如 筛选视图等
    /// 筛选视图可使用 WMZDropDownMenu github地址为 https://github.com/wwmz/WMZDropDownMenu
    .wMenuAddSubViewSet(^UIView * _Nullable{
        UIView *menuAddCustomView = UIView.new;
        /// 20为距离菜单栏的纵向间距 此处要先确定好高度
        menuAddCustomView.frame = CGRectMake(0, 10, PageVCWidth, 50);
        menuAddCustomView.backgroundColor = UIColor.orangeColor;
        UILabel *nameLB = UILabel.new;
        nameLB.frame = menuAddCustomView.bounds;
        nameLB.text = @"我是自定义视图";
        nameLB.textAlignment = NSTextAlignmentCenter;
        [menuAddCustomView addSubview:nameLB];
        return menuAddCustomView;
    });
    
    self.param = param;
}

@end
