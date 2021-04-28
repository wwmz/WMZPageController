//
//  TestVC.m
//  WMZPageController
//
//  Created by wmz on 2019/9/17.
//  Copyright © 2019 wmz. All rights reserved.
//


#import "TestVC.h"
#import "WMZBannerView.h"
#import "WMZPageProtocol.h"
#import "MJRefresh.h"
@interface TestVC ()<UITableViewDelegate,UITableViewDataSource,WMZPageProtocol>
@property(nonatomic,strong)UITableView *ta;
@property(nonatomic,strong)NSArray *bannerData;
@property(nonatomic,strong)WMZBannerView *headView;
@property(nonatomic,strong)WMZBannerParam *param;
@end

@implementation TestVC

- (UIScrollView *)getMyScrollView{
    return self.ta;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear %ld",(long)self.page);
}

#pragma mark 注意 可以重新适配tableview的frame 如果你已经适配好了tableview的frame就不用
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.ta.frame = self.view.bounds;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear %ld",(long)self.page);
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear %ld",(long)self.page);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad %ld",(long)self.page);
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
    ta.tag = self.page;
    _bannerData = @[@"https://upload-images.jianshu.io/upload_images/9163368-92b42a0c11caa7a3.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                                      @"https://upload-images.jianshu.io/upload_images/9163368-e9a09d9dbe63b68b.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                                      @"https://upload-images.jianshu.io/upload_images/9163368-dc97bebf2f743a60.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                                  @"https://upload-images.jianshu.io/upload_images/9163368-02e26751674a3bc6.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
    self.ta = ta;
    self.param =  BannerParam()
    .wFrameSet(CGRectMake(0, 0, BannerWitdh, BannerHeight/5))
    .wDataSet(self.bannerData)
    .wRepeatSet(YES);
    self.headView = [[WMZBannerView alloc]initConfigureWithModel:self.param];
    ta.tableHeaderView = self.headView;

    // 下拉刷新
    __weak TestVC *weakSelf = self;
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }

    UIImage * icon = cell.imageView.image;
    CGSize itemSize = CGSizeMake(36, 36);//固定图片大小为36*36
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);//*1
    CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
    [icon drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();//*2
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/9163368-dc97bebf2f743a60.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"]];
    UIGraphicsEndImageContext();//*3
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-路飞",(long)self.page];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld-红发",(long)self.page];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[TestVC new] animated:YES];
}

@end
