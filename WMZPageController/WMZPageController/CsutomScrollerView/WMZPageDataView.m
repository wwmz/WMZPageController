//
//  WMZPageDataView.m
//  WMZPageController
//
//  Created by wmz on 2020/9/27.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZPageDataView.h"
#import "WMZPageLoopView.h"
@interface WMZPageDataView()<UIGestureRecognizerDelegate>
@end
@implementation WMZPageDataView

- (instancetype)init{
    if (self = [super init]) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.level = 100000;
        self.bounces = NO;
        self.scrollsToTop = NO;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([NSStringFromClass([gestureRecognizer.view class]) isEqualToString:@"WMZPageDataView"]&&[NSStringFromClass([otherGestureRecognizer.view class]) isEqualToString:@"WMZPageDataView"]) {
        WMZPageDataView *firstView = (WMZPageDataView*)gestureRecognizer.view;
        WMZPageDataView *secondView = (WMZPageDataView*)otherGestureRecognizer.view;
        if (firstView!=secondView) {
            if (firstView.level - secondView.level == abs(1) ) {
                if (firstView.level>secondView.level) {
                    
                    if (firstView.level == 100000  && secondView.level == 99999) {
                        if (firstView.currentIndex>0&&secondView.currentIndex == 0) {
                            return YES;
                        }
                        if (firstView.currentIndex< (firstView.totalCount - 1)&&
                            secondView.currentIndex == (secondView.totalCount - 1)) {
                            return YES;
                        }
                    }else {
                        if (firstView.currentIndex< (firstView.totalCount - 1)&&
                            secondView.currentIndex == (secondView.totalCount - 1)&&!firstView.left&&!secondView.left) {
                            return YES;
                        }
                        if (firstView.currentIndex>0&&secondView.currentIndex == 0&&firstView.left&&secondView.left) {
                            return YES;
                        }
                    }
                }else{
                    if (firstView.currentIndex == 0 && secondView.currentIndex>0) { //左
                        return YES;
                    }else if (firstView.currentIndex == (firstView.totalCount - 1) && secondView.currentIndex<(secondView.totalCount - 1)) {    //右
                        return YES;
                    }
                }
            }
        }
    }

    return NO;
}



@end
