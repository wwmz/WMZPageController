
//
//  WMZPageNaviBtn.m
//  WMZPageController
//
//  Created by wmz on 2019/9/22.
//  Copyright © 2019 wmz. All rights reserved.
//
#import "WMZPageNaviBtn.h"
@interface WMZPageNaviBtn()

@property (nonatomic, assign) CGSize minSize;
/// RGB值
@property (nonatomic, assign ,readwrite) CGFloat selectedColorR;

@property (nonatomic, assign ,readwrite) CGFloat selectedColorG;

@property (nonatomic, assign ,readwrite) CGFloat selectedColorB;

@property (nonatomic, assign ,readwrite) CGFloat unSelectedColorR;

@property (nonatomic, assign ,readwrite) CGFloat unSelectedColorG;

@property (nonatomic, assign ,readwrite) CGFloat unSelectedColorB;

@property (nonatomic, assign ,readwrite) CGFloat selectAlpah;

@property (nonatomic, assign ,readwrite) CGFloat unSelectAlpah;

@end

static NSInteger const pointWidth = 7; //小红点的宽高
@implementation WMZPageNaviBtn

- (NSString *)description{
    return [self titleForState:UIControlStateNormal];
}

- (void)showBadgeWithTopMagin:(NSDictionary*)info{
    if (![info isKindOfClass:NSDictionary.class]) return;
    id value = info[WMZPageKeyBadge];
    if (!value) return;
    if (![value isKindOfClass:NSNumber.class] && ![value isKindOfClass:NSString.class]) return;
    if ([value intValue] == 0) {
        [self hidenBadge];
        return;;
    }
    if ([value isEqual:@(-1)]) {
        self.badge.text = @"";
        self.badge.pageEdgeInsets = UIEdgeInsetsZero;
        self.badge.frame = CGRectMake(self.bounds.size.width - pointWidth * 1.5, pointWidth, pointWidth, pointWidth);
    }else{
        self.badge.backgroundColor = UIColor.redColor;
        self.badge.textColor = UIColor.whiteColor;
        self.badge.text = [NSString stringWithFormat:@"%@",info[WMZPageKeyBadge]];
        self.badge.pageEdgeInsets = UIEdgeInsetsMake(4, 7.5, 4, 7.5);
        CGSize size =  [self boundingRectWithSize:self.badge.text Font:self.badge.font Size:CGSizeMake(self.bounds.size.width/2, 10)];
        
        CGRect rect = CGRectZero;
        rect.origin.x = self.bounds.size.width - size.width - self.badge.pageEdgeInsets.left - self.badge.pageEdgeInsets.right;
        rect.origin.y = 0;
        rect.size.width = size.width + self.badge.pageEdgeInsets.right + self.badge.pageEdgeInsets.left;
        rect.size.height = size.height + self.badge.pageEdgeInsets.top + self.badge.pageEdgeInsets.bottom;
        self.badge.frame = rect;
        self.badge.layer.cornerRadius = self.badge.frame.size.height / 2;
    }
    self.badge.alpha = 1;
    [self addSubview:self.badge];
    [self bringSubviewToFront:self.badge];
    if (self.param.wCustomRedView) self.param.wCustomRedView(self.badge,info);
}

- (void)hidenBadge{
    if (!self.param.wHideRedCircle) return;;
    if (self.badge){
        [UIView animateWithDuration:0.1 animations:^{
            self.badge.alpha = 0;
            [self.badge removeFromSuperview];
            self.badge.text = @"";
        }];
    }
}

- (void)jdAddLayer{
    [self addSubview:self.jdLayer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.jdLayer.frame.size.height)];
    [path addQuadCurveToPoint:CGPointMake(self.jdLayer.frame.size.width,0) controlPoint:CGPointMake(self.jdLayer.frame.size.width * 0.5, self.jdLayer.frame.size.height)];
    
    CAShapeLayer *pathLayer = [CAShapeLayer new];
    pathLayer.frame = CGRectZero;
    pathLayer.path = path.CGPath;
    pathLayer.lineWidth = 3;
    pathLayer.fillColor = UIColor.clearColor.CGColor;
    pathLayer.strokeColor = UIColor.orangeColor.CGColor;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    animation.fromValue = @0 ;
    animation.toValue = @1 ;
    animation.duration = 0.4 ;
    [pathLayer addAnimation:animation forKey :@"strokeEnd"];
    self.jdLayer.layer.mask = pathLayer;
}

