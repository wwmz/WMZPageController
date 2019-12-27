//
//  UIView+PageRect.h
//  WMZPageController
//
//  Created by wmz on 2019/12/16.
//  Copyright © 2019 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (PageRect)

- (void)page_y:(CGFloat)y;
- (void)page_x:(CGFloat)y;
- (void)page_width:(CGFloat)width;
- (void)page_height:(CGFloat)height;
@end

NS_ASSUME_NONNULL_END
