//
//  WMZPageTitleDataModel.m
//  WMZPageController
//
//  Created by wmz on 2020/10/29.
//  Copyright © 2020 wmz. All rights reserved.
//
#import "WMZPageTitleDataModel.h"
@implementation WMZPageTitleDataModel

- (instancetype)initWithIndex:(NSInteger)index controller:(UIViewController*)controller title:(NSString*)title{
    if (self = [super init]) {
        self.index = index;
        self.controller = controller;
        self.title = title;
    }
    return self;
}

- (instancetype)initWithIndex:(NSInteger)index
                   controller:(UIResponder*)controller
                    titleInfo:(NSDictionary*)titleInfo{
    if (self = [super init]) {
        self.index = index;
        self.controller = controller;
        self.titleInfo = titleInfo;
    }
    return self;
}

+ (instancetype)initWithIndex:(NSInteger)index
                   controller:(UIResponder*)controller
                        title:(NSString*)title{
    return [[WMZPageTitleDataModel alloc]initWithIndex:index controller:controller title:title];
}

+ (instancetype)initWithIndex:(NSInteger)index
                   controller:(UIResponder*)controller
                    titleInfo:(NSDictionary*)titleInfo{
    return [[WMZPageTitleDataModel alloc]initWithIndex:index controller:controller titleInfo:titleInfo];
}

@end