- (void)jdRemoveLayer{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.jdLayer.frame.size.width,0)];
    [path addQuadCurveToPoint:CGPointMake(0, self.jdLayer.frame.size.height) controlPoint:CGPointMake(self.jdLayer.frame.size.width * 0.5, self.jdLayer.frame.size.height)];
    CAShapeLayer *pathLayer = [CAShapeLayer new];
    pathLayer.frame = CGRectZero;
    pathLayer.path = path.CGPath;
    pathLayer.lineWidth = 3;
    pathLayer.fillColor = UIColor.clearColor.CGColor;
    pathLayer.strokeColor = UIColor.orangeColor.CGColor;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    animation.fromValue = @1 ;
    animation.toValue = @0 ;
    animation.duration = 0.2 ;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [pathLayer addAnimation:animation forKey :@"strokeEnd"];
    self.jdLayer.layer.mask = pathLayer;
}

- (void)setHighlighted:(BOOL)highlighted{}

- (void)setRadii:(CGSize)size RoundingCorners:(UIRectCorner)rectCorner{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (CGSize)boundingRectWithSize:(NSString*)txt Font:(UIFont*) font Size:(CGSize)size{
    return [txt boundingRectWithSize:size options:
            NSStringDrawingTruncatesLastVisibleLine |
            NSStringDrawingUsesLineFragmentOrigin |
            NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size;
}

- (void)tagSetImagePosition:(PageBtnPosition)postion spacing:(CGFloat)spacing {
    CGFloat imgWidth = self.imageView.bounds.size.width;
    CGFloat imgHeight = self.imageView.bounds.size.height;
    CGFloat labWidth = self.titleLabel.bounds.size.width;
    CGFloat labHeight = self.titleLabel.bounds.size.height;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    labWidth = MAX(labWidth, frameSize.width);
    labHeight = MIN(labHeight, frameSize.height);
    CGFloat kMargin = spacing/2.0;
    switch (postion) {
        case PageBtnPositionLeft:
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, -kMargin, 0, kMargin)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, kMargin, 0, -kMargin)];
            break;
        case PageBtnPositionRight:
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, labWidth + kMargin, 0, -labWidth - kMargin)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgWidth - kMargin, 0, imgWidth + kMargin)];
            break;
        case PageBtnPositionTop:
            [self setImageEdgeInsets:UIEdgeInsetsMake(0,0, labHeight + spacing, -labWidth)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(imgHeight + spacing, -imgWidth, 0, 0)];
            break;
        case PageBtnPositionBottom:
            [self setImageEdgeInsets:UIEdgeInsetsMake(labHeight + spacing,0, 0, -labWidth)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgWidth, imgHeight + spacing, 0)];
            break;
        default:break;
    }
}

