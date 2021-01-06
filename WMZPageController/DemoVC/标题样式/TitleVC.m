


//
//  TitleVC.m
//  WMZPageController
//
//  Created by wmz on 2019/10/10.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "TitleVC.h"
#import "TestVC.h"
@implementation TitleVC


- (void)viewDidLoad{
    [super viewDidLoad];
    
      NSInteger index = self.index.integerValue; 
    
     //数据
        NSDictionary *dic = @{
              @(0):@"textData",
              @(1):@"lineBreakData",
              @(2):@"redTipData",
              @(3):@"attributesData",
              @(4):@"imageData",
              @(5):@"imageData",
              @(6):@"textData",
              @(7):@"textData",
              @(8):@"textData",
              @(9):@"textData",
              @(10):@"fixData",
              @(11):@"textData",
          };
        //位置
        NSDictionary *position = @{
              @(0):@(PageMenuPositionLeft),
              @(1):@(PageMenuPositionLeft),
              @(2):@(PageMenuPositionLeft),
              @(3):@(PageMenuPositionLeft),
              @(4):@(PageMenuPositionLeft),
              @(5):@(PageMenuPositionBottom),
              @(6):@(PageMenuPositionNavi),
              @(7):@(PageMenuPositionCenter),
              @(8):@(PageMenuPositionLeft),
              @(9):@(PageMenuPositionLeft),
              @(10):@(PageMenuPositionLeft),
              @(11):@(PageMenuPositionLeft),
          };
        //菜单宽度
        NSDictionary *widthDic = @{
             @(0):@(PageVCWidth),
             @(1):@(PageVCWidth),
             @(2):@(PageVCWidth),
             @(3):@(PageVCWidth),
             @(4):@(PageVCWidth),
             @(5):@(PageVCWidth),
             @(6):@(PageVCWidth*0.6),
             @(7):@(PageVCWidth*0.7),
             @(8):@(PageVCWidth),
             @(9):@(PageVCWidth),
             @(10):@(PageVCWidth),
             @(11):@(PageVCWidth),
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
        .wMenuWidthSet([widthDic[@(index)] floatValue])
        .wMenuDefaultIndexSet(2)
        .wMenuPositionSet([position[@(index)] intValue]);    
        if (index == 6) {
            param.wMenuAnimalSet(PageTitleMenuPDD);
        }

        if (index == 8) {
            param.wMenuFixRightDataSet(@"≡");
        }
    
        if (index == 9) {
            param.wMenuImagePositionSet(PageBtnPositionLeft)
                 .wMenuFixRightDataSet(@{@"name":@"金币",@"image":@"B"})
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
    
        if (index == 10) {
            param.wMenuTitleWidthSet(PageVCWidth/3);
        }
    
        //自定义标题
        if (index == 11) {
            param.wMenuBgColorSet(PageColor(0xf8f6f8))
            .wMenuCellMarginYSet(10)
            .wMenuTitleWidthSet(100)
            .wMenuAnimalSet(PageTitleMenuPDD)
            //自定义静态标题
            .wCustomMenuTitleSet(^(NSArray *titleArr) {
                [titleArr enumerateObjectsUsingBlock:^(WMZPageNaviBtn*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (idx!=titleArr.count-1) {
                    [obj viewPathWithColor:PageColor(0x666666) PathType:PageShadowPathRight PathWidth:PageK1px heightScale:0.4];
                    }
                }];
            })
            //自定义滑动后标题的变化
            .wCustomMenuSelectTitleSet(^(NSArray *titleArr) {
                for (WMZPageNaviBtn *obj in titleArr) {
                    if (obj.isSelected) {
                        
                        break;
                    }
                }
                [titleArr enumerateObjectsUsingBlock:^(WMZPageNaviBtn*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                           if (obj.isSelected) {
                                obj.layer.masksToBounds = YES;
                               [obj setRadii:CGSizeMake(10, 10) RoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight];
                                obj.backgroundColor = [UIColor whiteColor];
                           }else{
                              [obj setRadii:CGSizeMake(0, 0) RoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight];
                               obj.backgroundColor = PageColor(0xf8f6f8);
                           }
                       }];
            });
        }
        self.param = param;
    
    
    if (index == 7) {
        self.upSc.backgroundColor = [UIColor whiteColor];
    }
}

//普通标题
- (NSArray*)textData{
    return @[@"推荐",@"LOOK直播",@"画",@"现场",@"翻唱",@"MV",@"广场",@"游戏"];
}

//换行标题
- (NSArray*)lineBreakData{
    return @[@"推荐\n10",@"LOOK直播\n100",@"画\n1000",@"现场\n6",@"翻唱\n4",@"MV\n好看的MV",@"广场\n4",@"游戏\n30"];
}

//带红点普通标题   badge红点
- (NSArray*)redTipData{
    return @[
        @{@"name":@"推荐",@"badge":@(YES)},
        @"LOOK直播",
        @"画",
        @"现场",
        @{@"name":@"翻唱",@"badge":@(YES)},
        @"MV",
        @"广场",
        @{@"name":@"游戏",@"badge":@(YES)},
    ];
}

//带富文本  wrapColor第二行标题  firstColor第一行标题
- (NSArray*)attributesData{
    return @[
        @{@"name":@"推荐\n10",@"wrapColor":[UIColor brownColor]},
        @"LOOK直播\n10",
        @{@"name":@"画\n10",@"badge":@(YES),@"wrapColor":[UIColor purpleColor]},
        @"现场\n10",
        @{@"name":@"翻唱\n10",@"wrapColor":[UIColor blueColor],@"firstColor":[UIColor cyanColor]},
        @"MV\n10",
        @"MV\n10",
        @{@"name":@"游戏\n10",@"badge":@(YES),@"wrapColor":[UIColor yellowColor]},
    ];
}

//图片  image图片  selectImage选中图片
- (NSArray*)imageData{
    return @[
        @{@"name":@"推荐",@"image":@"B",@"selectImage":@"D"},
        @{@"name":@"LOOK直播",@"image":@"C",@"selectImage":@"D"},
        @{@"name":@"画",@"image":@"B",@"selectImage":@"D"},
        @{@"name":@"现场",@"image":@"C",@"selectImage":@"D"},
        @{@"name":@"翻唱",@"badge":@(9),@"image":@"B",@"selectImage":@"D"},
        @{@"name":@"MV",@"image":@"C",@"selectImage":@"D"},
        @{@"name":@"游戏",@"badge":@(YES),@"image":@"B",@"selectImage":@"D"},
        @{@"name":@"广场",@"image":@"C",@"selectImage":@"D"},
    ];
}
//固定宽度标题
- (NSArray*)fixData{
    return @[@"推荐",@"热点",@"关注"];
}
@end
