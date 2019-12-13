
//
//  WMZPageScroller.m
//  WMZPageController
//
//  Created by wmz on 2019/9/20.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZPageScroller.h"

@implementation WMZPageScroller

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.scrollsToTop = NO;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    if ([NSStringFromClass(otherGestureRecognizer.view.class) isEqualToString:@"UITableViewWrapperView"] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return YES;
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