- (void)viewShadowPathWithColor:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowPathType:(PageShadowPathType)shadowPathType shadowPathWidth:(CGFloat)shadowPathWidth{
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowRadius = shadowRadius;
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
        self.unSelectAlpah = alpha;
    }else{
        self.selectedColorR = red;
        self.selectedColorB = blue;
        self.selectedColorG = green;
        self.selectAlpah = alpha;
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

- (NSAttributedString*)setImageWithStr:(NSString*)str
                                  font:(UIFont*)font
                         textAlignment:(NSTextAlignment)textAlignment
                             textColor:(nullable UIColor*)textColor
                                height:(CGFloat)height
                       backgroundColor:(nullable UIColor*)backgroundColor
                          cornerRadius:(CGFloat)cornerRadius{
    if (height == 0) height = 18.0f;
    CGFloat aaW1 = [self boundingRectWithSize:str Font:font Size:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width+20;
    UILabel *aaL1 = [UILabel new];
    aaL1.frame = CGRectMake(0, 0, aaW1, height);
    aaL1.text = str;
    aaL1.font = font;
    aaL1.textAlignment = textAlignment;
    if (textColor) aaL1.textColor = textColor;
    if (cornerRadius) {
        if (backgroundColor) {
            aaL1.layer.backgroundColor = backgroundColor.CGColor;
            aaL1.layer.cornerRadius = cornerRadius;
        }
    }else{
        if (backgroundColor) aaL1.backgroundColor = backgroundColor;
    }
    UIImage *image1 = [self imageWithUIView:aaL1];
    NSTextAttachment *attach1 = [[NSTextAttachment alloc] init];
    attach1.bounds = CGRectMake(0, 10, aaW1, height);
    attach1.image = image1;
    NSAttributedString * imageStr1= [NSAttributedString attributedStringWithAttachment:attach1];
    return imageStr1;
}

/// view转成image
- (UIImage*) imageWithUIView:(UIView*) view{
   CGSize s = view.bounds.size;
   UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
   [view.layer renderInContext:UIGraphicsGetCurrentContext()];
   UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   return image;
}

- (CGSize)maxSize{
    if (!_maxSize.width||!_maxSize.height) {
        _maxSize = [self boundingRectWithSize:self.titleLabel.text Font:self.titleLabel.font Size:
                    CGSizeMake(CGFLOAT_MAX, self.param.wMenuPosition == PageMenuPositionNavi?35:CGFLOAT_MAX)];
    }
    
    return _maxSize;
}

- (WMZPageLabel *)badge{
    if (!_badge) {
        _badge = WMZPageLabel.new;
        _badge.backgroundColor = PageColor(0xff5153);
        _badge.layer.cornerRadius = pointWidth / 2;
        _badge.font = [UIFont systemFontOfSize:12];
        _badge.layer.masksToBounds = YES;
        _badge.alpha = 0;
        _badge.textAlignment = NSTextAlignmentCenter;
    }
    return _badge;
}

- (UIView *)jdLayer{
    if (!_jdLayer) {
        _jdLayer = UIView.new;
        _jdLayer.frame = CGRectMake(CGRectGetWidth(self.frame) - 20, CGRectGetHeight(self.frame) - 20, 13, 8);
    }
    return _jdLayer;
}

@end

@implementation UIColor (GradientColor)

+ (instancetype)bm_colorGradientChangeWithSize:(CGSize)size
                direction:(PageGradientChangeDirection)direction
                startColor:(UIColor*)startcolor
                endColor:(UIColor*)endColor{
    if(CGSizeEqualToSize(size,CGSizeZero) || !startcolor || !endColor)  return nil;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame=CGRectMake(0,0, size.width, size.height);
    CGPoint startPoint = CGPointZero;
    if (direction == PageGradientChangeDirectionDownDiagonalLine) startPoint =CGPointMake(0.0,1.0);
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
       default:break;
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

@implementation UIView (PageRect)

- (void)viewPathWithColor:(UIColor *)shadowColor
                 pathType:(PageShadowPathType)shadowPathType
                pathWidth:(CGFloat)shadowPathWidth
              heightScale:(CGFloat)sacle{
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

- (void)page_y:(CGFloat)y{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (void)page_x:(CGFloat)x{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (void)page_width:(CGFloat)width{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (void)page_height:(CGFloat)height{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

@end

@implementation NSObject (SafeKVO)

- (void)pageAddObserver:(nonnull NSObject *)observer forKeyPath:(nonnull NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
    if (![self hasKey:keyPath withObserver:observer]){
        [self addObserver:observer forKeyPath:keyPath options:options context:context];
    }
}

- (void)pageRemoveObserver:(nonnull NSObject *)observer forKeyPath:(nonnull NSString *)keyPath context:(nullable void *)context {
    if ([self hasKey:keyPath withObserver:observer]){
        [self removeObserver:observer forKeyPath:keyPath context:context];
    }
}

- (BOOL)hasKey:(NSString *)kvoKey withObserver:(nonnull NSObject *)observer {
    BOOL hasKey = NO;
    id info = self.observationInfo;
    NSArray *arr = [info valueForKeyPath:@"_observances._property._keyPath"];
    NSArray *objArr = [info valueForKeyPath:@"_observances._observer"];
    if (arr) {
        for (int i = 0; i<arr.count; i++) {
            NSString *keyPath = arr[i];
            if (objArr.count > i) {
                NSObject *obj = objArr[i];
                if ([keyPath isEqualToString:kvoKey]&&obj == observer) {
                    hasKey = YES;
                    break;
                }
            }
        }
    }
    return hasKey;
}

@end

@implementation WMZPageLabel

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    UIEdgeInsets insets = self.pageEdgeInsets;
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, insets)
                    limitedToNumberOfLines:numberOfLines];
    rect.origin.x -= insets.left;
    rect.origin.y -= insets.top;
    rect.size.width += (insets.left + insets.right);
    rect.size.height += (insets.top + insets.bottom);
    return rect;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.pageEdgeInsets)];
}

@end
