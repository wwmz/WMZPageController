//
//  Base.h
//  WMZPageController
//
//  Created by wmz on 2019/10/10.
//  Copyright © 2019 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMZPageController.h"
#import "TestVC.h"
#import "TopSuspensionVC.h"
#import "UIImageView+WebCache.h"
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)
NS_ASSUME_NONNULL_BEGIN
@interface Base : NSObject
- (void)pushWithVC:(UIViewController*)vc withIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
