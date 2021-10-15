//
//  TopSuspensionView.m
//  WMZPageController
//
//  Created by wmz on 2021/8/9.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "TopSuspensionView.h"
#import "WMZPageProtocol.h"
#import "WMZPageConfig.h"
#import "MJRefresh.h"
#import "Masonry.h"

@interface TopSuspensionView ()<UITableViewDelegate,UITableViewDataSource,WMZPageProtocol>
@property(nonatomic,strong)UITableView *ta;
@end

@implementation TopSuspensionView
- (void)pageViewWillAppear{
    NSLog(@"pageViewWillAppear");
}
- (void)pageViewDidAppear{
    NSLog(@"pageViewDidAppear");
}
- (void)pageViewWillDisappear{
    NSLog(@"pageViewWillDisappear");
}
- (void)pageViewDidDisappear{
    NSLog(@"pageViewDidDisappear");
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

//实现协议 悬浮 必须实现
- (UITableView *)getMyTableView{
    return self.ta;
}

- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    UITableView *ta = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
    [self addSubview:ta];
    
    ta.estimatedRowHeight = 100;
    if (@available(iOS 11.0, *)) {
       ta.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    ta.dataSource = self;
    ta.delegate = self;
    self.ta = ta;
    [self.ta mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    
    __weak TopSuspensionView *weakSelf = self;
    self.ta.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.ta.mj_header endRefreshing];
        });
    }];
    self.ta.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [weakSelf.ta.mj_footer endRefreshing];
        });
    }];
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
    return 15;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.imageView.image = [UIImage imageNamed:@"11111"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-我是UIView内的",self.page];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld-我是UIView内的",self.page];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
@end
