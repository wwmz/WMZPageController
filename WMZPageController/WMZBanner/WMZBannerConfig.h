//
//  WMZBannerConfig.h
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//



#ifndef WMZBannerConfig_h
#define WMZBannerConfig_h

#import "UIImageView+WebCache.h"
#import <UIKit/UIKit.h>

#define BannerWitdh  [UIScreen mainScreen].bounds.size.width
#define BannerHeight [UIScreen mainScreen].bounds.size.height

#define WMZBannerPropStatementAndPropSetFuncStatement(propertyModifier,className, propertyPointerType, propertyName)           \
@property(nonatomic,propertyModifier)propertyPointerType  propertyName;                                                 \
- (className * (^) (propertyPointerType propertyName)) propertyName##Set;

#define WMZBannerPropSetFuncImplementation(className, propertyPointerType, propertyName)                                       \
- (className * (^) (propertyPointerType propertyName))propertyName##Set{                                                \
return ^(propertyPointerType propertyName) {                                                                            \
self->_##propertyName = propertyName;                                                                                         \
return self;                                                                                                            \
};                                                                                                                      \
}


/*
 * cell的block
 */
typedef UICollectionViewCell* (^BannerCellCallBlock)(NSIndexPath *indexPath,UICollectionView* collectionView,id model,UIImageView* bgImageView,NSArray*dataArr);

/*
 * 点击
 */
typedef void (^BannerClickBlock)(id anyID,NSInteger index);

/*
 *cell动画的位置
 */
typedef enum :NSInteger{
    BannerCellPositionCenter      = 0,             //居中 默认
    BannerCellPositionBottom      = 1,             //置底
}BannerCellPosition;

/*
 *pageControl的位置
 */
typedef enum :NSInteger{
    BannerControlCenter      = 0,             //居中 默认
    BannerControlLeft        = 1,             //左下
    BannerControlRight       = 2,             //右下
}BannerControlPosition;



#endif /* WMZBannerConfig_h */
