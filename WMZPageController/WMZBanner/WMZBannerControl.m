//
//  WMZBannerControl.m
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZBannerControl.h"
@implementation WMZBannerControl

- (instancetype)initWithFrame:(CGRect)frame WithModel:(WMZBannerParam *)param{
    if (self = [super initWithFrame:frame]) {
        self.param = param;
        self.userInteractionEnabled = NO;
        self.hidesForSinglePage = YES;
        self.currentPageIndicatorTintColor = param.wBannerControlColor;
        self.pageIndicatorTintColor = param.wBannerControlSelectColor;
        
        if (param.wBannerControlImage) {
            self.inactiveImage = [UIImage imageNamed:param.wBannerControlImage];
            self.inactiveImageSize = param.wBannerControlImageSize;
            self.pageIndicatorTintColor = [UIColor clearColor];
        }
        if (param.wBannerControlSelectImage) {
            self.currentImage = [UIImage imageNamed:param.wBannerControlSelectImage];
            self.currentImageSize = param.wBannerControlSelectImageSize;
            self.currentPageIndicatorTintColor = [UIColor clearColor];
        }
        

    }
    return self;
}

- (void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    [self updateDots];
}


- (void)updateDots{
    for (int i = 0; i < [self.subviews count]; i++) {
        UIImageView *dot = [self imageViewForSubview:[self.subviews objectAtIndex:i] currPage:i];
        if (i == self.currentPage){
            dot.image = self.currentImage;
            CGRect rect = dot.frame;
            rect.size = self.currentImageSize;
            dot.frame = rect;
            dot.layer.masksToBounds = YES;
            dot.layer.cornerRadius =  self.param.wBannerControlImageRadius?:self. self.currentImageSize.height/2;
        }else{
            dot.image = self.inactiveImage;
            CGRect rect = dot.frame;
            rect.size = self.inactiveImageSize;
            dot.frame = rect;
            dot.layer.masksToBounds = YES;
            dot.layer.cornerRadius = self.param.wBannerControlImageRadius?:self. self.inactiveImageSize.height/2;
        }
    }
}


- (UIImageView *)imageViewForSubview:(UIView *)view currPage:(int)currPage{
    UIImageView *dot = nil;
    if ([view isKindOfClass:[UIView class]]) {
        for (UIView *subview in view.subviews) {
            if ([subview isKindOfClass:[UIImageView class]]) {
                dot = (UIImageView *)subview;
                break;
            }
        }
        if (dot == nil) {
            dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, view.frame.size.width, view.frame.size.height)];
            [view addSubview:dot];
        }
    }else {
        dot = (UIImageView *)view;
    }
    
    return dot;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (!self.param.wBannerControlImage||!self.param.wBannerControlSelectImage) return;
    CGFloat marginX = self.currentImageSize.width + 5;
    CGFloat newW = (self.subviews.count) * marginX;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newW, self.frame.size.height);
    CGPoint center = self.center;
    center.x = self.superview.center.x;
    self.center = center;
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        
        if (i == self.currentPage) {
            [dot setFrame:CGRectMake(i * marginX-2.5, dot.frame.origin.y, self.currentImageSize.width, self.currentImageSize.height)];
        }else {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, self.currentImageSize.width, self.currentImageSize.height)];
        }
    }
}

@end
