//
//  WMZPageLoopView.h
//  WMZPageController
//
//  Created by wmz on 2019/9/22.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZPageConfig.h"
#import "WMZPageNaviBtn.h"
#import "WMZPageParam.h"
NS_ASSUME_NONNULL_BEGIN

@protocol WMZPageLoopDelegate <NSObject>


@optional

- (void)selectWithBtn:(UIButton*)btn first:(BOOL)first;

@end

@interface WMZPageLoopView : UIView

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)UIButton *lineView;

@property(nonatomic,strong)NSMutableArray *btnArr;

@property(nonatomic,weak)id <WMZPageLoopDelegate> loopDelegate;

- (instancetype)initWithFrame:(CGRect)frame param:(WMZPageParam*)param;

- (void)scrollToIndex:(NSInteger)newIndex;

@end

NS_ASSUME_NONNULL_END
