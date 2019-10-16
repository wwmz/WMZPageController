//
//  WMZBannerFlowLayout.h
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMZBannerParam.h"
NS_ASSUME_NONNULL_BEGIN

@interface WMZBannerFlowLayout : UICollectionViewFlowLayout
@property(nonatomic,strong)WMZBannerParam *param;
- (instancetype)initConfigureWithModel:(WMZBannerParam *)param;
@end

NS_ASSUME_NONNULL_END
