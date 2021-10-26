//
//  WKViewController.m
//  WMZPageController
//
//  Created by wmz on 2021/10/25.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WKViewController.h"
#import <WebKit/WebKit.h>
#import "Masonry.h"
#import "WMZPageProtocol.h"

@interface WKViewController ()<WMZPageProtocol>
@property (nonatomic, strong) WKWebView *mapView;
@end

@implementation WKViewController

/// 返回滚动的部分
- (UIScrollView *)getMyScrollView{
    return self.mapView.scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView = WKWebView.new;
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        if (@available(iOS 11.0, *)) {
            if (self.parentViewController.hidesBottomBarWhenPushed) {
                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            }else{
                make.bottom.mas_equalTo(0);
            }
        } else {
            make.bottom.mas_equalTo(0);
        }
    }];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [self.mapView loadRequest:request];
}


@end
