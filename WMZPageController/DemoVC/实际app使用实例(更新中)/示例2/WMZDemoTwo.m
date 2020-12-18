//
//  WMZDemoTwo.m
//  WMZPageController
//
//  Created by wmz on 2020/7/7.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZDemoTwo.h"
#import "TopSuspensionVC.h"
@interface WMZDemoTwo ()

@end

@implementation WMZDemoTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = PageColor(0x4895ef);
    
    WMZPageParam *param = PageParam()
    .wMenuBgColorSet([UIColor redColor])
    .wMenuTitleSelectColorSet([UIColor redColor])
    .wControllersSet(@[[TopSuspensionVC new],[TopSuspensionVC new],[TopSuspensionVC new],[TopSuspensionVC new],[TopSuspensionVC new],[TopSuspensionVC new],[TopSuspensionVC new]])
    .wTitleArrSet([self attributesData])
    .wMenuTitleWidthSet(PageVCWidth/4)
    .wMenuCellMarginYSet(10)
    .wMenuCircilRadioSet(20)
    .wMenuAnimalSet(PageTitleMenuCircle)
    //自定义富文本
    .wCustomMenuTitleSet(^(NSArray *titleArr) {
        [titleArr enumerateObjectsUsingBlock:^(WMZPageNaviBtn*  _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
            [self customBtn:btn];
        }];
    });
    //自定义滑动后标题的变化 如有需要
//    .wCustomMenuSelectTitleSet(^(NSArray *titleArr) {
//        [titleArr enumerateObjectsUsingBlock:^(WMZPageNaviBtn*  _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
//            [self customBtn:btn];
//        }];
//    });
    self.param = param;
}

- (void)customBtn:(WMZPageNaviBtn*)btn{
    //闲置
     NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:btn.titleLabel.text];
    //选中
    NSMutableAttributedString *mSelectStr = [[NSMutableAttributedString alloc] initWithString:btn.titleLabel.text];
    [mSelectStr addAttribute:NSForegroundColorAttributeName value:self.param.wMenuTitleSelectColor range:[btn.titleLabel.text rangeOfString:btn.titleLabel.text]];
    
    NSArray *array = [btn.titleLabel.text componentsSeparatedByString:@"\n"];
    
     [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:[btn.titleLabel.text rangeOfString:btn.titleLabel.text]];
     [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f] range:[btn.titleLabel.text rangeOfString:array[0]]];
    
    [mStr addAttribute:NSForegroundColorAttributeName value:PageColor(0x999999) range:[btn.titleLabel.text rangeOfString:array[0]]];
    [mSelectStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0f] range:[btn.titleLabel.text rangeOfString:array[1]]];

    [btn setAttributedTitle:mStr forState:UIControlStateNormal];
    [btn setAttributedTitle:mSelectStr forState:UIControlStateSelected];
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
        @{@"name":@"游戏\n10",@"badge":@(YES),@"wrapColor":[UIColor yellowColor]},
    ];
}

@end
