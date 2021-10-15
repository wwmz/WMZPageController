


//
//  WMZDemoOneSonVC.m
//  WMZPageController
//
//  Created by wmz on 2020/6/4.
//  Copyright © 2020 wmz. All rights reserved.
//

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#import "WMZDemoOneSonVC.h"
#import "WMZPageConfig.h"
#import "MJRefresh.h"
#import "WMZDemoOne.h"
static NSString *const CollectionViewCell = @"CollectionViewCell";
@interface WMZDemoOneSonVC ()<UICollectionViewDelegate, UICollectionViewDataSource,WMZPageProtocol>
@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation WMZDemoOneSonVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    WMZDemoOne *parentVC = (WMZDemoOne*)self.navigationController.parentViewController;
    [parentVC.upSc.mainView setHidden:NO];
}

//实现协议 悬浮 必须实现
- (UIScrollView *)getMyScrollView{
    return self.collectionView;
}

#pragma mark 注意 可以重新适配tableview的frame 如果你已经适配好了tableview的frame就不用
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCell];
      // 上拉刷新
    __weak WMZDemoOneSonVC *weakSelf = self;
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [weakSelf.collectionView.mj_footer endRefreshing];
        });
    }];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCell forIndexPath:indexPath];
    cell.backgroundColor = randomColor;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [NSClassFromString(@"HomeVC") new];
    WMZDemoOne *parentVC = (WMZDemoOne*)self.navigationController.parentViewController;
    [parentVC.upSc.mainView setHidden:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [UICollectionViewFlowLayout new];
        flow.itemSize = CGSizeMake(PageVCWidth/2 - 30, 100);
        flow.minimumLineSpacing = 10;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, PageVCWidth, PageVCHeight-100) collectionViewLayout:flow];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

@end

