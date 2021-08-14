//
//  WMZAttVC.m
//  WMZPageController
//
//  Created by wmz on 2021/8/13.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZAttVC.h"

@interface WMZAttVC ()

@end

@implementation WMZAttVC

- (void)viewDidLoad {
    [super viewDidLoad];

    WMZPageParam *param = WMZPageParam.new;
    param.wTitleArr = @[
        /// 富文本需成对出现   WMZPageKeyName/WMZPageKeySelectName
        @{WMZPageKeyName:[self getNormalStr:@"未使用" smallStr:@"(0)"],
          WMZPageKeySelectName:[self getSelectStr:@"未使用" smallStr:@"(0)"],},
        
        @{WMZPageKeyName:[self getNormalStr:@"已使用" smallStr:@"(10)"],
          WMZPageKeySelectName:[self getSelectStr:@"已使用" smallStr:@"(10)"],},
        
        @{WMZPageKeyName:[self getNormalStr:@"已取消" smallStr:@"(20)"],
          WMZPageKeySelectName:[self getSelectStr:@"已取消" smallStr:@"(20)"],},
        
        @{WMZPageKeyName:[self getNormalStr:@"已完成" smallStr:@"(99)"],
          WMZPageKeySelectName:[self getSelectStr:@"已完成" smallStr:@"(99)"],},
    ];
    param.wMenuIndicatorColor = UIColor.orangeColor;
    param.wMenuAnimalTitleGradient = NO;
    param.wMenuAnimal = PageTitleMenuAiQY;
    param.wMenuTitleWidth = PageVCWidth/4;
    param.wMenuTitleSelectColor = UIColor.orangeColor;
    param.wViewController = ^UIViewController * _Nullable(NSInteger index) {
        return NSClassFromString(@"TestVC").new;
    };
    self.param = param;
}

/// 组建富文本
- (NSMutableAttributedString*)getNormalStr:(NSString*)str smallStr:(NSString*)samllStr{
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",str,samllStr]];
    [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f] range:[mStr.string rangeOfString:str]];
    [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0f] range:[mStr.string rangeOfString:samllStr]];
    [mStr addAttribute:NSForegroundColorAttributeName value:UIColor.blackColor range:[mStr.string rangeOfString:mStr.string]];
    return mStr;
}

- (NSMutableAttributedString*)getSelectStr:(NSString*)str smallStr:(NSString*)samllStr{
    NSMutableAttributedString *mStr = [self getNormalStr:str smallStr:samllStr];
    [mStr addAttribute:NSForegroundColorAttributeName value:UIColor.orangeColor range:[mStr.string rangeOfString:mStr.string]];
    return mStr;
}

@end
