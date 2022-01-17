

//
//  UseVC.m
//  WMZPageController
//
//  Created by wmz on 2019/10/10.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "UseVC.h"
#import "TestVC.h"
@interface UseVC ()

@end

@implementation UseVC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSInteger index = self.index.integerValue;
    
    //标题数组
       NSArray *data = @[];
       if (index == 0) {
           data = [self AQYData];
       }else if(index == 1){
           data = [self PDDData];
       }else if(index == 2){
           data = [self ToutiaoData];
       }else if(index == 3){
           data = [self JDData];
       }else if(index == 4){
           data = [self JSData];
       }else if(index == 5){
           data = [self PDDData];
       }else if(index == 6){
           data = [self PDDData];
       }else{
           data = [self PDDData];
       }
       WMZPageParam *param = PageParam();
       switch (index) {
           //爱奇艺
           case 0:
           {
             param.wTitleArrSet(data)
            .wViewControllerSet(^UIViewController *(NSInteger index) {
                TestVC *vc = [TestVC new];
                vc.page = index;
                return vc;
             })
             .wMenuDefaultIndexSet(3)
             .wMenuIndicatorYSet(5)
             .wMenuTitleUIFontSet([UIFont systemFontOfSize:17.0f])
             .wMenuTitleWeightSet(50)
             .wMenuTitleColorSet(PageColor(0xeeeeee))
             .wMenuTitleSelectColorSet(PageColor(0xffffff))
             .wMenuIndicatorColorSet(PageColor(0x00dea3))
             .wMenuIndicatorWidthSet(10.0f)
             .wMenuFixRightDataSet(@"≡")
             .wMenuAnimalTitleGradientSet(NO)
             .wMenuAnimalSet(PageTitleMenuAiQY);
           }
          break;
           //拼多多
           case 1:{
               param.wTitleArrSet(data)
               .wViewControllerSet(^UIViewController *(NSInteger index) {
                    TestVC *vc = [TestVC new];
                    vc.page = index;
                    return vc;
                })
               .wMenuPositionSet(PageMenuPositionNavi)
               .wMenuAnimalTitleGradientSet(NO)
               .wMenuAnimalSet(PageTitleMenuPDD);
               }
          break;
         //今日头条
          case 2:{
               param.wTitleArrSet(data)
               .wViewControllerSet(^UIViewController *(NSInteger index) {
                       TestVC *vc = [TestVC new];
                       vc.page = index;
                        return vc;
                })
               .wMenuFixRightDataSet(@"+")
               .wMenuAnimalSet(PageTitleMenuTouTiao);
           }
         break;
       //  京东
         case 3:{
             
             
               
               param.wTitleArrSet(data)
               .wViewControllerSet(^UIViewController *(NSInteger index) {
                   TestVC *vc = [TestVC new];
                    vc.page = index;
                    return vc;
                })
               .wMenuTitleSelectColorSet(PageColor(0xFFFBF0))
               .wMenuBgColorSet(PageColor(0xff183b))
               .wMenuTitleColorSet(PageColor(0xffffff))
               .wMenuAnimalTitleGradientSet(NO)
               .wMenuIndicatorImageSet(@"E")
               .wMenuIndicatorHeightSet(15)
               .wMenuIndicatorWidthSet(20)
               .wMenuAnimalSet(PageTitleMenuLine);
           }
           break;
          //简书
           case 4:{
                     
           param.wTitleArrSet(data)
           .wViewControllerSet(^UIViewController *(NSInteger index) {
               TestVC *vc = [TestVC new];
                vc.page = index;
                return vc;
            })
           .wMenuIndicatorColorSet(PageColor(0xfe6e5d))
           .wMenuTitleSelectColorSet(PageColor(0x333333))
           .wMenuTitleColorSet(PageColor(0x666666))
           .wMenuAnimalTitleGradientSet(NO)
           .wMenuFixRightDataSet(@{WMZPageKeyImage:@"G"})
           .wMenuFixWidthSet(70)
           .wMenuFixShadowSet(NO)
           .wMenuIndicatorHeightSet(3)
           .wMenuTitleWeightSet(100)
           .wMenuIndicatorWidthSet(15)
           .wMenuAnimalSet(PageTitleMenuPDD);
           }
           break;
           case 5:{
             param.wTitleArrSet(data)
             .wViewControllerSet(^UIViewController *(NSInteger index) {
                 TestVC *vc = [TestVC new];
                  vc.page = index;
                  return vc;
              })
             .wMenuAnimalSet(PageTitleMenuCircle);
           }
          break;
         case 6:{
           param.wTitleArrSet(data)
           .wViewControllerSet(^UIViewController *(NSInteger index) {
               TestVC *vc = [TestVC new];
                vc.page = index;
                return vc;
            })
           .wMenuAnimalSet(PageTitleMenuAiQY)
           //菜单标题颜色
           .wMenuTitleColorSet(PageDarkColor(PageColor(0x333333), PageColor(0xffffff)))
           //菜单标题选中的颜色
           .wMenuTitleSelectColorSet(PageDarkColor(PageColor(0xE5193E), [UIColor orangeColor]))
           //指示器颜色
           .wMenuIndicatorColorSet(PageDarkColor(PageColor(0xE5193E), [UIColor orangeColor]))
           //菜单背景颜色
           .wMenuBgColorSet(PageDarkColor(PageColor(0xffffff), PageColor(0x666666)));
         }
        break;
        //新爱奇艺
        case 7:
        {
            param.wTitleArrSet(data)
            .wViewControllerSet(^UIViewController *(NSInteger index) {
               TestVC *vc = [TestVC new];
                vc.page = index;
                return vc;
            })
            .wMenuIndicatorWidthSet(17)
            .wMenuIndicatorHeightSet(4)
            .wMenuIndicatorYSet(5)
            .wMenuAnimalSet(PageTitleMenuNewAiQY);
            break;
        }
        //新京东
        case 8:
        {
           param.wTitleArrSet(data)
            /// 自定义jdlayer的frame
           .wEventCustomJDAnimalSet(^(WMZPageNaviBtn * _Nullable sender, UIView * _Nullable jdLayer) {
               jdLayer.frame = CGRectMake(CGRectGetWidth(sender.frame) - 20, CGRectGetHeight(sender.frame) - 20, 13, 8);
            })
           .wViewControllerSet(^UIViewController *(NSInteger index) {
              TestVC *vc = [TestVC new];
               vc.page = index;
               return vc;
           })
           .wMenuIndicatorColorSet(UIColor.orangeColor)
           .wMenuAnimalSet(PageTitleMenuJD);
           break;
        }
         default:
         break;
       }
    
       if (index == 1) {
           self.navigationItem.hidesBackButton = YES;
       }
       self.param = param;
       
}
/*爱奇艺标题
  (滚动完改变颜色)
  name           标题
  selectName     选中后的标题
  indicatorColor 指示器颜色
  titleSelectColor 选中字体颜色
  titleColor 未选中字体颜色
  backgroundColor 选中背景颜色 (如果是数组则是背景色渐变色)
 */
