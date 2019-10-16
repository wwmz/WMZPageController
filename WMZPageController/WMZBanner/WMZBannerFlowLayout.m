//
//  WMZBannerFlowLayout.m
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZBannerFlowLayout.h"
@interface WMZBannerFlowLayout()
@property(nonatomic,strong)NSDictionary *config;
@end
@implementation WMZBannerFlowLayout
- (instancetype)initConfigureWithModel:(WMZBannerParam *)param{
    if (self = [super init]) {
        self.param = param;
    }
    return self;
}


- (void)prepareLayout
{
    [super prepareLayout];
    self.itemSize = self.param.wItemSize;
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = self.param.wLineSpacing;
    self.sectionInset = self.param.wSectionInset;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:rect]];
    if (!self.param.wScale) {
        return array;
    }
    CGRect  visibleRect = CGRectZero;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    for (UICollectionViewLayoutAttributes *attributes  in array) {
        CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
        CGFloat normalizedDistance = fabs(distance / self.param.wActiveDistance);
        CGFloat zoom = 1 - self.param.wScaleFactor  * normalizedDistance;
        attributes.transform3D = CATransform3DMakeScale(1.0, zoom, 1.0);
        attributes.frame = CGRectMake(attributes.frame.origin.x, attributes.frame.origin.y + zoom, attributes.size.width, attributes.size.height);
        if (true) {
           attributes.alpha = zoom;
        }
        attributes.center = CGPointMake(attributes.center.x, (self.param.wPosition == BannerCellPositionBottom?attributes.center.y:self.collectionView.center.y) + zoom);

    }
    return array;
}


//每个cell的布局设置
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    //获取cell的布局
//    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    
//    
//    //设置frame
//    CGRect frame;
//    frame.origin.x = self.collectionView.bounds.size.width / 2 - self.param.wItemSize.width / 2 + self.collectionView.contentOffset.x;
//    frame.origin.y = (self.collectionViewContentSize.height - self.param.wItemSize.height) / 2;
//    frame.size.width = self.param.wItemSize.width;
//    frame.size.height = self.param.wItemSize.height;
//    layoutAttributes.frame = frame;
//    
//    //设置ratio
//    CGFloat page = (indexPath.item - indexPath.item % 2) * 0.5; //结果 0,0,1,1,2,2 ...
//    CGFloat ratio = - 0.5 + page - (self.collectionView.contentOffset.x / self.collectionView.bounds.size.width); //通过偏移量,获取比重
//    //限制比重
//    if (ratio > 0.5) {
//        ratio = 0.5 + 0.1 * (ratio - 0.5);
//    } else if (ratio < -0.5) {
//        ratio = - 0.5 + 0.1 * (ratio + 0.5);
//    }
//    
//    
//    //
//    if ((ratio > 0 && indexPath.item % 2 == 1) || (ratio < 0 && indexPath.item % 2 == 0)) {
//        if (indexPath.row != 1) {
//            return nil;
//        }
//    }
//    
//    
//    //计算旋转角度angle,设定3D旋转
//    CGFloat newRatio = MIN(MAX(ratio, -1), 1);
//    //计算m34
//    CATransform3D transform = CATransform3DIdentity;
//    transform.m34 = 1.0 / - 2000;
//    
//    CGFloat angle = 0.0f;
//    if (indexPath.item % 2 == 0) {
//        //中心线在左边
//        angle = (1 - newRatio) * (-M_PI_2);
//    } else if (indexPath.item % 2 == 1) {
//        //中心线在右边
//        angle = (1 + newRatio) * (M_PI_2);
//    }
//    angle += (indexPath.row % 2) / 1000;
//    
//    transform = CATransform3DRotate(transform, angle, 0, 1, 0);
//    
//    layoutAttributes.transform3D = transform;
//    if (indexPath.row == 0) {
//        layoutAttributes.zIndex = NSIntegerMax;
//    }
//    return layoutAttributes;
//}


//防止报错
- (NSArray *)getCopyOfAttributes:(NSArray *)attributes
{
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return ![self.collectionView isPagingEnabled];
}


/**
 * collectionView停止滚动时的偏移量
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    if ([self.collectionView isPagingEnabled]) {
        return proposedContentOffset;
    }
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
  
    
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * self.param.wContentOffsetX;
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }

    proposedContentOffset.x += minDelta;

    self.param.myCurrentPath = round((ABS(proposedContentOffset.x))/(self.param.wItemSize.width+self.param.wLineSpacing));

    return proposedContentOffset;
    
}

@end
