//
//  WMZMeiTuanVC.m
//  WMZPageController
//
//  Created by wmz on 2020/7/23.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZMeiTuanVC.h"
#import "UIImageView+WebCache.h"
#import "WMZMeiTuanSonVC.h"
@interface WMZMeiTuanVC ()
@end

@implementation WMZMeiTuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
       NSArray *data = @[@"点菜",@"评价",@"商家"];
       //控制器数组
       NSMutableArray *vcArr = [NSMutableArray new];
       [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           WMZMeiTuanSonVC *vc = [WMZMeiTuanSonVC new];
           [vcArr addObject:vc];
       }];
       
       WMZPageParam *param = PageParam()
       .wTitleArrSet(data)
       .wControllersSet(vcArr)
       //悬浮开启
       .wTopSuspensionSet(YES)
       .wMenuAnimalSet(PageTitleMenuAiQY)
       .wMenuTitleWidthSet(self.view.frame.size.width / 5)
       //头视图y坐标从0开始
       .wFromNaviSet(NO)
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
       });
      self.param = param;
    
}



@end