- (NSArray*)AQYData{
    return @[
    @{
       WMZPageKeyName:@"推荐",
       WMZPageKeySelectName:@"荐推",
       WMZPageKeyBackgroundColor:@[PageColor(0x15314b),PageColor(0x009a93)],
       WMZPageKeyTitleWidth:@(50),
       WMZPageKeyTitleMarginX:@(10),
       WMZPageKeyTitleHeight:@(55),
    },
    @{
       WMZPageKeyName:@"70年",
       WMZPageKeyBackgroundColor:PageColor(0xd70022),
       WMZPageKeyIndicatorColor:PageColor(0xfffcc6),
       WMZPageKeyTitleSelectColor:PageColor(0xfffcc6),
     },
     @{
       WMZPageKeyName:@"VIP",
       WMZPageKeyBackgroundColor:PageColor(0x3d4659),
       WMZPageKeyTitleSelectColor:PageColor(0xe2c285),
       WMZPageKeyIndicatorColor:PageColor(0xe2c285),
       WMZPageKeyTitleSelectColor:PageColor(0x9297a5)
     },
     @{WMZPageKeyName:@"热点",WMZPageKeyBackgroundColor:@[PageColor(0x15314b),PageColor(0x009a93)]},
     @{WMZPageKeyName:@"电视剧",WMZPageKeyBackgroundColor:@[PageColor(0x15314b),PageColor(0x009a93)]},
     @{WMZPageKeyName:@"电影",WMZPageKeyBackgroundColor:PageColor(0x007e80)},
     @{WMZPageKeyName:@"儿童",WMZPageKeyBackgroundColor:@[PageColor(0x15314b),PageColor(0x009a93)]},
     @{WMZPageKeyName:@"游戏",WMZPageKeyBackgroundColor:PageColor(0x1c2c3b)},
    ];
}



/*
 拼多多标题
 */
- (NSArray*)PDDData{
    return
    @[@"热门",@"男装",@"美妆",@"手机",@"食品",@"电器",@"鞋包",@"百货",@"女装",@"汽车",@"电脑"];
}


/*
 今日头条标题
 badge   红点提示
 */
- (NSArray*)ToutiaoData{
    return
    @[
        @{WMZPageKeyName:@"关注",WMZPageKeyBadge:@(-1)},
        @{WMZPageKeyName:@"推荐",WMZPageKeyBadge:@(-1)},@"广州",
        @{WMZPageKeyName:@"热点",WMZPageKeyBadge:@(-1)},
        @"视频",@{WMZPageKeyName:@"图片",WMZPageKeyBadge:@(-1)},@"问答",@"科技",
    ];
}


/*
微博
*/
- (NSArray*)weiboTitleData{
    return
    @[@"关注",@"热门"];
}

/*
微博内容 WMZPageKeyOnlyClick:@(YES) 仅点击不加载页面
*/
- (NSArray*)weiboData{
    return
    @[@"推荐",@"同城",@"榜单",@"5G",@"抽奖",@"新时代",@"广州",@"电竞",@"明星"];
}

/*
京东内容
image 图片
selectImage 选中图片
*/
- (NSArray*)JDData{
    return
    @[
      @"推荐",
      @{WMZPageKeyImage:@"F"},
      @"榜单",
      @"5G",
      @"抽奖",
      @"新时代",
      @{WMZPageKeyName:@"哈哈",WMZPageKeySelectImage:@"D"},
      @"电竞",
      @"明星"];
}

- (NSArray*)JSData{
    return @[@"推荐",@"小岛",@"专题",@"连载"];
}
@end
