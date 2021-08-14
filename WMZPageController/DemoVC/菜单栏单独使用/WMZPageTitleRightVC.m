//
//  WMZPageTitleRightVC.m
//  WMZPageController
//
//  Created by wmz on 2021/8/11.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZPageTitleRightVC.h"
#import "WMZPageMunuView.h"

@interface WMZPageTitleRightVC ()<WMZPageMunuDelegate,UITableViewDelegate,UITableViewDataSource>{
    BOOL click;
}
@property (nonatomic, strong) WMZPageMunuView *menuView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation WMZPageTitleRightVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    // Do any additional setup after loading the view.
}

- (void)setupView{
    
    self.dataSource = @[@"TestOne",@"TestTwo",@"TestThree",@"TestFour",@"TestFive",@"TestSix"];
    
    self.menuView = [[WMZPageMunuView alloc]initWithFrame:CGRectMake(0, PageVCNavBarHeight, PageVCWidth, 55)];
    [self.view addSubview:self.menuView];
    self.menuView.menuDelegate = self;
    WMZPageParam *param = WMZPageParam.new;
    param.wTitleArr = [NSArray arrayWithArray:self.dataSource];
    param.wMenuAnimal = PageTitleMenuAiQY;
    self.menuView.param = param;
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        /// 设置默认选中
        [self.menuView setDefaultSelect:0];
        /// 默认0的话 没有滑动动画 要手动关闭click
        self->click = NO;
    });
}

/// 菜单栏点击关联ableview
- (void)titleClick:(WMZPageNaviBtn*)btn fix:(BOOL)fixBtn{
    click = YES;
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:btn.tag] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    click = NO;
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    click = NO;
}
/// tableview滚动关联菜单栏
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (click) return;
    CGPoint point = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    /// 滑动方向
    BOOL dircetionUp = (point.y >= 0);
    NSIndexPath *firstIndexPath = dircetionUp?[self.tableView indexPathsForVisibleRows].lastObject:[self.tableView indexPathsForVisibleRows].firstObject;
    firstIndexPath = [self.tableView indexPathsForVisibleRows].firstObject;
    [self.menuView scrollToIndex:firstIndexPath.section animal:NO];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.dataSource[section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"测试";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-  (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,  CGRectGetMaxY(self.menuView.frame), self.view.bounds.size.width, self.view.bounds.size.height - PageVCNavBarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
