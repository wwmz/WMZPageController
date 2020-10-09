//
//  NSObject+SafeKVO.h
//  WMZPageController
//
//  Created by wmz on 2019/10/16.
//  Copyright © 2019 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SafeKVO)
/*!
 @method
 @abstract   移除所有观察的keypath
 */
- (void)removeAllObserverdKeyPath:(NSObject*)VC withKey:(NSString*)key;
/*!
@method
@abstract   安全增加观察者
*/
- (void)pageAddObserver:(nonnull NSObject *)observer forKeyPath:(nonnull NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;
/*!
@method
@abstract   安全删除观察者
*/
- (void)paegRemoveObserver:(nonnull NSObject *)observer forKeyPath:(nonnull NSString *)keyPath context:(nullable void *)context;

@end


NS_ASSUME_NONNULL_END
