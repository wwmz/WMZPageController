//
//  WMZCustomTitleVC.m
//  WMZPageController
//
//  Created by wmz on 2021/8/13.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZCustomTitleVC.h"

@interface WMZCustomTitleVC ()

@end

@implementation WMZCustomTitleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WMZPageParam *param = WMZPageParam.new;
    param
    .wMenuBgColorSet(PageColor(0xf8f6f8))
    .wMenuInsetsSet(UIEdgeInsetsMake(10, 10, 10, 10))
    .wTitleArrSet(@[@"推荐",@"LOOK直播",@"画",@"现场",@"翻唱",@"MV",@"广场",@"游戏"])
    .wMenuTitleWidthSet(100)
    .wBgColorSet(PageColor(0xf8f6f8))
    .wMenuAnimalSet(PageTitleMenuPDD)
    .wMenuImagePositionSet(PageBtnPositionTop);
    param.wViewController = ^UIViewController * _Nullable(NSInteger index) {
        return NSClassFromString(@"TestVC").new;
    };
    //自定义静态标题 返回了显示的标题对象 可以自行改变
    param.wCustomMenuTitle = ^(NSArray<WMZPageNaviBtn *> * _Nullable titleArr) {
        [titleArr enumerateObjectsUsingBlock:^(WMZPageNaviBtn*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx != titleArr.count-1)
                [obj viewPathWithColor:PageColor(0x666666) pathType:PageShadowPathRight pathWidth:PageK1px heightScale:0.4];
        }];
    };
    //自定义选中标题
    param.wCustomMenuSelectTitle = ^(NSArray<WMZPageNaviBtn *> * _Nullable titleArr) {
        
    };
    
    self.param = param;
}

@end
