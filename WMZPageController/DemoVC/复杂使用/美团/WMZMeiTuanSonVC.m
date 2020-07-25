//
//  WMZMeiTuanSonVC.m
//  WMZPageController
//
//  Created by wmz on 2020/7/25.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZMeiTuanSonVC.h"
#import "WMZPageProtocol.h"
#import "WMZPageController.h"
@interface WMZMeiTuanSonVC ()<UITableViewDelegate,UITableViewDataSource,WMZPageProtocol>
@property(nonatomic,strong)UITableView *leftTa;
@property(nonatomic,strong)UITableView *rightTa;
@end

@implementation WMZMeiTuanSonVC
//实现协议 悬浮 数组协议 左右联动
- (NSArray *)getMyScrollViews{
    return @[self.leftTa,self.rightTa];
}

-  (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.leftTa.frame = CGRectMake(0, 0, self.view.bounds.size.width*0.3, self.view.bounds.size.height);
    self.rightTa.frame = CGRectMake(CGRectGetMaxX(self.leftTa.frame), 0, self.view.bounds.size.width*0.7, self.view.bounds.size.height);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.leftTa];
    [self.view addSubview:self.rightTa];
    if (@available(iOS 11.0, *)) {
       _leftTa.estimatedSectionFooterHeight = 0.01;
       _leftTa.estimatedSectionHeaderHeight = 0.01;
       _rightTa.estimatedSectionFooterHeight = 0.01;
       _rightTa.estimatedSectionHeaderHeight = 0.01;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = PageColor(0xeeeeee);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableView == _leftTa?20:5;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return tableView == _leftTa?1:20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTa) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = @"测试文本";
        cell.backgroundColor = PageColor(0xeeeeee);
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"测试文本";
    cell.detailTextLabel.text = @"测试详情文本";
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTa) {
        WMZPageController *parentVC = (WMZPageController*)self.parentViewController;
        //先置顶 再联动
        [parentVC downScrollViewSetOffset:CGPointZero animated:YES];
        [self.rightTa scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }else{
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return tableView == _leftTa?44:80;
}

- (UITableView *)leftTa{
    if (!_leftTa) {
        _leftTa = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTa.dataSource = self;
        _leftTa.delegate = self;
    }
    return _leftTa;
}
- (UITableView *)rightTa{
    if (!_rightTa) {
        _rightTa = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _rightTa.dataSource = self;
        _rightTa.delegate = self;
    }
    return _rightTa;
}

@end
