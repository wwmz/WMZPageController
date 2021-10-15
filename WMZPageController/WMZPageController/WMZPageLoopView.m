//
//  WMZPageLoopView.m
//  WMZPageController
//
//  Created by wmz on 2019/9/22.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZPageLoopView.h"
#import "WMZPageController.h"
#import "WMZPageProtocol.h"
@interface WMZPageLoopView()<UIScrollViewDelegate,WMZPageMunuDelegate>{
    CGFloat lastContentOffset;
    NSInteger _currentTitleIndex;
}
/// frame配置
@property (nonatomic, strong) NSDictionary *frameInfo;
/// 参数
@property (nonatomic, strong) WMZPageParam  *param;

@end

@implementation WMZPageLoopView

- (instancetype)initWithFrame:(CGRect)frame param:(WMZPageParam*)param{
    if (self = [super initWithFrame:frame]) {
        self.param = param;
        self.currentTitleIndex = -1;
        self.backgroundColor = param.wBgColor;
        [self setUp];
    }
    return self;
}

- (void)setUp{
    self.currentTitleIndex = NSNotFound;
    /// 菜单栏
    [self addSubview:self.mainView];
    self.mainView.frame = [self.frameInfo[@(self.param.wMenuPosition)] CGRectValue];
    self.mainView.menuDelegate = self;
    self.mainView.param = self.param;
    self.lineView = self.mainView.lineView;
    self.btnArr = self.mainView.btnArr;
    self.fixBtnArr = self.mainView.fixBtnArr;
    [self.fixBtnArr enumerateObjectsUsingBlock:^(WMZPageNaviBtn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
        [self addSubview:obj];
    }];
    /// 视图层
    [self addSubview:self.dataView];
    self.dataView.scrollEnabled = self.param.wScrollCanTransfer;
    self.dataView.contentSize = CGSizeMake(self.param.wTitleArr.count*PageVCWidth,0);
    self.dataView.delegate = self;
    self.dataView.totalCount = self.param.wTitleArr.count;
    self.dataView.respondGuestureType = self.param.wRespondGuestureType;
    self.dataView.globalTriggerOffset = self.param.wGlobalTriggerOffset;
    /// 布局frame
    if (self.param.wMenuPosition == PageMenuPositionBottom) {
        CGRect rect = self.frame;
        rect.origin.y -= self.frame.size.height;
        if (PageIsIphoneX) {
            rect.size.height += 15;
            rect.origin.y -= 15;
        }
        self.frame = rect;
    }
    if (!self.param.wMenuIndicatorY) self.param.wMenuIndicatorY = 5;
    self.mainView.contentInset = UIEdgeInsetsMake(0, self.param.wMenuInsets.left, 0, self.param.wMenuInsets.right);
}

#pragma -mark menuDelegate
- (void)titleClick:(WMZPageNaviBtn *)btn fix:(BOOL)fixBtn{
    if (!fixBtn) [self tap:btn];
}

//标题点击
- (void)tap:(WMZPageNaviBtn*)btn{
    NSInteger index = [self.btnArr indexOfObject:btn];
    if (index == NSNotFound  || index > self.btnArr.count) return;
    if (self.param.wEventClick) self.param.wEventClick(btn, btn.tag);
    if (self.currentTitleIndex == index) return;
    if (!btn.isOnlyClick) {
        if (self.loopDelegate&&[self.loopDelegate respondsToSelector:@selector(selectBtnWithIndex:)]) [self.loopDelegate selectBtnWithIndex:index];
        if (self.currentTitleIndex == NSNotFound) {
            self.lastPageIndex = self.currentTitleIndex;
            self.nextPageIndex = index;
            self.currentTitleIndex = index;
            UIViewController *newVC = [self getVCWithIndex:index];
            self.currentVC = newVC;
            [self viewProtocolAction:@"wa" view:newVC];
            [self addChildVC:index VC:newVC];
            [self viewProtocolAction:@"da" view:newVC];
            [self.dataView setContentOffset:CGPointMake(index*PageVCWidth, 0) animated:NO];
            if (self.param.wEventEndTransferController)self.param.wEventEndTransferController(nil, newVC, 0, index);
            if (self.loopDelegate &&
                [self.loopDelegate respondsToSelector:@selector(setUpSuspension:index:end:)]) [self.loopDelegate setUpSuspension:newVC index:index end:YES];
        }else{
            [self beginAppearanceTransitionWithIndex:index withOldIndex:self.currentTitleIndex];
            self.lastPageIndex = self.currentTitleIndex;
            self.nextPageIndex = index;
            self.currentTitleIndex = index;
            [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.lastPageIndex isFlag:NO];
            [self.dataView setContentOffset:CGPointMake(index*PageVCWidth, 0) animated:self.param.wTapScrollAnimal];
        }
    }
}

