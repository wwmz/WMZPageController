
//
//  WMZPageNaviBtn.m
//  WMZPageController
//
//  Created by wmz on 2019/9/22.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZPageNaviBtn.h"
@interface WMZPageNaviBtn()
@property(nonatomic,assign)CGSize minSize;
@end
@implementation WMZPageNaviBtn

- (void)setHighlighted:(BOOL)highlighted{
    
}

-(void)setRadii:(CGSize)size RoundingCorners:(UIRectCorner)rectCorner {
    //设置只有一半圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (CGSize)maxSize{
    if (!_maxSize.width||!_maxSize.height) {
        _maxSize = [self boundingRectWithSize:self.titleLabel.text Font:self.titleLabel.font Size:
                    CGSizeMake(CGFLOAT_MAX, self.param.wMenuPosition == PageMenuPositionNavi?35:CGFLOAT_MAX)];
    }
    return _maxSize;
}



/*
    txt:label或button的title
    font:字体大小
    size:允许最大size
 */
-(CGSize)boundingRectWithSize:(NSString*)txt Font:(UIFont*) font Size:(CGSize)size{
    
    CGSize _size;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine |
    
    NSStringDrawingUsesLineFragmentOrigin |
    
    NSStringDrawingUsesFontLeading;
    
    _size = [txt boundingRectWithSize:size options: options attributes:attribute context:nil].size;
    
#else
    
    _size = [txt sizeWithFont:font constrainedToSize:size];
    
#endif
    
    return _size;
    
}



- (void)TagSetImagePosition:(PageBtnPosition)postion spacing:(CGFloat)spacing {
    CGFloat imgW = self.imageView.image.size.width;
    CGFloat imgH = self.imageView.image.size.height;
    CGSize trueSize = CGSizeMake(self.maxSize.width, self.maxSize.height);
    
    CGFloat trueLabW = trueSize.width;
    CGFloat trueLabH = trueSize.height;
//    if (self.max) {
//        trueLabW -= (imgW+spacing+spacing);
//    }
    //image中心移动的x距离
    CGFloat imageOffsetX = trueLabW/2 ;
    //image中心移动的y距离
    CGFloat imageOffsetY = trueLabH/2 + spacing/2;
    //label左边缘移动的x距离
    CGFloat labelOffsetX1 = imgW/2 - trueLabW/2 + trueLabW/2;
    //label右边缘移动的x距离
    CGFloat labelOffsetX2 = imgW/2 + trueLabW/2 - trueLabW/2;
    //label中心移动的y距离
    CGFloat labelOffsetY = imgH/2 + spacing/2;
    switch (postion) {
        case PageBtnPositionLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            break;
            
        case PageBtnPositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, trueLabW + spacing/2, 0, -(trueLabW + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imgW + spacing/2), 0, imgW + spacing/2);
            break;
            
        case PageBtnPositionTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX1, -labelOffsetY, labelOffsetX2);
            break;
            
        case PageBtnPositionBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX1, labelOffsetY, labelOffsetX2);
            break;
            
        default:
            break;
    }
}

- (void)viewShadowPathWithColor:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowPathType:(PageShadowPathType)shadowPathType shadowPathWidth:(CGFloat)shadowPathWidth{
    
    self.layer.masksToBounds = NO;//必须要等于NO否则会把阴影切割隐藏掉
    self.layer.shadowColor = shadowColor.CGColor;// 阴影颜色
    self.layer.shadowOpacity = shadowOpacity;// 阴影透明度，默认0
    self.layer.shadowOffset = CGSizeZero;//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowRadius = shadowRadius;//阴影半径，默认3
    CGRect shadowRect = CGRectZero;
    CGFloat originX,originY,sizeWith,sizeHeight;
    originX = 0;
    originY = 0;
    sizeWith = self.bounds.size.width;
    sizeHeight = self.bounds.size.height;
    
    if (shadowPathType == PageShadowPathTop) {
        shadowRect = CGRectMake(originX, originY-shadowPathWidth/2, sizeWith, shadowPathWidth);
    }else if (shadowPathType == PageShadowPathBottom){
        shadowRect = CGRectMake(originY, sizeHeight-shadowPathWidth/2, sizeWith, shadowPathWidth);
    }else if (shadowPathType == PageShadowPathLeft){
        shadowRect = CGRectMake(originX-shadowPathWidth/2, originY+sizeHeight/4, shadowPathWidth, sizeHeight/2);
    }else if (shadowPathType == PageShadowPathRight){
        shadowRect = CGRectMake(sizeWith-shadowPathWidth/2, originY, shadowPathWidth, sizeHeight);
    }else if (shadowPathType == PageShadowPathCommon){
        shadowRect = CGRectMake(originX-shadowPathWidth/2, 2, sizeWith+shadowPathWidth, sizeHeight+shadowPathWidth/2);
    }else if (shadowPathType == PageShadowPathAround){
        shadowRect = CGRectMake(originX-shadowPathWidth/2, originY-shadowPathWidth/2, sizeWith+shadowPathWidth, sizeHeight+shadowPathWidth);
    }
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:shadowRect];
    self.layer.shadowPath = bezierPath.CGPath;//阴影路径
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state{
    [super setTitleColor:color forState:state];
    
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    if (state == UIControlStateNormal) {
        self.unSelectedColorR = red;
        self.unSelectedColorB = blue;
        self.unSelectedColorG = green;
    }else{
        self.selectedColorR = red;
        self.selectedColorB = blue;
        self.selectedColorG = green;
    }
    
}

