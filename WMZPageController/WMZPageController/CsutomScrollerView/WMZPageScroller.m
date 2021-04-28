
//
//  WMZPageScroller.m
//  WMZPageController
//
//  Created by wmz on 2019/9/20.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZPageScroller.h"
#import "WMZPageConfig.h"
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
    if (!self.canScroll) return NO;
    CGFloat naVi = self.wFromNavi?PageVCNavBarHeight:0;
    CGFloat segmentViewContentScrollViewHeight = PageVCHeight - naVi - self.menuTitleHeight;
    CGPoint currentPoint = [gestureRecognizer locationInView:self];
    CGRect containRect = CGRectMake(0, self.contentSize.height - segmentViewContentScrollViewHeight, PageVCWidth, segmentViewContentScrollViewHeight);
    if (CGRectContainsPoint(containRect, currentPoint) ) {
        return YES;
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (!self.currentScroll)  return NO;
    if ([NSStringFromClass(otherGestureRecognizer.view.class) isEqualToString:@"UITableViewWrapperView"] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return YES;
    } else if ([NSStringFromClass(otherGestureRecognizer.view.class) isEqualToString:@"WMZPageDataView"]) {
        return YES;
    } else if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"_FDFullscreenPopGestureRecognizerDelegate")]) {
        if (self.contentOffset.x <= 0){
            return YES;
        }
    }
    return NO;
}

@end


@implementation UIImage(PageImageName)

+ (UIImage*)pageBundleImage:(NSString*)name{
    NSBundle *bundle =  [NSBundle bundleWithPath:[[NSBundle bundleForClass:[WMZPageScroller class]] pathForResource:@"PageController" ofType:@"bundle"]];
    NSString *path = [bundle pathForResource:name ofType:@"png"];
    if (!path) {
        return [UIImage imageNamed:name];
    }else{
        return [UIImage imageWithContentsOfFile:path];
    }
}

@end
