//
//  WMZPageController.h
//  WMZPageController
//
//  Created by wmz on 2019/9/22.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZPageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface WMZPageController : UIViewController <WMZPageScrollProcotol>
/// pageView
@property (nonatomic, strong) WMZPageView *pageView;

@end

NS_ASSUME_NONNULL_END
