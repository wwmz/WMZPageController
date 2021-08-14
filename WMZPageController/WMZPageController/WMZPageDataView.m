//
//  WMZPageDataView.m
//  WMZPageController
//
//  Created by wmz on 2020/9/27.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZPageDataView.h"
#import "WMZPageLoopView.h"

@implementation WMZPageDataView

- (instancetype)init{
    if (self = [super init]) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.level = 100000;
        self.alwaysBounceHorizontal = YES;
        self.alwaysBounceVertical = NO;
        self.scrollsToTop = NO;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([NSStringFromClass([gestureRecognizer.view class]) isEqualToString:@"WMZPageDataView"]&&
        [NSStringFromClass([otherGestureRecognizer.view class]) isEqualToString:@"WMZPageDataView"]
        && [NSStringFromClass([gestureRecognizer class]) isEqualToString:@"UIScrollViewPanGestureRecognizer"]) {
        WMZPageDataView *firstView = (WMZPageDataView*)gestureRecognizer.view;
        WMZPageDataView *secondView = (WMZPageDataView*)otherGestureRecognizer.view;
        if (firstView.level - secondView.level == -1) {
            firstView.left = ([firstView.panGestureRecognizer translationInView:firstView.superview].x > 0);
            if (firstView.contentOffset.x <= 0) {
                if (firstView.left && secondView.currentIndex > 0) return YES;
                if (!firstView.left && firstView.currentIndex == (firstView.totalCount - 1)) return YES;
            }else if(firstView.contentOffset.x >= PageVCWidth * (firstView.totalCount - 1)){
                if (firstView.left && firstView.currentIndex == 0 && secondView.currentIndex > 0) return YES;
                if (!firstView.left && secondView.currentIndex < (secondView.totalCount - 1)) return YES;
            }
        }
    }
    return NO;
}

@end
