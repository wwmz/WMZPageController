//
//  WMZDynamicOperatVC.m
//  WMZPageController
//
//  Created by wmz on 2020/12/17.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZDynamicOperatVC.h"
#import "TopSuspensionVC.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
@interface WMZDynamicOperatVC ()

@end

@implementation WMZDynamicOperatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"看demo";
    //标题数组
    NSArray *data = @[@"热门",@"男装",@"美妆",@"手机"];
    NSMutableArray *controllerArr = [NSMutableArray new];
    for (int i = 0; i<data.count; i++) {
        TopSuspensionVC *vc = [TopSuspensionVC new];
        vc.page = i;
        [controllerArr addObject:vc];
    }
    WMZPageParam *param = PageParam()
    .wTitleArrSet(data)
    .wMenuAnimalSet(PageTitleMenuPDD)
    .wMenuDefaultIndexSet(3)
    .wControllersSet(controllerArr);  //必须使用此属性
    self.param = param;
    
    UIButton *titleDelete = [self getBtnTitle:@"删除"];
    [titleDelete addTarget:self action:@selector(deleteAcction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *titleDeleteBarItem = [[UIBarButtonItem alloc] initWithCustomView:titleDelete];
    self.navigationItem.rightBarButtonItem = titleDeleteBarItem;

    UIButton *titleAdd = [self getBtnTitle:@"增加"];
    [titleAdd addTarget:self action:@selector(addAcction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *titleAddBarItem = [[UIBarButtonItem alloc] initWithCustomView:titleAdd];
    
    
    UIButton *titleUpdate = [self getBtnTitle:@"更新"];
    [titleUpdate addTarget:self action:@selector(updateAcction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *titleUpdateBarItem = [[UIBarButtonItem alloc] initWithCustomView:titleUpdate];
    
    
    UIButton *back = [self getBtnTitle:@"返回"];
    [back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[titleAddBarItem,titleUpdateBarItem];
    self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:back],titleDeleteBarItem];
}

- (void)updateAcction{
    [self exchangeMenuDataAtIndex:0 withMenuDataAtIndex:1];
}

- (void)deleteAcction{
    //下标删除
   BOOL succcess1 =  [self deleteMenuTitleIndex:@(3)];

//    //标题删除
//   BOOL succcess2 =  [self deleteMenuTitleIndex:@"食品"];
//
//    //删除数组
//   BOOL succcess3 =  [self deleteMenuTitleIndexArr:@[@"食品",@(1)]];
   NSLog(@"%d",succcess1);
}

- (void)addAcction{
    

    TopSuspensionVC *AddVC = [TopSuspensionVC new];
    AddVC.page = 20;
    //增加文本标题
    BOOL succcess1 =  [self addMenuTitleWithObject:[WMZPageTitleDataModel initWithIndex:0 controller:AddVC title:@"增加的标题"]];
    
//    TopSuspensionVC *AddVC2 = [TopSuspensionVC new];
//    AddVC2.page = 30;
//    //增加字典标题
//    BOOL succcess2 =  [self addMenuTitleWithObject:[WMZPageTitleDataModel initWithIndex:3 controller:AddVC2 titleInfo:@{@"name":@"字典标题",@"titleColor":[UIColor orangeColor]}]];
//    
//    //增加数组
//    BOOL succcess3 =  [self addMenuTitleWithObjectArr:@[
//     [WMZPageTitleDataModel initWithIndex:5 controller:[TopSuspensionVC new] title:@"增加的标题5"],
//     [WMZPageTitleDataModel initWithIndex:6 controller:[TopSuspensionVC new] title:@"增加的标题6"],
//    ]];
    NSLog(@"%d ",succcess1);
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton*)getBtnTitle:(NSString*)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn sizeToFit];
    return btn;
}

@end
