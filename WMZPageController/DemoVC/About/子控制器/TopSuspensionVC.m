//
//  TopSuspensionVC.m
//  WMZPageController
//
//  Created by wmz on 2019/12/13.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "TopSuspensionVC.h"
#import "WMZPageProtocol.h"
#import "WMZPageConfig.h"
#import "MJRefresh.h"
#import "Masonry.h"

@interface TopSuspensionVC ()<UITableViewDelegate,UITableViewDataSource,WMZPageProtocol>
@property (nonatomic, strong) UITableView *ta;
@end

@implementation TopSuspensionVC

#pragma mark 注意 可以重新适配tableview的frame 如果你已经适配好了tableview的frame就不用
//- (void)viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
//    self.ta.frame = self.view.bounds;
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear %ld",self.page);
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear %ld",self.page);
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear %ld",self.page);
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear %ld",self.page);
}


//实现协议 悬浮 必须实现
- (UIScrollView *)getMyScrollView{
    return self.ta;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *ta = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:ta];
    
    ta.estimatedRowHeight = 100;
    if (@available(iOS 11.0, *)) {
       ta.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    ta.dataSource = self;
    ta.delegate = self;
    ta.tag = self.page;
    self.ta = ta;
    [self.ta mas_makeConstraints:^(MASConstraintMaker *make) {
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

    // 下拉刷新
    __weak TopSuspensionVC *weakSelf = self;
    self.ta.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.ta.mj_header endRefreshing];
        });
    }];


      // 上拉刷新
    self.ta.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [weakSelf.ta.mj_footer endRefreshing];
        });
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.ta.mj_header.automaticallyChangeAlpha = YES;

}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.imageView.image = [UIImage imageNamed:@"11111"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-我是UIViewController内的",self.page];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld-我是UIViewController内的",self.page];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (void)dealloc{
    NSLog(@"dealloc %@",NSStringFromClass([self class]));
}
- (NSString *)description{
    return [NSString stringWithFormat:@"VC %ld",self.page];
}

@end
