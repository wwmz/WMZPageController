//
//  WMZPageDataView.h
//  WMZPageController
//
//  Created by wmz on 2020/9/27.
//  Copyright © 2020 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WMZPageDataView : UIScrollView
@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,assign)NSInteger lastIndex;
@property(nonatomic,assign)NSInteger totalCount;
@property(nonatomic,assign)NSInteger level;
@property(nonatomic,assign)BOOL left;
@end

NS_ASSUME_NONNULL_END
