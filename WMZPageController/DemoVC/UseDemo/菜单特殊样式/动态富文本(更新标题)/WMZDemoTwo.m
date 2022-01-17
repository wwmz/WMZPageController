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

    WMZPageParam *param = PageParam()
    .wMenuTitleSelectColorSet([UIColor redColor])
    .wTitleArrSet([self attributesData])
    .wMenuTitleWidthSet(PageVCWidth/4)
    .wMenuCellMarginYSet(10)
    .wMenuCircilRadioSet(20)
    .wHideRedCircleSet(NO)
    .wMenuAnimalSet(PageTitleMenuCircle);
    param.wViewController = ^UIViewController * _Nullable(NSInteger index) {
        return [TopSuspensionVC new];
    };
    //也可以此处自定义富文本
    param.wCustomMenuTitle = ^(NSArray<WMZPageNaviBtn *> * _Nullable titleArr) {
        
    };
    //自定义滑动后标题的变化 如有需要
    param.wCustomMenuSelectTitle = ^(NSArray<WMZPageNaviBtn *> * _Nullable titleArr) {
        
    };
    
    self.param = param;
}

- (NSMutableAttributedString*)getNormalStr:(NSString*)str{
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSArray *array = [str componentsSeparatedByString:@"\n"];
    [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:[str rangeOfString:str]];
    [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f] range:[str rangeOfString:array[0]]];
    [mStr addAttribute:NSForegroundColorAttributeName value:PageColor(0x999999) range:[str rangeOfString:array[0]]];
    return mStr;
}

- (NSMutableAttributedString*)getSelectStr:(NSString*)str{
    NSMutableAttributedString *mSelectStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSArray *array = [str componentsSeparatedByString:@"\n"];
    [mSelectStr addAttribute:NSForegroundColorAttributeName value:UIColor.orangeColor range:[str rangeOfString:str]];
    [mSelectStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0f] range:[str rangeOfString:array[1]]];
    return mSelectStr;
}

//带富文本
- (NSArray*)attributesData{
    return @[
        @{WMZPageKeyName:[self getNormalStr:@"推荐1\n10"],WMZPageKeySelectName:[self getSelectStr:@"推荐1\n10"]},
        @"LOOK直播\n10",
        @{WMZPageKeyName:[self getNormalStr:@"画\n10"],WMZPageKeyBadge:@(-1)},
        @"现场\n10",
        @{WMZPageKeyName:@"翻唱\n10"},
        [self getNormalStr:@"推荐\n10"],
        @{WMZPageKeyName:[self getNormalStr:@"推荐\n10"],WMZPageKeySelectName:[self getSelectStr:@"推荐\n10"],WMZPageKeyBadge:@(-1)},
    ];
}

@end
