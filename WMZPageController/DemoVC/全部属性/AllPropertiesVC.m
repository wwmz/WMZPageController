

//
//  AllPropertiesVC.m
//  WMZPageController
//
//  Created by wmz on 2019/10/10.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "AllPropertiesVC.h"
#import "TestVC.h"
@implementation AllPropertiesVC

-(void)viewDidLoad{
    [super viewDidLoad];
       WMZPageParam *param =
       //初始化
       PageParam()
        //设置控制器数组 必传
       .wViewControllerSet(^UIViewController *(NSInteger index) {
           return [TestVC new];
       })
       //设置标题数组 必传
       .wTitleArrSet(@[@"推荐",@"LOOK直播",@"画",@"现场",@"翻唱",@"MV"])
       //设置指示器和动画样式
       .wMenuAnimalSet(PageTitleMenuAiQY)
       //是否开启滑动标题颜色渐变
       .wMenuAnimalTitleGradientSet(NO)
       //标题font
       .wMenuTitleUIFontSet([UIFont systemFontOfSize:15.0f])
       //标题菜单栏的宽度 默认屏幕宽度
       .wMenuWidthSet(PageVCWidth)
       //指示器的宽度
       .wMenuIndicatorWidthSet(10)
       //指示器的高度
       .wMenuIndicatorHeightSet(2)
       //指示器的圆角
       .wMenuIndicatorRadioSet(0)
       //指示器图片
//       .wMenuIndicatorImageSet(@"")
       //菜单内部按钮的内左右间距
       .wMenuCellMarginSet(20)
       //菜单内部按钮的外间距
       .wMenuTitleOffsetSet(5)
       //菜单的位置
       .wMenuPositionSet(PageMenuPositionLeft)
       //默认选中第几个标题
       .wMenuDefaultIndexSet(1)
       //菜单标题图文的位置
       .wMenuImagePositionSet(PageBtnPositionRight)
       //菜单标题图文的间距
       .wMenuImageMarginSet(10)
       //菜单标题颜色
       .wMenuTitleColorSet(PageDarkColor(PageColor(0x333333), PageColor(0xffffff)))
       //菜单标题选中的颜色
       .wMenuTitleSelectColorSet(PageDarkColor(PageColor(0xE5193E), [UIColor orangeColor]))
       //指示器颜色
       .wMenuIndicatorColorSet(PageDarkColor(PageColor(0xE5193E), [UIColor orangeColor]))
       //菜单背景颜色
       .wMenuBgColorSet(PageDarkColor(PageColor(0xffffff), PageColor(0x666666)))
       //右边固定标题
       .wMenuFixRightDataSet(@"≡")
       //右边固定标题宽度
       .wMenuFixWidthSet(45)
       //右边固定标题开启阴影
       .wMenuFixShadowSet(YES)
       //最右边固定内容
        .wMenuFixRightDataSet(@"+")
       //导航栏透明度变化
        .wNaviAlphaSet(NO)
        //视图从导航栏开始
        .wFromNaviSet(YES)
        //开启悬浮
        .wTopSuspensionSet(YES)
          //自定义静态标题
        .wCustomMenuTitleSet(^(NSArray *titleArr) {
            [titleArr enumerateObjectsUsingBlock:^(WMZPageNaviBtn*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {}];
          })
        //自定义滑动后标题的变化
        .wCustomMenuSelectTitleSet(^(NSArray *titleArr) {
            [titleArr enumerateObjectsUsingBlock:^(WMZPageNaviBtn*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.isSelected) {
                     
                }else{
                      
                }
            }];
          })
          //背景层
//          .wInsertHeadAndMenuBgSet(^(UIView *bgView) {
//              //全局背景示例
//              bgView.layer.contents = (id)[UIImage imageNamed:@"11111"].CGImage;
//          })
         //底部线
//          .wInsertMenuLineSet(^(UIView *bgView) {
//              //修改内置线
//              CGRect rect = bgView.frame;
//              rect.size.height = PageK1px;
//              bgView.frame = rect;
//              bgView.backgroundColor = PageColor(0x999999);
//          })
       //控制器开始切换
       .wEventBeganTransferControllerSet(^(UIViewController *oldVC, UIViewController *newVC, NSInteger oldIndex, NSInteger newIndex) {
           NSLog(@"开始切换 %ld %ld",oldIndex,newIndex);
        })
       //控制器结束切换
       .wEventEndTransferControllerSet(^(UIViewController *oldVC, UIViewController *newVC, NSInteger oldIndex, NSInteger newIndex) {
          NSLog(@"结束切换 %ld %ld",oldIndex,newIndex);
        })
       //标题点击
       .wEventClickSet(^(id anyID, NSInteger index) {
           NSLog(@"标题点击%ld",index);
       })
       //右边固定标题点击
       .wEventFixedClickSet(^(id anyID, NSInteger index) {
           NSLog(@"固定标题点击%ld",index);
       })
       .wEventChildVCDidSrollSet(^(UIViewController *pageVC, CGPoint oldPoint, CGPoint newPonit, UIScrollView *currentScrollView) {
//           NSLog(@"滚动");
       });
    self.param = param;
}

@end
