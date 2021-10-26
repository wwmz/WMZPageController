
//
//  WMZPageScroller.m
//  WMZPageController
//
//  Created by wmz on 2019/9/20.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZPageScroller.h"
#import "WMZPageConfig.h"
#import "WMZPageDataView.h"

@implementation WMZPageScroller

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.scrollsToTop = NO;
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.wCustomSimultaneouslyGesture) return self.wCustomSimultaneouslyGesture(gestureRecognizer, otherGestureRecognizer);
    if ([NSStringFromClass(otherGestureRecognizer.view.class) isEqualToString:@"WMZPageDataView"] &&
        [NSStringFromClass([otherGestureRecognizer class]) isEqualToString:@"UIScrollViewPanGestureRecognizer"]) return NO;
    if (self.sonCanScroll || !self.canScroll || self.contentOffset.y < 0) return NO;
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.wCustomFailGesture)  return  self.wCustomFailGesture(gestureRecognizer, otherGestureRecognizer);
    if (!self.currentScroll) return NO;
    if ([NSStringFromClass(otherGestureRecognizer.view.class) isEqualToString:@"UITableViewWrapperView"] &&
        [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) return YES;
    return NO;
}

@end
