//
//  GuestureViewController.m
//  WMZPageController
//
//  Created by wmz on 2021/10/14.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "GuestureViewController.h"

@interface GuestureViewController ()

@end

@implementation GuestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customNavi:@[@"不响应",@"首个响应",@"全部响应"]];
    
    WMZPageParam *param = WMZPageParam.new;
    param.wTitleArr = @[@"精选",@"好货",@"精选",@"好货"];
    param.wViewController = ^UIViewController * _Nullable(NSInteger index) {
        return NSClassFromString(@"TestVC").new;
    };
    /// 首个响应
    param.wRespondGuestureType = PagePopFirst;
//    /// 全部响应
//    param.wRespondGuestureType = PagePopAll;
//    /// 不响应
//    param.wRespondGuestureType = PagePopNone;
    
    ///type为PagePopAll时的响应范围
    param.wGlobalTriggerOffset = PageVCWidth * 0.15;
    self.param = param;
    
    
//    param.wMenuBgColorSet(UIColor.redColor);
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        UIView *contailView = self.upSc.mainView;
//        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:contailView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20,20)];
//        CAShapeLayer *markLayer = [[CAShapeLayer alloc]init];
//        markLayer.frame = contailView.bounds;
//        markLayer.path = path.CGPath;
//        contailView.layer.mask = markLayer;
//    });
}

- (void)customNavi:(NSArray*)arr{
    NSMutableArray *marr = NSMutableArray.new;
    for (int i = 0; i<arr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [marr addObject:barItem];
    }
    self.navigationItem.rightBarButtonItems = marr;
}

- (void)onBtnAction:(UIButton*)sender{
    self.param.wMenuDefaultIndex = sender.tag == 2 ? 1 : 0;
    
    /// 响应调用代码
    self.param.wRespondGuestureType = sender.tag;
    [self updateMenuData];
}

@end
