

//
//  UseVC.m
//  WMZPageController
//
//  Created by wmz on 2019/10/10.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "UseVC.h"
@interface UseVC ()

@end

@implementation UseVC

- (void)pushWithVC:(UIViewController *)vc withIndex:(NSInteger)index{
    //标题数组
    NSArray *data = @[];
    if (index == 0) {
        data = [self AQYData];
    }else if (index == 1) {
        data = [self YKData];
    }else if(index == 2){
        data = [self PDDData];
    }else if(index == 3){
        data = [self ToutiaoData];
    }else if(index == 4){
        data = [self weiboData];
    }else if(index == 5){
        data = [self JDData];
    }else if(index == 6){
        data = [self JSData];
    }else if(index == 7){
        data = [self PDDData];
    }
    //控制器数组
    NSMutableArray *vcArr = [NSMutableArray new];
    [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TestVC *vc = [TestVC new];
        vc.page = idx;
        [vcArr addObject:vc];
    }];
    
    WMZPageParam *param = PageParam();
    switch (index) {
        //爱奇艺
        case 0:
        {
          param.wTitleArrSet(data)
          .wControllersSet(vcArr)
          .wMenuIndicatorYSet(5)
          .wMenuTitleFontSet(17)
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
       //优酷
       case 1:{
             param.wTitleArrSet(data)
            .wControllersSet(vcArr)
            .wMenuTitleFontSet(17)
            .wMenuTitleWeightSet(50)
            .wMenuCellPaddingSet(40)
            .wMenuTitleColorSet(PageColor(0xcadbe4))
            .wMenuTitleSelectColorSet(PageColor(0x00dcfb))
            .wMenuIndicatorColorSet(PageColor(0x00dcfb))
            .wMenuBgColorSet(PageColor(0x224b74))
            .wMenuAnimalTitleGradientSet(NO)
            .wMenuFixRightDataSet(@"≡")
            .wMenuAnimalSet(PageTitleMenuYouKu);
       }
       break;
        //拼多多
        case 2:{
            param.wTitleArrSet(data)
            .wControllersSet(vcArr)
            .wMenuCellPaddingSet(20)
            .wMenuPositionSet(PageMenuPositionNavi)
            .wMenuAnimalTitleGradientSet(NO)
            .wMenuAnimalTitleBigSet(NO)
            .wMenuAnimalSet(PageTitleMenuAiQY);
            }
       break;
      //今日头条
       case 3:{
            param.wTitleArrSet(data)
            .wControllersSet(vcArr)
            .wMenuFixRightDataSet(@"+")
            .wMenuAnimalSet(PageTitleMenuTouTiao);
        }
      break;
        //微博  嵌套使用
       case 4:{
            
             param.wTitleArrSet(data)
            .wControllersSet(vcArr)
            .wMenuFixRightDataSet(@"+")
            .wMenuAnimalSet(PageTitleMenuNone);
            WMZPageController *sonVC =  [WMZPageController new];
            sonVC.param = param;
           
            WMZPageParam *headParam = PageParam()
            .wTitleArrSet([self weiboTitleData])
            .wControllersSet(@[[TestVC new],sonVC])
            .wMenuPositionSet(PageMenuPositionNavi)
            .wMenuWidthSet(150);
           
           WMZPageController *VC =  [WMZPageController new];
           VC.param = headParam;
           [vc.navigationController pushViewController:VC animated:YES];
           
        }
      return;
      //京东
      case 5:{
            
            param.wTitleArrSet(data)
            .wControllersSet(vcArr)
            .wMenuTitleSelectColorSet(PageColor(0xFFFBF0))
            .wMenuBgColorSet(PageColor(0xff183b))
            .wMenuTitleColorSet(PageColor(0xffffff))
            .wMenuAnimalTitleGradientSet(NO)
            .wMenuIndicatorImageSet(@"E")
            .wMenuIndicatorHeightSet(15)
            .wMenuIndicatorWidthSet(20)
            .wMenuCellPaddingSet(40)
            .wMenuAnimalSet(PageTitleMenuLine);
        }
        break;
       //简书
        case 6:{
                  
        param.wTitleArrSet(data)
        .wControllersSet(vcArr)
        .wMenuIndicatorColorSet(PageColor(0xfe6e5d))
        .wMenuTitleSelectColorSet(PageColor(0x333333))
        .wMenuTitleColorSet(PageColor(0x666666))
        .wMenuAnimalTitleGradientSet(NO)
        .wMenuFixRightDataSet(@{@"image":@"G"})
        .wMenuFixWidthSet(70)
        .wMenuFixShadowSet(NO)
        .wMenuIndicatorHeightSet(3)
        .wMenuTitleWeightSet(100)
        .wMenuIndicatorWidthSet(15)
        .wMenuAnimalSet(PageTitleMenuPDD);
        }
        break;
      case 7:{
          
        param.wTitleArrSet(data)
        .wControllersSet(vcArr)
        .wMenuAnimalSet(PageTitleMenuYouKu)
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
      default:
      break;
    }
    WMZPageController *VC =  [WMZPageController new];
    if (index == 2) {
        VC.navigationItem.hidesBackButton = YES;
    }
    VC.param = param;
    [vc.navigationController pushViewController:VC animated:YES];
    
    //更新
    if (index == 7) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *updateArr = [NSMutableArray new];
            [[self weiboData] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                TestVC *vc = [TestVC new];
                vc.page = idx;
                [updateArr addObject:vc];
            }];
            
            param.wTitleArrSet([self weiboData])
            .wControllersSet(updateArr);
            
            //更新
            [VC updatePageController];
        });
    }
    

}


