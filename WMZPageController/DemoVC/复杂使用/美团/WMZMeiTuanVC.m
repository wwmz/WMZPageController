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
       WMZPageParam *param = PageParam()
       .wTitleArrSet(data)
       .wViewControllerSet(^UIViewController *(NSInteger index) {
          return [WMZMeiTuanSonVC new];
        })
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
           back.frame = CGRectMake(0, 0, PageVCWidth, 300);
           UIImageView *image = [UIImageView new];
           [image sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1602673230263&di=c9290650541d8edf911ff008a3bfa4dc&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2Ff%2F33%2F648011013.jpg"]];
           image.frame =back.bounds;
           [back addSubview:image];
           return back;
       });
      self.param = param;

}



@end
