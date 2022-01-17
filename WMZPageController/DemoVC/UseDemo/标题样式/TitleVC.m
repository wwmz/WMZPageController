


//
//  TitleVC.m
//  WMZPageController
//
//  Created by wmz on 2019/10/10.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "TitleVC.h"
#import "TestVC.h"
#import "UIButton+WebCache.h"
@implementation TitleVC


- (void)viewDidLoad{
    [super viewDidLoad];
    
      NSInteger index = self.index.integerValue; 
    
     //数据
        NSDictionary *dic = @{
              @(0):@"redTipData",
              @(1):@"imageData",
              @(2):@"imageData",
              @(3):@"textData",
              @(4):@"fixData",
              @(5):@"textData",
              @(6):@"textData",
              @(7):@"fixData",
          };
        //位置
        NSDictionary *position = @{
              @(0):@(PageMenuPositionLeft),
              @(1):@(PageMenuPositionLeft),
              @(2):@(PageMenuPositionBottom),
              @(3):@(PageMenuPositionNavi),
              @(4):@(PageMenuPositionCenter),
              @(5):@(PageMenuPositionLeft),
              @(6):@(PageMenuPositionLeft),
              @(7):@(PageMenuPositionLeft),
          };
        NSArray *data = [self performSelector:NSSelectorFromString(dic[@(index)]) withObject:nil];
        WMZPageParam *param =
        PageParam()
        .wTitleArrSet(data)
        .wViewControllerSet(^UIViewController *(NSInteger index) {
            TestVC *vc = [TestVC new];
            vc.page = index;
            return vc;
        })
        .wCustomMenuViewSet(^(UIView *bgView) {
    //        bgView.alpha = 0.5;
        })
        .wMenuWidthSet(PageVCWidth)
        .wMenuDefaultIndexSet(1)
       //自定义红点 调整颜色 位置等
       .wCustomRedViewSet(^(UILabel *redLa,NSDictionary *info) {

        })
        .wMenuPositionSet([position[@(index)] intValue]);
        /// 右侧标题
        if (index == 5) {
            param.wMenuFixRightDataSet(@"≡");
        }
    
        /// 右侧图文标题
        if (index == 6) {
            param.wMenuImagePositionSet(PageBtnPositionLeft)
                 .wMenuFixRightDataSet(@{WMZPageKeyName:@"金币",WMZPageKeyImage:@"B"})
            .wEventFixedClickSet(^(id anyID, NSInteger index) {
                NSLog(@"固定标题点击%ld",(long)index);
                //模拟更新
                [self.upSc.btnArr enumerateObjectsUsingBlock:^(WMZPageNaviBtn*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (obj.tag == 10086) {
                        [obj setTitle:@"更新" forState:UIControlStateNormal];
                        *stop = YES;
                    }
                }];
            });
        }
    
        /// 固定标题宽度
        if (index == 7) {
            param.wMenuTitleWidthSet(PageVCWidth/3);
        }

        self.param = param;
}


- (void)action{
    
}

//普通标题
- (NSArray*)textData{
    return @[@"推荐",@"LOOK直播",@"画",@"现场",@"翻唱",@"MV",@"广场",@"游戏"];
}

//带红点普通标题   badge红点   
- (NSArray*)redTipData{
    return @[
        @{WMZPageKeyName:@"推荐",WMZPageKeyBadge:@(10)},
        @"LOOK直播",
        @{WMZPageKeyName:@"翻唱",WMZPageKeyBadge:@"99+"},
        @"MV",
        @"广场",
        @{WMZPageKeyName:@"游戏",WMZPageKeyBadge:@(-1)},
    ];
}

//图片  image图片  selectImage选中图片
- (NSArray*)imageData{
    return @[
        @{WMZPageKeyName:@"推荐",WMZPageKeyImage:@"B",WMZPageKeySelectImage:@"D"},
        @{WMZPageKeyName:@"LOOK直播",WMZPageKeyImage:@"C",WMZPageKeySelectImage:@"D"},
        @{WMZPageKeyName:@"画",WMZPageKeyImage:@"B",WMZPageKeySelectImage:@"D"},
        @{WMZPageKeyName:@"现场",WMZPageKeyImage:@"C",WMZPageKeySelectImage:@"D"},
        @{WMZPageKeyName:@"翻唱",WMZPageKeyBadge:@(9),WMZPageKeyImage:@"B",WMZPageKeySelectImage:@"D"},
        @{WMZPageKeyName:@"MV",WMZPageKeyImage:@"C",WMZPageKeySelectImage:@"D"},
        @{WMZPageKeyName:@"游戏",WMZPageKeyBadge:@(-1),WMZPageKeyImage:@"B",WMZPageKeySelectImage:@"D"},
        @{WMZPageKeyName:@"广场",WMZPageKeyImage:@"C",WMZPageKeySelectImage:@"D"},
    ];
}
//固定宽度标题
- (NSArray*)fixData{
    return @[@"推荐",@"热点",@"关注"];
}

@end
