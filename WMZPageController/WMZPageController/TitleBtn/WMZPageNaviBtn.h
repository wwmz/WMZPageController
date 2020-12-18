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

@interface WMZPageNaviBtn : UIButton
@property(nonatomic,strong)WMZPageParam *param;
//最大size
@property(nonatomic,assign)CGSize maxSize;
//处于动画状态
@property(nonatomic,assign)BOOL animal;
//仅点击不加载页面 保持原页面
@property(nonatomic,assign)BOOL onlyClick;
//有红点提示
@property(nonatomic,assign)NSInteger hasBadge;
//初始文本内容
@property(nonatomic,copy)NSString* normalText;
//选中文本
@property(nonatomic,copy)NSString* selectText;
//RGB值
@property (nonatomic, assign) CGFloat selectedColorR;
@property (nonatomic, assign) CGFloat selectedColorG;
@property (nonatomic, assign) CGFloat selectedColorB;
@property (nonatomic, assign) CGFloat unSelectedColorR;
@property (nonatomic, assign) CGFloat unSelectedColorG;
@property (nonatomic, assign) CGFloat unSelectedColorB;
//富文本图片
@property(nonatomic,strong)NSAttributedString* attributedImage;
//富文本选中图片
@property(nonatomic,strong)NSAttributedString* attributedSelectImage;

- (NSAttributedString*)setImageWithStr:(NSString*)str
                                  font:(UIFont*)font
                         textAlignment:(NSTextAlignment)textAlignment
                             textColor:(nullable UIColor*)textColor
                                height:(CGFloat)height
                       backgroundColor:(nullable UIColor*)backgroundColor
                          cornerRadius:(CGFloat)cornerRadius;
//设置图文位置
- (void)TagSetImagePosition:(PageBtnPosition)postion spacing:(CGFloat)spacing;
//设置单边阴影
- (void)viewShadowPathWithColor:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowPathType:(PageShadowPathType)shadowPathType shadowPathWidth:(CGFloat)shadowPathWidth;
//设置圆角
-(void)setRadii:(CGSize)size RoundingCorners:(UIRectCorner)rectCorner;

@end

@interface WMZPageNaviBtn (HMBadge)

@property (nonatomic, strong) UILabel *badge;
/**
 *  显示小红点
 *  @magin 小红点距离控件上方距离
 */
- (void)showBadgeWithTopMagin:(NSDictionary*)info;

/**
 *  隐藏小红点
 */
- (void)hidenBadge;
@end

@interface UIColor (GradientColor)
+ (instancetype)bm_colorGradientChangeWithSize:(CGSize)size
                direction:(PageGradientChangeDirection)direction
                startColor:(UIColor*)startcolor
                endColor:(UIColor*)endColor;
@end

@interface UIView (PageBorder)
//设置单边框
- (void)viewPathWithColor:(UIColor *)shadowColor  PathType:(PageShadowPathType)shadowPathType PathWidth:(CGFloat)shadowPathWidth heightScale:(CGFloat)sacle;
@end

NS_ASSUME_NONNULL_END
