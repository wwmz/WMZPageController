//
//  WMZPageNaviBtn.h
//  WMZPageController
//
//  Created by wmz on 2019/9/22.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZPageConfig.h"
#import "WMZPageParam.h"

NS_ASSUME_NONNULL_BEGIN
@interface WMZPageLabel:UILabel
/// 内边距
@property (nonatomic, assign) UIEdgeInsets pageEdgeInsets;

@end

@interface WMZPageNaviBtn : UIButton
/// 角标
@property (nonatomic, strong) WMZPageLabel *badge;
/// jdLayer
@property (nonatomic, strong) UIView *jdLayer;
/// 参数
@property (nonatomic, strong) WMZPageParam *param;
/// 配置参数
@property (nonatomic, strong) id config;
/// 最大size
@property (nonatomic, assign) CGSize maxSize;
/// 仅点击不加载页面 保持原页面 
@property (nonatomic, assign) PageBTNTapType tapType;
/// 初始文本内容
@property (nonatomic,   copy) NSString *normalText;
/// 选中文本
@property (nonatomic,   copy) NSString *selectText;
/// RGB值
@property (nonatomic, assign, readonly) CGFloat selectedColorR;

@property (nonatomic, assign, readonly) CGFloat selectedColorG;

@property (nonatomic, assign, readonly) CGFloat selectedColorB;

@property (nonatomic, assign, readonly) CGFloat unSelectedColorR;

@property (nonatomic, assign, readonly) CGFloat unSelectedColorG;

@property (nonatomic, assign, readonly) CGFloat unSelectedColorB;

@property (nonatomic, assign ,readonly) CGFloat selectAlpah;

@property (nonatomic, assign ,readonly) CGFloat unSelectAlpah;
/// 富文本图片
@property (nonatomic, strong)NSAttributedString* attributedImage;
/// 富文本选中图片
@property (nonatomic, strong)NSAttributedString* attributedSelectImage;
/// 显示小红点
/// @param info info
- (void)showBadgeWithTopMagin:(NSDictionary*)info;
/// 隐藏小红点
- (void)hidenBadge;
/// 富文本
- (NSAttributedString*)setImageWithStr:(NSString*)str
                                  font:(UIFont*)font
                         textAlignment:(NSTextAlignment)textAlignment
                             textColor:(nullable UIColor*)textColor
                                height:(CGFloat)height
                       backgroundColor:(nullable UIColor*)backgroundColor
                          cornerRadius:(CGFloat)cornerRadius;
/// 设置图文位置
- (void)tagSetImagePosition:(PageBtnPosition)postion spacing:(CGFloat)spacing;
/// 设置单边阴影
- (void)viewShadowPathWithColor:(UIColor *)shadowColor
                  shadowOpacity:(CGFloat)shadowOpacity
                   shadowRadius:(CGFloat)shadowRadius
                 shadowPathType:(PageShadowPathType)shadowPathType
                shadowPathWidth:(CGFloat)shadowPathWidth;
/// 设置圆角
-(void)setRadii:(CGSize)size RoundingCorners:(UIRectCorner)rectCorner;
/// jdAddLayer
- (void)jdAddLayer;
/// jdRemoveLayer
- (void)jdRemoveLayer;
@end

@interface UIColor (GradientColor)
///  设置渐变色
+ (instancetype)bm_colorGradientChangeWithSize:(CGSize)size
                direction:(PageGradientChangeDirection)direction
                startColor:(UIColor*)startcolor
                endColor:(UIColor*)endColor;
@end

@interface UIView (PageRect)
///  设置单边框
- (void)viewPathWithColor:(UIColor *)shadowColor
                 pathType:(PageShadowPathType)shadowPathType
                pathWidth:(CGFloat)shadowPathWidth
              heightScale:(CGFloat)sacle;
- (void)page_y:(CGFloat)y;
- (void)page_x:(CGFloat)y;
- (void)page_width:(CGFloat)width;
- (void)page_height:(CGFloat)height;

@end

@interface NSObject (SafeKVO)
/// 安全增加观察者
- (void)pageAddObserver:(nonnull NSObject *)observer forKeyPath:(nonnull NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;
///  安全删除观察者
- (void)pageRemoveObserver:(nonnull NSObject *)observer forKeyPath:(nonnull NSString *)keyPath context:(nullable void *)context;

@end

NS_ASSUME_NONNULL_END
