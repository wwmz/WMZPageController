


//
//  FixSonVC.m
//  WMZPageController
//
//  Created by wmz on 2020/1/6.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "FixSonVC.h"
#import "WMZPageProtocol.h"
#import "WMZPageConfig.h"
#import "MJRefresh.h"
#import "Masonry.h"

@interface FixSonVC ()<UITableViewDelegate,UITableViewDataSource,WMZPageProtocol>
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UITableView *ta;
@end

@implementation FixSonVC

//实现固定底部协议
- (UIView *)fixFooterView{
    return self.bottomView;
}

//实现协议 悬浮 必须实现
- (UITableView *)getMyTableView{
    return self.ta;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *ta = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:ta];
    
    if (@available(iOS 11.0, *)) {
       ta.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
       ta.estimatedRowHeight = 0.01;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    ta.dataSource = self;
    ta.delegate = self;
    self.ta = ta;
    [self.ta mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-50);
    }];
    
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
    cell.textLabel.text = @"我是UIViewController内的";
    cell.detailTextLabel.text = @"我是UIViewController内的";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
//固定底部 首先要把高度赋值上
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor redColor];
        _bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.ta.frame), self.view.bounds.size.width, 50);
        
        UILabel *la = UILabel.new;
        la.text = @"\t\t文本";
        [_bottomView addSubview:la];
        la.frame = self.bottomView.bounds;
    }
    return _bottomView;
}
@end