#pragma -mark- scrollerDeleagte
- (void)scrollViewWillBeginDragging:(WMZPageDataView *)scrollView{
    if (scrollView != self.dataView) return;
    lastContentOffset = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(WMZPageDataView *)scrollView{
    if (scrollView != self.dataView) return;
    ///矫正
    if (self.dataView.totalCount != self.param.wTitleArr.count)
        self.dataView.totalCount = self.param.wTitleArr.count;

    if (scrollView.contentOffset.x < 0)
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];

    if (scrollView.contentOffset.x > PageVCWidth * (self.param.wTitleArr.count - 1))
        [scrollView setContentOffset:CGPointMake(PageVCWidth * (self.param.wTitleArr.count - 1), 0) animated:NO];
    
    if (scrollView.popGuestureOffset >= 0 && self.param.wRespondGuestureType != PagePopNone){
        [scrollView setContentOffset:CGPointMake(scrollView.popGuestureOffset, 0) animated:NO]; return;
    }
    
    if (![scrollView isDecelerating]&&![scrollView isDragging]) return;
    if (scrollView.contentOffset.x>0 &&scrollView.contentOffset.x<=self.param.wTitleArr.count*PageVCWidth ) {
         [self lifeCycleManage:scrollView];
         [self.mainView animalAction:scrollView lastContrnOffset:lastContentOffset];
    }
    if (scrollView.contentOffset.y == 0) return;
    CGPoint contentOffset = scrollView.contentOffset;
    contentOffset.y = 0.0;
    scrollView.contentOffset = contentOffset;
}

