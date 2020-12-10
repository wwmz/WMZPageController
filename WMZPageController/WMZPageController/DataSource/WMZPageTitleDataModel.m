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
@end