/*爱奇艺标题
  (滚动完改变颜色)
  indicatorColor 指示器颜色
  titleSelectColor 选中字体颜色
  titleColor 未选中字体颜色
  backgroundColor 选中背景颜色 (如果是数组则是背景色渐变色)
 */
- (NSArray*)AQYData{
    return @[
    @{
       @"name":@"推荐",
       @"backgroundColor":@[PageColor(0x15314b),PageColor(0x009a93)]},
    @{
       @"name":@"家务男",
       @"backgroundColor":PageColor(0xffdfa2),
       @"indicatorColor":PageColor(0x9b4f2d),
       @"titleSelectColor":PageColor(0x9b4f2d),
       @"titleColor":PageColor(0xd79869)
    },
    @{
       @"name":@"70年",
       @"titleColor":PageColor(0xffaa68),
       @"backgroundColor":PageColor(0xd70022),
       @"indicatorColor":PageColor(0xfffcc6),
       @"titleSelectColor":PageColor(0xfffcc6)
     },
     @{
       @"name":@"VIP",
       @"backgroundColor":PageColor(0x3d4659),
       @"titleSelectColor":PageColor(0xe2c285),
       @"indicatorColor":PageColor(0xe2c285),
       @"titleColor":PageColor(0x9297a5)
     },
     @{@"name":@"热点",@"backgroundColor":@[PageColor(0x15314b),PageColor(0x009a93)]},
     @{@"name":@"电视剧",@"backgroundColor":@[PageColor(0x15314b),PageColor(0x009a93)]},
     @{@"name":@"电影",@"backgroundColor":PageColor(0x007e80)},
     @{@"name":@"儿童",@"backgroundColor":@[PageColor(0x15314b),PageColor(0x009a93)]},
     @{@"name":@"游戏",@"backgroundColor":PageColor(0x1c2c3b)},
    ];
}


/*
 优酷标题
 */
- (NSArray*)YKData{
    return @[
    @"精选",
    @"热点",
    @{
        @"name":@"电影",
        @"backgroundColor":PageColor(0x00224a),
        @"titleColor":PageColor(0x0095bd)
    },
    @"综艺",@"高清",@"广东",@"动漫",@"直播"
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
        @{@"name":@"关注",@"badge":@(YES)},
        @{@"name":@"推荐",@"badge":@(YES)},@"广州",
        @{@"name":@"热点",@"badge":@(YES)},
        @"视频",@{@"name":@"图片",@"badge":@(YES)},@"问答",@"科技",
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
微博内容
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
      @{@"image":@"F"},
      @"榜单",
      @"5G",
      @"抽奖",
      @"新时代",
      @{@"image":@"F",@"selectImage":@"D"},
      @"电竞",
      @"明星"];
}

- (NSArray*)JSData{
    return @[@"推荐",@"小岛",@"专题",@"连载"];
}
@end
