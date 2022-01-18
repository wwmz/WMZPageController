//
//  WMZPageFixAllVC.m
//  WMZPageController
//
//  Created by wmz on 2021/8/11.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZPageFixAllVC.h"

@interface WMZPageFixAllVC ()
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation WMZPageFixAllVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WMZPageParam *param = WMZPageParam.new;
    param.wTitleArr = @[@"fixOne",@"fixTwo",@"fixThree"];
    param.wCustomTabbarY = ^CGFloat(CGFloat nowY) {
        return 50;
    };
    param.wMenuFixWidth = PageVCWidth/3;
    param.wViewController = ^UIViewController * _Nullable(NSInteger index) {
        return NSClassFromString(@"TestVC").new;
    };
    self.param = param;

    [self.view addSubview:self.bottomView];
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 50)];
        _bottomView.backgroundColor = [UIColor redColor];
    }
    return _bottomView;
}


@end
