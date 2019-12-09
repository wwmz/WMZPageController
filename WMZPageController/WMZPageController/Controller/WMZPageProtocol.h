//
//  WMZPageProtocol.h
//  WMZPageController
//
//  Created by wmz on 2019/10/13.
//  Copyright © 2019 wmz. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WMZPageProtocol <NSObject>

@required
/*
 *悬浮 可滑动的滚动视图
 */
- (UITableView*)getMyTableView;

@end

NS_ASSUME_NONNULL_END
