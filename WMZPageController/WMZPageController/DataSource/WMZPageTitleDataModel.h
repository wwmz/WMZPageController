//
//  WMZPageTitleDataModel.h
//  WMZPageController
//
//  Created by wmz on 2020/10/29.
//  Copyright © 2020 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface WMZPageTitleDataModel : NSObject
//对应的控制器
@property(nonatomic,strong)UIViewController *controller;
//对应的下标
@property(nonatomic,assign)NSInteger index;
//对应的数据
@property(nonatomic,strong)NSString *title;
//初始化方法
- (instancetype)initWithIndex:(NSInteger)index controller:(UIViewController*)controller title:(NSString*)title;
@end

NS_ASSUME_NONNULL_END
