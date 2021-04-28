


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
#import "WMZBannerView.h"
#import "MJRefresh.h"
#import "WMZUsePageVC.h"
@interface FixSonVC ()<UITableViewDelegate,UITableViewDataSource,WMZPageProtocol>{
    BOOL sss;
}
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UITableView *ta;
@property(nonatomic,strong)NSArray *bannerData;
@property(nonatomic,strong)WMZBannerView *headView;
@property(nonatomic,strong)WMZBannerParam *param;
@end

@implementation FixSonVC

//固定底部 首先要把高度赋值上
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor redColor];
        _bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.ta.frame), self.view.bounds.size.width, 50);
    }
    return _bottomView;
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.ta.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-50);
}

//实现固定底部协议
- (UIView *)fixFooterView{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UILabel *la = UILabel.new;
        la.text = @"asdsaddad";
        [self.bottomView addSubview:la];
        la.frame = self.bottomView.bounds;
    });
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
    ta.tableHeaderView = self.headView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onBtnAction:) name:@"setDowmScContenOffset" object:nil];

}

- (void)onBtnAction:(id)sender{
    [self scrollTableToFoot:NO];

    //模拟键盘弹出改变底部视图的frame
//    sss = !sss;
//    WMZUsePageVC *vc = (WMZUsePageVC*)self.parentViewController;
//    vc.footViewOrginY = sss?400:(PageVCHeight-PageVCTabBarHeight-50);
//    [self.bottomView page_y:sss?400:(PageVCHeight-PageVCTabBarHeight-50)];
}

- (void)scrollTableToFoot:(BOOL)animated
{
    NSInteger s = [self.ta numberOfSections];
    if (s<1) return;
    NSInteger r = [self.ta numberOfRowsInSection:s-1];
    if (r<1) return;
    NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];
    [self.ta scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated];
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
    
    cell.textLabel.text = @"路飞";
    cell.detailTextLabel.text = @"路飞";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