- (void)setAttributedTitle:(NSAttributedString *)title forState:(UIControlState)state{
    [super setAttributedTitle:title forState:state];
    UIColor *color = [title attribute:NSForegroundColorAttributeName atIndex:0 effectiveRange:nil];
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    if (state == UIControlStateNormal) {
        self.unSelectedColorR = red;
        self.unSelectedColorB = blue;
        self.unSelectedColorG = green;
    }else{
        self.selectedColorR = red;
        self.selectedColorB = blue;
        self.selectedColorG = green;
    }
}
@end


static char badgeViewKey;
static NSInteger const pointWidth = 7; //小红点的宽高
@implementation WMZPageNaviBtn (HMBadge)
- (void)showBadgeWithTopMagin:(NSDictionary*)info
{
    if (self.badge == nil) {
        CGRect frame = CGRectMake(self.maxSize.width+self.param.wMenuCellMargin/2, self.param.wMenuCellPadding/2-pointWidth, pointWidth, pointWidth);
        self.badge = [[UILabel alloc] initWithFrame:frame];
        self.badge.backgroundColor = PageColor(0xff5153);
        self.badge.layer.cornerRadius = pointWidth / 2;
        self.badge.layer.masksToBounds = YES;
        self.badge.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.badge];
        [self bringSubviewToFront:self.badge];
        if (self.param.wCustomRedView) {
            self.param.wCustomRedView(self.badge,info);
        }
    }
}

- (void)hidenBadge
{
    if (self.badge) {
        [self.badge removeFromSuperview];
    }
}

#pragma mark - GetterAndSetter

- (UILabel *)badge
{
    return objc_getAssociatedObject(self, &badgeViewKey);
}

- (void)setBadge:(UILabel *)badge
{
    objc_setAssociatedObject(self, &badgeViewKey, badge, OBJC_ASSOCIATION_RETAIN);
}


@end

@implementation UIColor (GradientColor)

+ (instancetype)bm_colorGradientChangeWithSize:(CGSize)size
                direction:(PageGradientChangeDirection)direction
                startColor:(UIColor*)startcolor
                endColor:(UIColor*)endColor{
      if(CGSizeEqualToSize(size,CGSizeZero) || !startcolor || !endColor) {
           return nil;
       }
      CAGradientLayer *gradientLayer = [CAGradientLayer layer];
      gradientLayer.frame=CGRectMake(0,0, size.width, size.height);
      CGPoint startPoint = CGPointZero;
      if (direction == PageGradientChangeDirectionDownDiagonalLine) {
         startPoint =CGPointMake(0.0,1.0);
      }
      gradientLayer.startPoint= startPoint;
      CGPoint endPoint = CGPointZero;
      switch(direction) {
           case PageGradientChangeDirectionLevel:
               endPoint =CGPointMake(1.0,0.0);
               break;
           case PageGradientChangeDirectionVertical:
               endPoint =CGPointMake(0.0,1.0);
               break;
           case PageGradientChangeDirectionUpwardDiagonalLine:
               endPoint =CGPointMake(1.0,1.0);
               break;
           case PageGradientChangeDirectionDownDiagonalLine:
               endPoint =CGPointMake(1.0,0.0);
               break;
           default:
               break;

       }
       gradientLayer.endPoint= endPoint;
       gradientLayer.colors=@[(__bridge id)startcolor.CGColor, (__bridge id)endColor.CGColor];
       UIGraphicsBeginImageContext(size);
       [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
       UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
       UIGraphicsEndImageContext();
       return [UIColor colorWithPatternImage:image];
}

@end

@implementation UIView(PageBorder)


- (void)viewPathWithColor:(UIColor *)shadowColor  PathType:(PageShadowPathType)shadowPathType PathWidth:(CGFloat)shadowPathWidth heightScale:(CGFloat)sacle{
    
    CGRect shadowRect = CGRectZero;
    CGFloat originX,originY,sizeWith,sizeHeight;
    originX = 0;
    originY = self.bounds.size.height*(1-sacle)/2;
    sizeWith = self.bounds.size.width;
    sizeHeight = self.bounds.size.height*sacle;
    
    if (shadowPathType == PageShadowPathTop) {
        shadowRect = CGRectMake(originX, originY-shadowPathWidth/2, sizeWith, shadowPathWidth);
    }else if (shadowPathType == PageShadowPathBottom){
        shadowRect = CGRectMake(originY, sizeHeight-shadowPathWidth/2, sizeWith, shadowPathWidth);
    }else if (shadowPathType == PageShadowPathLeft){
        shadowRect = CGRectMake(originX-shadowPathWidth/2, originY+sizeHeight/4, shadowPathWidth, sizeHeight/2);
    }else if (shadowPathType == PageShadowPathRight){
        shadowRect = CGRectMake(sizeWith-shadowPathWidth/2, originY, shadowPathWidth, sizeHeight);
    }else if (shadowPathType == PageShadowPathCommon){
        shadowRect = CGRectMake(originX-shadowPathWidth/2, 2, sizeWith+shadowPathWidth, sizeHeight+shadowPathWidth/2);
    }else if (shadowPathType == PageShadowPathAround){
        shadowRect = CGRectMake(originX-shadowPathWidth/2, originY-shadowPathWidth/2, sizeWith+shadowPathWidth, sizeHeight+shadowPathWidth);
    }
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:shadowRect];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    layer.fillColor = shadowColor.CGColor;
    [self.layer addSublayer:layer];
}

@end
