//
//  WMZBannerView.h
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZBannerParam.h"
NS_ASSUME_NONNULL_BEGIN

@interface WMZBannerView : UIView
/**
 *  调用方法
 *
 */
- (instancetype)initConfigureWithModel:(WMZBannerParam *)param withView:(UIView*)parentView;

/**
 *  调用方法
 *
 */
- (instancetype)initConfigureWithModel:(WMZBannerParam *)param;
/**
 *  更新UI
 *
 */
- (void)updateUI;

@end
@interface Collectioncell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)WMZBannerParam *param;
@end

NS_ASSUME_NONNULL_END
