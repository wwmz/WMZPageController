



//
//  IndicatorVC.m
//  WMZPageController
//
//  Created by wmz on 2019/10/10.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "IndicatorVC.h"
@implementation IndicatorVC


- (void)pushWithVC:(UIViewController *)vc withIndex:(NSInteger)index{

    //动画
    NSDictionary *animal = @{
          @(0):@(PageTitleMenuNone),
          @(1):@(PageTitleMenuLine),
          @(2):@(PageTitleMenuAiQY),
          @(3):@(PageTitleMenuTouTiao),
          @(4):@(PageTitleMenuYouKu),
          @(5):@(PageTitleMenuCircle),
      };
    
    NSArray *data = [self textData];
    NSMutableArray *vcArr = [NSMutableArray new];
    [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TestVC *vc = [TestVC new];
        vc.page = idx;
        [vcArr addObject:vc];
    }];
    
    WMZPageParam *param = PageParam()
    .wTitleArrSet(data)
    .wControllersSet(vcArr)
    .wMenuAnimalSet([animal[@(index)] intValue]);
    WMZPageController *VC =  [WMZPageController new];
    VC.param = param;
    [vc.navigationController pushViewController:VC animated:YES];
}
//普通标题
- (NSArray*)textData{
    return @[@"推荐",@"LOOK直播",@"画",@"现场",@"翻唱",@"MV",@"广场",@"游戏"];
}

@end
