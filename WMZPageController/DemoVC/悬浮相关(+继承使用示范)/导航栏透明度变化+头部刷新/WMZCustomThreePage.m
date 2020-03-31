

//
//  WMZCustomThreePage.m
//  WMZPageController
//
//  Created by wmz on 2019/12/13.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZCustomThreePage.h"
#import "CollectionViewPopDemo.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
@interface WMZCustomThreePage ()

@end

@implementation WMZCustomThreePage

- (void)viewDidLoad {
    [super viewDidLoad];
       __weak WMZCustomThreePage* weakSelf = self;
       self.view.backgroundColor = [UIColor whiteColor];
       self.navigationItem.title = @"导航栏标题";
      //默认标题透明度0
      [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:10/255.0 green:10/255.0 blue:20/255.0 alpha:0]}];
     //标题数组
        NSArray *data = @[@"热门",@"男装",@"美妆",@"手机",@"食品",@"电器",@"鞋包",@"百货",@"女装",@"汽车",@"电脑"];
        //控制器数组
        NSMutableArray *vcArr = [NSMutableArray new];
        [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CollectionViewPopDemo *vc = [CollectionViewPopDemo new];
            [vcArr addObject:vc];
        }];
        
        WMZPageParam *param = PageParam()
        .wTitleArrSet(data)
        .wControllersSet(vcArr)
        //悬浮开启
        .wTopSuspensionSet(YES)
        //顶部可下拉
        .wBouncesSet(YES)
        //头视图y坐标从0开始
        .wFromNaviSet(NO)
        //导航栏透明度变化
        .wNaviAlphaSet(YES)
        //头部
        .wMenuHeadViewSet(^UIView *{
            UIView *back = [UIView new];
            back.frame = CGRectMake(0, 0, PageVCWidth, 470);
            UIImageView *image = [UIImageView new];
            [image sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576232579082&di=f6ae983436a2512d41ed5b25789cf212&imgtype=0&src=http%3A%2F%2Fbig5.ocn.com.cn%2FUpload%2Fuserfiles%2F18%252858%2529.png"]];
            image.frame =back.bounds;
            [back addSubview:image];
            return back;
        })
        //导航栏标题透明度变化
        .wEventChildVCDidSrollSet(^(UIViewController *pageVC, CGPoint oldPoint, CGPoint newPonit, UIScrollView *currentScrollView) {
             __strong WMZCustomThreePage* strongSelf = weakSelf;
            [strongSelf.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:10/255.0 green:10/255.0 blue:20/255.0 alpha:newPonit.y/(470-PageVCNavBarHeight)]}];
        });
        
        self.param = param;
    
      //延时0.1秒
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 下拉刷新
          __weak WMZCustomThreePage *weakSelf = self;
          self.downSc.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
              dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                  [weakSelf.downSc.mj_header endRefreshing];
              });
          }];
           
      });
    
}

@end
