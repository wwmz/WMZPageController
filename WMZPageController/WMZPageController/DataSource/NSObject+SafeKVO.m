//
//  NSObject+SafeKVO.m
//  WMZPageController
//
//  Created by wmz on 2019/10/16.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "NSObject+SafeKVO.h"

@implementation NSObject (SafeKVO)

- (void)pageAddObserver:(nonnull NSObject *)observer forKeyPath:(nonnull NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
    if (![self hasKey:keyPath withObserver:observer]) {
        [self addObserver:observer forKeyPath:keyPath options:options context:context];
    }
}

- (void)paegRemoveObserver:(nonnull NSObject *)observer forKeyPath:(nonnull NSString *)keyPath context:(nullable void *)context {
    if ([self hasKey:keyPath withObserver:observer]) {
        [self removeObserver:observer forKeyPath:keyPath context:context];
    }
}

- (void)removeAllObserverdKeyPath:(NSObject*)VC withKey:(NSString*)key{
    id info = self.observationInfo;
    NSArray *arr = [info valueForKeyPath:@"_observances._property._keyPath"];
    NSArray *objArr = [info valueForKeyPath:@"_observances._observer"];
    if (arr) {
        for (int i = 0; i<arr.count; i++) {
            NSString *keyPath = arr[i];
            NSObject *obj = objArr[i];
            if ([keyPath isEqualToString:key]&&obj == VC) {
                [self removeObserver:VC forKeyPath:keyPath context:nil];
            }
        }
    }
    
}

- (BOOL)hasKey:(NSString *)kvoKey withObserver:(nonnull NSObject *)observer {
    BOOL hasKey = NO;
    id info = self.observationInfo;
    NSArray *arr = [info valueForKeyPath:@"_observances._property._keyPath"];
    NSArray *objArr = [info valueForKeyPath:@"_observances._observer"];
       if (arr) {
           for (int i = 0; i<arr.count; i++) {
               NSString *keyPath = arr[i];
               NSObject *obj = objArr[i];
               if ([keyPath isEqualToString:kvoKey]&&obj == observer) {
                   hasKey = YES;
                   break;
               }
           }
       }
    return hasKey;
}

@end

