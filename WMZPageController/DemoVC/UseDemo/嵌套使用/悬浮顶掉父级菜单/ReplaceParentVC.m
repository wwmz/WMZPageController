//
//  ReplaceParentVC.m
//  WMZPageController
//
//  Created by wmz on 2021/8/11.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "ReplaceParentVC.h"
#import "ReplaceParentSonVC.h"
@interface ReplaceParentVC ()

@end

@implementation ReplaceParentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WMZPageParam *headParam = PageParam()
    .wTitleArrSet(@[@"关注",@"推荐"])
    .wViewControllerSet(^UIViewController *(NSInteger num) {
        return [ReplaceParentSonVC new];
    })
    .wMenuPositionSet(PageMenuPositionCenter)
    .wMenuAnimalSet(PageTitleMenuPDD)
    .wMenuWidthSet(150);
    self.param = headParam;
}

@end
