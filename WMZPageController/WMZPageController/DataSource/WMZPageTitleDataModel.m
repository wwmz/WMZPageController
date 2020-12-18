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
                   controller:(UIViewController*)controller
                    titleInfo:(NSDictionary*)titleInfo{
    if (self = [super init]) {
        self.index = index;
        self.controller = controller;
        self.titleInfo = titleInfo;
    }
    return self;
}

//初始化方法
+ (instancetype)initWithIndex:(NSInteger)index
                   controller:(UIViewController*)controller
                        title:(NSString*)title{
    WMZPageTitleDataModel *model = [WMZPageTitleDataModel new];
    model.index = index;
    model.controller = controller;
    model.title = title;
    return model;
}

//初始化方法
+ (instancetype)initWithIndex:(NSInteger)index
                   controller:(UIViewController*)controller
                    titleInfo:(NSDictionary*)titleInfo{
    WMZPageTitleDataModel *model = [WMZPageTitleDataModel new];
    model.index = index;
    model.controller = controller;
    model.titleInfo = titleInfo;
    return model;
}
@end