- (void)scrollViewDidEndDragging:(WMZPageDataView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView != self.dataView) return;
    if (self.dataView.popGuestureOffset != -1) self.dataView.popGuestureOffset = -1;
    if (!decelerate) {
        NSInteger newIndex = scrollView.contentOffset.x/PageVCWidth;
        self.currentTitleIndex = newIndex;
        if (self.loopDelegate && [self.loopDelegate respondsToSelector:@selector(pageScrollEndWithScrollView:)]) [self.loopDelegate pageScrollEndWithScrollView:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(WMZPageDataView *)scrollView{
    if (scrollView != self.dataView) return;
    if (self.dataView.popGuestureOffset != -1) self.dataView.popGuestureOffset = -1;
    NSInteger newIndex = scrollView.contentOffset.x/PageVCWidth;
    self.currentTitleIndex = newIndex;
    if (!self.hasEndAppearance) [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.lastPageIndex isFlag:NO];
    self.hasEndAppearance = NO;
    [self.mainView scrollToIndex:newIndex animal:YES];
    if (self.loopDelegate && [self.loopDelegate respondsToSelector:@selector(pageScrollEndWithScrollView:)]) [self.loopDelegate pageScrollEndWithScrollView:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (self.dataView.popGuestureOffset != -1) self.dataView.popGuestureOffset = -1;
}

/// 管理生命周期
- (void)lifeCycleManage:(UIScrollView*)scrollView{
    CGFloat diffX = scrollView.contentOffset.x - lastContentOffset;
    NSInteger currentIndex = diffX < 0 ? ceil(scrollView.contentOffset.x/PageVCWidth) : (scrollView.contentOffset.x/PageVCWidth);
    if (self.currentTitleIndex != currentIndex &&
        self.param.wMenuFollowSliding) {
        [self.mainView scrollToIndex:currentIndex animal:YES];
    }
    self.currentTitleIndex = currentIndex;
    
    if (self.loopDelegate && [self.loopDelegate respondsToSelector:@selector(pageWithScrollView:left:)]) [self.loopDelegate pageWithScrollView:scrollView left:(diffX < 0)];
    if (diffX > 0) {
        if (self.hasDealAppearance&&self.nextPageIndex == self.currentTitleIndex) {
            self.hasEndAppearance = YES;
            [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.currentTitleIndex-1 isFlag:YES];
            return;
        }
        if (!self.hasDealAppearance || self.nextPageIndex != self.currentTitleIndex + 1) {
            self.hasDealAppearance = YES;
            if (self.nextPageIndex == self.currentTitleIndex - 1) {
               [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.currentTitleIndex isFlag:NO];
                self.hasDifferenrDirection = YES;
            }
            self.nextPageIndex = self.currentTitleIndex + 1;
            self.lastPageIndex = self.currentTitleIndex ;
            [self beginAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.currentTitleIndex];
        }
    }else if(diffX < 0){
        if (self.hasDealAppearance&&self.nextPageIndex == self.currentTitleIndex) {
            self.hasEndAppearance = YES;
            [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.currentTitleIndex+1 isFlag:YES];
            return;
        }
        if (!self.hasDealAppearance || self.nextPageIndex != self.currentTitleIndex - 1) {
            self.hasDealAppearance = YES;
            if (self.nextPageIndex == self.currentTitleIndex + 1) {
                [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.currentTitleIndex isFlag:NO];
                self.hasDifferenrDirection = YES;
            }
            self.nextPageIndex = self.currentTitleIndex - 1;
            self.lastPageIndex = self.currentTitleIndex ;
            [self beginAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.currentTitleIndex];
        }
    }
}

- (UIViewController*)getVCWithIndex:(NSInteger)index{
    UIViewController *controller = nil;
    if (index < 0 || index >= self.param.wTitleArr.count)  return controller;
    controller = [[self findBelongViewControllerForView:self].cache objectForKey:@(index)];
    if (controller) return controller;
    if (self.param.wControllers) {
        controller = self.param.wControllers[index];
        if (controller)  return controller;
    }else{
        if (self.param.wViewController) {
            controller = self.param.wViewController(index);
            if (controller) return controller;
        }
    }
    return controller;
}

- (void)beginAppearanceTransitionWithIndex:(NSInteger)index withOldIndex:(NSInteger)old{
    UIViewController *newVC = [self getVCWithIndex:index];
    UIViewController *oldVC = [self getVCWithIndex:old];
    if (!newVC || !oldVC || (index==old) || (oldVC==newVC)) return;
    [self appearanceTransition:YES end:NO controller:newVC];
    [self addChildVC:index VC:newVC];
    [self appearanceTransition:NO end:NO controller:oldVC];
    self.currentVC = newVC;
    if (self.loopDelegate&&[self.loopDelegate respondsToSelector:@selector(setUpSuspension:index:end:)]) [self.loopDelegate setUpSuspension:newVC index:index end:NO];
    if (self.param.wEventBeganTransferController) self.param.wEventBeganTransferController(oldVC, newVC, old, index);
}

- (void)addChildVC:(NSInteger)index VC:(UIViewController*)newVC{
    if (!newVC) return;
    WMZPageController *parentVC = [self findBelongViewControllerForView:self];
    CGRect frame = CGRectMake(index * self.dataView.frame.size.width,0,self.dataView.frame.size.width,
                              self.dataView.frame.size.height);
    if ([parentVC.parentViewController isKindOfClass:[WMZPageController class]]) {
        WMZPageController *parentViewController = (WMZPageController*)parentVC.parentViewController;
        self.dataView.level = parentViewController.upSc.dataView.level - 1;
    }
    if ([newVC isKindOfClass:UIViewController.class]) {
        if (![parentVC.childViewControllers containsObject:newVC]) {
            [parentVC addChildViewController:newVC];
            newVC.view.frame = frame;
            [self.dataView addSubview:newVC.view];
            [newVC didMoveToParentViewController:parentVC];
            [parentVC.cache setObject:newVC forKey:@(index)];
        }
    }else if ([newVC isKindOfClass:UIView.class]){
        UIView *tempView = (UIView*)newVC;
        tempView.frame = frame;
        [self.dataView addSubview:tempView];
        [parentVC.cache setObject:newVC forKey:@(index)];
    }
}

- (void)endAppearanceTransitionWithIndex:(NSInteger)index withOldIndex:(NSInteger)old  isFlag:(BOOL)flag{
    UIViewController *newVC = [self getVCWithIndex:index];
    UIViewController *oldVC = [self getVCWithIndex:old];
    if (!newVC || !oldVC || (index == old)) return;
    if (self.currentTitleIndex == self.nextPageIndex) {
        if ([oldVC isKindOfClass:UIViewController.class]) {
            [oldVC willMoveToParentViewController:nil];
            [oldVC.view removeFromSuperview];
            [oldVC removeFromParentViewController];
        }else if ([oldVC isKindOfClass:UIView.class]) {
            UIView *tempView = (UIView*)oldVC;
            [tempView removeFromSuperview];
        }
        [self appearanceTransition:YES end:YES controller:newVC];
        [self appearanceTransition:NO end:YES controller:oldVC];
        if (flag && self.hasDifferenrDirection) {
            [self appearanceTransition:YES  end:YES controller:newVC];
            [self appearanceTransition:NO  end:YES controller:oldVC];
            self.hasDifferenrDirection = NO;
        }
        if (self.param.wEventEndTransferController) self.param.wEventEndTransferController(oldVC, newVC, old, index);
        self.currentVC = newVC;
        self.currentTitleIndex = index;
        if (self.loopDelegate&&[self.loopDelegate respondsToSelector:@selector(setUpSuspension:index:end:)]) [self.loopDelegate setUpSuspension:newVC index:index end:YES];
    }else{
        if ([newVC isKindOfClass:UIViewController.class]) {
            [newVC willMoveToParentViewController:nil];
            [newVC.view removeFromSuperview];
            [newVC removeFromParentViewController];
        }else if ([newVC isKindOfClass:UIView.class]) {
            UIView *tempView = (UIView*)newVC;
            [tempView removeFromSuperview];
        }
        [self appearanceTransition:YES end:NO controller:oldVC];
        [self appearanceTransition:YES end:YES controller:oldVC];
        [self appearanceTransition:NO end:NO controller:newVC];
        [self appearanceTransition:NO end:YES controller:newVC];
        if (self.param.wEventEndTransferController) self.param.wEventEndTransferController(newVC, oldVC, index, old);
        self.currentVC = oldVC;
        self.currentTitleIndex = old;
        if (self.loopDelegate&&[self.loopDelegate respondsToSelector:@selector(setUpSuspension:index:end:)]) [self.loopDelegate setUpSuspension:oldVC index:old end:YES];
    }
    self.hasDealAppearance = NO;
    self.nextPageIndex = -999;
}

/// 控制器生命周期
- (void)appearanceTransition:(BOOL)isAppearing end:(BOOL)end controller:(UIViewController*)VC{
    if (!VC) return;;
    if (end) {
        if ([VC isKindOfClass:UIViewController.class]) [VC endAppearanceTransition];
        [self viewProtocolAction: isAppearing?@"da":@"dd" view:VC];
    }else{
        if ([VC isKindOfClass:UIViewController.class]) [VC beginAppearanceTransition:isAppearing animated:NO];
        [self viewProtocolAction: isAppearing?@"wa":@"wd" view:VC];
    }
}

/// 协议生命周期方法
- (void)viewProtocolAction:(NSString*)tag view:(id)view{
    if (!tag && ![tag isKindOfClass:NSString.class]) return;
    if (![view conformsToProtocol:@protocol(WMZPageProtocol)]) return;
    if ([tag isEqualToString:@"wa"] && [view respondsToSelector:@selector(pageViewWillAppear)]) [view pageViewWillAppear];
    if ([tag isEqualToString:@"da"] && [view respondsToSelector:@selector(pageViewDidAppear)]) [view pageViewDidAppear];
    if ([tag isEqualToString:@"wd"] && [view respondsToSelector:@selector(pageViewWillDisappear)]) [view pageViewWillDisappear];
    if ([tag isEqualToString:@"dd"] && [view respondsToSelector:@selector(pageViewDidDisappear)]) [view pageViewDidDisappear];
}

- (BOOL)canTopSuspension{
    if (!self.param.wTopSuspension
       ||self.param.wMenuPosition == PageMenuPositionBottom
        ||self.param.wMenuPosition == PageMenuPositionNavi) return NO;
    if (!self.param.wTitleArr.count) return NO;
    return YES;
}

- (nullable WMZPageController *)findBelongViewControllerForView:(UIView *)view {
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass:[WMZPageController class]]) {
            return (WMZPageController *)responder;
        }
    return nil;
}

- (WMZPageMunuView *)mainView{
    if (!_mainView) {
        _mainView = [WMZPageMunuView new];
    }
    return _mainView;
}

- (WMZPageDataView *)dataView{
    if (!_dataView) {
        _dataView = [WMZPageDataView new];
        _dataView.frame = CGRectMake(0, CGRectGetMaxY(self.mainView.frame),self.bounds.size.width, 0) ;
    }
    return _dataView;
}

- (NSDictionary *)frameInfo{
    if (!_frameInfo) {
        CGFloat menuCellMarginY = self.param.wMenuCellMarginY;
        if (!UIEdgeInsetsEqualToEdgeInsets(self.param.wMenuInsets, UIEdgeInsetsZero)) menuCellMarginY = self.param.wMenuInsets.top;
        _frameInfo = @{
            @(PageMenuPositionLeft):[NSValue valueWithCGRect:CGRectMake(0, menuCellMarginY , self.param.wMenuWidth,self.param.wMenuHeight + self.param.wMenuInsets.bottom)],
            @(PageMenuPositionRight):[NSValue valueWithCGRect:CGRectMake(PageVCWidth-self.param.wMenuWidth, menuCellMarginY , self.param.wMenuWidth,self.param.wMenuHeight + self.param.wMenuInsets.bottom )],
            @(PageMenuPositionCenter):[NSValue valueWithCGRect:CGRectMake((PageVCWidth-self.param.wMenuWidth)/2, menuCellMarginY , self.param.wMenuWidth,self.param.wMenuHeight + self.param.wMenuInsets.bottom )],
            @(PageMenuPositionNavi):[NSValue valueWithCGRect:CGRectMake((PageVCWidth-self.param.wMenuWidth)/2, menuCellMarginY , self.param.wMenuWidth,self.param.wMenuHeight + self.param.wMenuInsets.bottom )],
            @(PageMenuPositionBottom):[NSValue valueWithCGRect:CGRectMake(menuCellMarginY, PageVCHeight, self.param.wMenuWidth,(PageIsIphoneX?(self.param.wMenuHeight + 34):self.param.wMenuHeight) + self.param.wMenuInsets.bottom )],
        };
    }
    return _frameInfo;
}

- (void)setCurrentTitleIndex:(NSInteger)currentTitleIndex{
    _currentTitleIndex = currentTitleIndex;
    self.dataView.currentIndex = currentTitleIndex;
}

@end
