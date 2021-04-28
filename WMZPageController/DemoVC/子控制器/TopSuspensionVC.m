//
//  TopSuspensionVC.m
//  WMZPageController
//
//  Created by wmz on 2019/12/13.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "TopSuspensionVC.h"
#import "WMZBannerView.h"
#import "WMZPageProtocol.h"
#import "WMZPageConfig.h"
#import "MJRefresh.h"
@interface TopSuspensionVC ()<UITableViewDelegate,UITableViewDataSource,WMZPageProtocol>
@property(nonatomic,strong)UITableView *ta;
@property(nonatomic,strong)NSArray *bannerData;
@property(nonatomic,strong)WMZBannerView *headView;
@property(nonatomic,strong)WMZBannerParam *param;
@end

@implementation TopSuspensionVC

#pragma mark 注意 可以重新适配tableview的frame 如果你已经适配好了tableview的frame就不用
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.ta.frame = self.view.bounds;
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
    
    ta.estimatedRowHeight = 100;
    if (@available(iOS 11.0, *)) {
       ta.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    ta.dataSource = self;
    ta.delegate = self;
    ta.tag = self.page;
    _bannerData = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576232578984&di=7170b5a1e3350fc3060db6929bc49a10&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn10109%2F217%2Fw641h376%2F20191211%2Fa46d-iknhexi8336167.jpg",
                                      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576232579069&di=d0ff7d27c7d65928aaa2a472094552a9&imgtype=0&src=http%3A%2F%2Fi0.hdslb.com%2Fbfs%2Farticle%2F5b13843d414928b145f37cf958c1dfdac6759cd3.jpg",
                                      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576232579067&di=c3ecf1fc284f48dd91464085a95db96d&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn12%2F328%2Fw640h488%2F20180612%2F0052-hcufqih6006139.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576232579067&di=c2441db655c6ffddb3fe0a04aba4d37b&imgtype=0&src=http%3A%2F%2Fc.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Fca1349540923dd54ac050f37da09b3de9c82487f.jpg"];
    self.ta = ta;
    self.param =  BannerParam()
    .wFrameSet(CGRectMake(0, 0, BannerWitdh, BannerHeight/5))
    .wDataSet(self.bannerData)
    .wRepeatSet(YES);
    self.headView = [[WMZBannerView alloc]initConfigureWithModel:self.param];
//    ta.tableHeaderView = self.headView;

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
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-路飞",self.page];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld-红发",self.page];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = @"WMZCustomThreePage";
    UIViewController *vc = [NSClassFromString(str) new];
//    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
