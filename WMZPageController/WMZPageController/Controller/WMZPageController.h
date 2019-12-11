//
//  WMZPageController.h
//  WMZPageController
//
//  Created by wmz on 2019/9/22.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZPageParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface WMZPageController : UIViewController

//导航栏背景色  //特殊情况自行处理
@property(nonatomic,strong)UIView *naviBarBackGround;

@property(nonatomic,strong)WMZPageParam *param;

/*
 *更新
 */
- (void)updatePageController;

@end

NS_ASSUME_NONNULL_END
