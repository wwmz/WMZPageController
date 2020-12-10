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
@interface WMZMeiTuanSonVC ()<UITableViewDelegate,UITableViewDataSource,WMZPageProtocol>{
    BOOL leftScroll;
}
@property(nonatomic,strong)UITableView *leftTa;
@property(nonatomic,strong)UITableView *rightTa;
@property(nonatomic,assign)CGFloat contentOffset;
@property(nonatomic,assign)CGFloat oldOffset;
@property(nonatomic,assign)BOOL dircetionUp;  //滑动方向
@end

@implementation WMZMeiTuanSonVC

/*
 *本例子只是作为多个滚动视图悬浮的例子 左右的联动需要根据自身的情况调整
 */


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
        _leftTa.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _rightTa.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _leftTa.estimatedSectionFooterHeight = 0.01;
        _leftTa.estimatedSectionHeaderHeight = 0.01;
        _rightTa.estimatedSectionFooterHeight = 0.01;
        _rightTa.estimatedSectionHeaderHeight = 0.01;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    //默认滚动到这里
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.dircetionUp = YES;
//        WMZPageController *superVC = (WMZPageController*)self.parentViewController;
//        [superVC downScrollViewSetOffset:CGPointZero animated:NO];
//        leftScroll = YES;
//        NSInteger num = 5;
//        [self.leftTa scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:num inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
//        [self.leftTa selectRowAtIndexPath:[NSIndexPath indexPathForRow:num inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
//        [self.rightTa scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:num] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//        [self.rightTa selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:num] animated:YES scrollPosition:UITableViewScrollPositionTop];
//    });
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
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
        cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld",indexPath.section,indexPath.row];
        cell.backgroundColor = PageColor(0xeeeeee);
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"测试文本%ld-%ld",indexPath.section,indexPath.row];
    cell.detailTextLabel.text = @"测试详情文本";
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView == self.rightTa) {
        return [NSString stringWithFormat:@"标题%ld",section];
    }
    return @"";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.rightTa) {
        return 30;
    }
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTa) {
        leftScroll = YES;
        WMZPageController *parentVC = (WMZPageController*)self.parentViewController;
        if (indexPath.row == 0) {
            
        }
        //先置顶 再联动
        [parentVC downScrollViewSetOffset:CGPointZero animated:NO];
        //如果设置动画 则延迟0.25秒执行self.rightTa滚动的部分
        [self.rightTa scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [self.rightTa selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //右边联动左边
    if (scrollView == self.rightTa&&!leftScroll) {
        CGFloat newOffsetY = scrollView.contentOffset.y;
        if (newOffsetY > self.oldOffset && self.oldOffset > self.contentOffset){//上滑
            self.dircetionUp = YES;
        }else if(newOffsetY < self.oldOffset && self.oldOffset < self.contentOffset){//下滑
            self.dircetionUp = NO;
        }
        NSIndexPath *firstIndexPath = self.dircetionUp?[self.rightTa indexPathsForVisibleRows].lastObject:[self.rightTa indexPathsForVisibleRows].firstObject;
        NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:firstIndexPath.section inSection:0];
        [self.leftTa scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionNone animated:NO];
        [self.leftTa selectRowAtIndexPath:selectIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        self.oldOffset = scrollView.contentOffset.y;
    }
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView!=self.rightTa) return;
    if (scrollView == self.rightTa){ //左边联动右边的时候
        leftScroll = NO;
        self.contentOffset = scrollView.contentOffset.y;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.oldOffset = scrollView.contentOffset.y;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return tableView == _leftTa?44:80;
}
- (UITableView *)leftTa{
    if (!_leftTa) {
        _leftTa = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTa.dataSource = self;
        _leftTa.delegate = self;
        _leftTa.estimatedRowHeight = 100;
    }
    return _leftTa;
}
- (UITableView *)rightTa{
    if (!_rightTa) {
        _rightTa = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _rightTa.dataSource = self;
        _rightTa.delegate = self;
        _rightTa.estimatedRowHeight = 100;
    }
    return _rightTa;
}

@end
