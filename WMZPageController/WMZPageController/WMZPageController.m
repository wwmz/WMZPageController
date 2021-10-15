//
//  WMZPageController.m
//  WMZPageController
//
//  Created by wmz on 2019/9/22.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZPageController.h"
@interface WMZPageController()
{
    BOOL hadWillDisappeal;
    NSInteger footerViewIndex;
    CGFloat sonChildVCHeight;
    CGRect pageDataFrame;
}
/// 当前子控制器中的滚动视图
@property (nonatomic, strong) UIScrollView *currentScroll;
/// 子控制器中的滚动视图数组(底部有多层的情况)
@property (nonatomic, strong) NSArray *currentScrollArr;
/// 当前子控制器中需要固定的底部视图
@property (nonatomic, strong) UIView *currentFootView;
/// 头部视图
@property (nonatomic, strong) UIView *headView;
/// 头部视图block外部传入的视图
@property (nonatomic, strong) UIView *headViewSonView;
/// 头部视图菜单栏底部的占位视图(如有需要)
@property (nonatomic, strong) UIView *head_MenuView;
/// 视图消失时候的导航栏透明度 有透明度变化的时候
@property (nonatomic, strong) NSNumber *lastAlpah;
/// 视图出现时候的导航栏透明度
@property (nonatomic, strong) NSNumber *enterAlpah;
/// 底部tableView是否可以滚动
@property (nonatomic, assign) BOOL canScroll;
/// onTableView是否可以滚动
@property (nonatomic, assign) BOOL sonCanScroll;
/// 到达顶部
@property (nonatomic, assign) BOOL scrolTotop;
/// 到达底部
@property (nonatomic, assign) BOOL scrolToBottom;
/// headSize
@property (nonatomic, assign) CGSize headSize;
///headHeight
@property (nonatomic, assign) CGFloat headHeight;
@end

@implementation WMZPageController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.naviBarBackGround && self.param.wNaviAlpha)  self.lastAlpah = @(self.naviBarBackGround.alpha);
    hadWillDisappeal = YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.naviBarBackGround && self.param.wNaviAlpha) {
        self.lastAlpah = @(self.naviBarBackGround.alpha);
        self.naviBarBackGround.alpha = self.enterAlpah?self.enterAlpah.floatValue:1;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNaviUI];
}

/// 导航栏UI
- (void)setNaviUI{
    hadWillDisappeal = NO;
    if (self.navigationController&&self.param.wNaviAlpha) {
        self.naviBarBackGround.alpha = 0;
        if (self.naviBarBackGround&&self.lastAlpah){
            self.naviBarBackGround.alpha = self.lastAlpah.floatValue;
            return;
        }
        if (self.param.wNaviAlphaAll) {
            self.naviBarBackGround = self.navigationController.navigationBar;
            self.enterAlpah = @(self.naviBarBackGround.alpha);
            [self.naviBarBackGround setAlpha:0];
        }else{
           NSMutableArray *loop= [NSMutableArray new];
           [loop addObject:[self.navigationController.navigationBar subviews]];
           while (loop.count) {
               NSArray *arr = loop.lastObject;
               [loop removeLastObject];
               for (NSInteger i = arr.count - 1; i >= 0; i--) {
                   UIView *view = arr[i];
                   [loop addObject:view.subviews];
                   if ([[UIDevice currentDevice].systemVersion intValue] >= 12 && [[UIDevice currentDevice].systemVersion intValue] < 13){
                       if ([NSStringFromClass([view class]) isEqualToString:@"UIVisualEffectView"]) {
                           self.naviBarBackGround = view;
                           self.enterAlpah = @(self.naviBarBackGround.alpha);
                           self.naviBarBackGround.alpha = 0;
                           break;
                       }
                   }else{
                       if ([NSStringFromClass([view class]) isEqualToString:@"_UIBarBackground"]||[NSStringFromClass([view class]) isEqualToString:@"_UINavigationBarBackground"]) {
                           self.naviBarBackGround = view;
                           self.enterAlpah = @(self.naviBarBackGround.alpha);
                           self.naviBarBackGround.alpha = 0;
                           break;
                       }
                   }
               }
           }
        }
    }
}

- (void)setParam{
    if (self.param.wMenuAnimal == PageTitleMenuAiQY && !self.param.wMenuIndicatorWidth) self.param.wMenuIndicatorWidth = 20;
    if (self.param.wMenuAnimal == PageTitleMenuNone||
        self.param.wMenuAnimal == PageTitleMenuCircleBg||
        self.param.wMenuAnimal == PageTitleMenuCircle||
        self.param.wMenuAnimal == PageTitleMenuPDD) self.param.wMenuAnimalTitleGradient = NO;
    if (self.param.wMenuAnimal == PageTitleMenuPDD && !self.param.wMenuIndicatorWidth) self.param.wMenuIndicatorWidth = 25;
    if (self.param.wMenuAnimal == PageTitleMenuCircle) {
        if (CGColorEqualToColor(self.param.wMenuIndicatorColor.CGColor, PageColor(0xE5193E).CGColor))  self.param.wMenuIndicatorColor = PageColor(0xe1f9fe);
        if (CGColorEqualToColor(self.param.wMenuTitleSelectColor.CGColor, PageColor(0xE5193E).CGColor)) self.param.wMenuTitleSelectColor = PageColor(0x00baf9);
        if (self.param.wMenuIndicatorHeight <= 15.0f)  self.param.wMenuIndicatorHeight = 0;
    }else if (self.param.wMenuAnimal == PageTitleMenuCircleBg) {
        if (CGColorEqualToColor(self.param.wMenuSelectTitleBackground.CGColor, [UIColor clearColor].CGColor) || !self.param.wMenuSelectTitleBackground)
            self.param.wMenuSelectTitleBackground = [UIColor orangeColor];
        if (CGColorEqualToColor(self.param.wMenuTitleSelectColor.CGColor, PageColor(0xE5193E).CGColor))  self.param.wMenuTitleSelectColor = [UIColor whiteColor];
        if (!self.param.wMenuCellMarginY)  self.param.wMenuCellMarginY = 10.f;
        if (!self.param.wMenuBottomMarginY)  self.param.wMenuBottomMarginY = 10.f;
        if (UIEdgeInsetsEqualToEdgeInsets(self.param.wMenuInsets, UIEdgeInsetsZero)) {
            self.param.wMenuInsets = UIEdgeInsetsMake(self.param.wMenuCellMarginY, 0, self.param.wMenuBottomMarginY, 0);
        }
    }
    if (self.param.wMenuPosition == PageMenuPositionNavi) {
        if (CGColorEqualToColor(self.param.wMenuBgColor.CGColor, PageColor(0xffffff).CGColor)) self.param.wMenuBgColor = [UIColor clearColor];
        if (self.param.wMenuHeight >= 55.0f) self.param.wMenuHeight = 40.0f;
    }
}


- (void)UI{
    self.cache = [NSMutableDictionary new];
    footerViewIndex = -1;
    CGFloat headY = 0;
    CGFloat tabbarHeight = 0;
    CGFloat statusBarHeight = 0;
    if (self.presentingViewController) {
        if (!self.navigationController) statusBarHeight = PageVCStatusBarHeight;
    } else if (self.tabBarController) {
        tabbarHeight = !self.tabBarController.tabBar.translucent ? 0 : PageVCTabBarHeight;
    } else if (self.navigationController){
        headY = (!self.param.wFromNavi&&
                  self.param.wMenuPosition != PageMenuPositionBottom)?0:
       (!self.navigationController.navigationBar.translucent?0:PageVCNavBarHeight);
    }
    if (self.parentViewController) {
        if ([self.parentViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *naPar = (UINavigationController*)self.parentViewController;
            headY = (!self.param.wFromNavi&&
            self.param.wMenuPosition != PageMenuPositionBottom)?0:
            (!naPar.navigationBar.translucent ?
             0: (naPar.isNavigationBarHidden ? PageVCStatusBarHeight : PageVCNavBarHeight));
            if (self.parentViewController.tabBarController) {
                if (!self.parentViewController.tabBarController.tabBar.translucent) {
                    tabbarHeight = 0;
                }else{
                    tabbarHeight = PageVCTabBarHeight;
                }
            }
        }else if ([self.parentViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *ta = (UITabBarController*)self.parentViewController;
            if (!ta.tabBar.translucent) {
                tabbarHeight = 0;
            }else{
                tabbarHeight = PageVCTabBarHeight;
            }
            if (self.parentViewController.navigationController) {
                headY = (!self.param.wFromNavi&&
                self.param.wMenuPosition != PageMenuPositionBottom)?0:(!self.parentViewController.navigationController.navigationBar.translucent?0:PageVCNavBarHeight);
            }else if(self.parentViewController.presentingViewController){
                statusBarHeight = PageVCStatusBarHeight;
            }
        }else if ([self.parentViewController isKindOfClass:[WMZPageController class]]) {
            headY = 0;
            tabbarHeight = 0;
            statusBarHeight = 0;
        }
    }
    if (self.hidesBottomBarWhenPushed &&
        tabbarHeight >= PageVCTabBarHeight)
        tabbarHeight -= PageVCTabBarHeight;
    if (self.param.wCustomNaviBarY) headY = self.param.wCustomNaviBarY(headY);
    if (self.param.wCustomTabbarY) tabbarHeight  = self.param.wCustomTabbarY(tabbarHeight);
    if (self.navigationController) {
        for (UIGestureRecognizer *gestureRecognizer in self.downSc.gestureRecognizers) {
             [gestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
        }
    }
    self.downSc.delegate = self;
    self.downSc.bounces = self.param.wBounces;
    self.view.clipsToBounds = YES;
    self.downSc.frame = CGRectMake(0, headY, self.view.bounds.size.width, self.view.bounds.size.height - headY - tabbarHeight);
    self.downSc.canScroll = [self canTopSuspension];
    self.downSc.scrollEnabled = [self canTopSuspension];
    [self.view addSubview:self.downSc];
    /// 滚动和菜单视图
    self.upSc = [[WMZPageLoopView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) param:self.param];
    self.upSc.loopDelegate = self;
    self.downSc.tableFooterView = self.upSc;
    if (self.param.wCustomMenuTitle)  self.param.wCustomMenuTitle(self.upSc.btnArr);
    /// 底部
    [self setUpMenuAndDataViewFrame];
    [self setUpHead];
    self.canScroll = YES;
    self.scrolToBottom = YES;

    [self.downSc reloadData];
    [self.downSc layoutIfNeeded];
    [self selectMenuWithIndex:self.param.wMenuDefaultIndex];
}

- (void)setUpMenuAndDataViewFrame{
    sonChildVCHeight = 0;
    CGFloat menuCellMarginY = self.param.wMenuCellMarginY;
    if (!UIEdgeInsetsEqualToEdgeInsets(self.param.wMenuInsets, UIEdgeInsetsZero)){
        menuCellMarginY = self.param.wMenuInsets.top;
    }
    CGFloat titleMenuhHeight = self.upSc.mainView.frame.size.height + menuCellMarginY;
    if (self.param.wMenuPosition == PageMenuPositionNavi) {
        sonChildVCHeight = self.downSc.bounds.size.height;
    }else if (self.param.wMenuPosition == PageMenuPositionBottom) {
        sonChildVCHeight = self.downSc.bounds.size.height - titleMenuhHeight;
    }else{
        sonChildVCHeight = self.downSc.bounds.size.height - titleMenuhHeight;
    }
    CGFloat height = [self canTopSuspension]?
    sonChildVCHeight :(sonChildVCHeight-self.headHeight);
    if ([self canTopSuspension]) {
        if (!self.parentViewController) {
            height -= PageVCStatusBarHeight;
        }else{
            if (![self.parentViewController isKindOfClass:[WMZPageController class]]) {
                if (self.navigationController&&![self.navigationController isNavigationBarHidden]) {
                    if (!self.param.wFromNavi) {
                        height -= (self.navigationController.navigationBar.translucent?
                                   PageVCNavBarHeight:0);
                    }
                }else{
                    height -= PageVCStatusBarHeight;
                }
            }
        }
    }
    sonChildVCHeight = height;
    if (self.param.wCustomDataViewHeight){
        sonChildVCHeight = self.param.wCustomDataViewHeight(sonChildVCHeight);
    }
    if (self.param.wMenuPosition == PageMenuPositionBottom){
        [self.upSc.dataView page_y:0];
        [self.upSc.dataView page_height:sonChildVCHeight];
        [self.upSc.mainView page_y:CGRectGetMaxY(self.upSc.dataView.frame)];
        [self.upSc page_height:CGRectGetMaxY(self.upSc.mainView.frame)];
    }else if (self.param.wMenuPosition == PageMenuPositionNavi && self.navigationController) {
        [self.upSc.mainView removeFromSuperview];
        [self.upSc.dataView page_y:0];
        [self.upSc.dataView page_height:sonChildVCHeight];
        [self.upSc page_height:CGRectGetMaxY(self.upSc.dataView.frame)];
        self.navigationItem.titleView = self.upSc.mainView;
    }else{
        [self.upSc.dataView page_y: CGRectGetMaxY(self.upSc.mainView.frame)];
        [self.upSc.dataView page_height:sonChildVCHeight];
        [self.upSc page_height:CGRectGetMaxY(self.upSc.dataView.frame)];
    }
    self.downSc.containHeight = self.upSc.dataView.frame.size.height;
    pageDataFrame = self.upSc.dataView.frame;
}

/// 设置头部
- (void)setUpHead{
    /// 头部视图
    if(self.param.wMenuHeadView&&
       self.param.wMenuPosition != PageMenuPositionNavi&&
       self.param.wMenuPosition != PageMenuPositionBottom) {
       self.headViewSonView = self.param.wMenuHeadView();
       self.headView = UIView.new;
       self.headView.frame = CGRectMake(0,  0, self.headViewSonView.frame.size.width, self.headViewSonView.frame.size.height);
       [self.headView addSubview:self.headViewSonView];
       self.downSc.tableHeaderView = self.headView;
    }else{
       self.downSc.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake( 0, 0,self.view.frame.size.width, CGFLOAT_MIN)];
    }
    if (self.param.wInsertHeadAndMenuBg) {
        self.head_MenuView = [UIView new];
        self.param.wInsertHeadAndMenuBg(self.head_MenuView);
    }
    /// 全景
    if (self.head_MenuView) {
        self.head_MenuView.frame = CGRectMake(0, self.headView?CGRectGetMinX(self.headView.frame):CGRectGetMinX(self.upSc.frame), self.upSc.frame.size.width, CGRectGetMaxY(self.upSc.frame)-self.upSc.dataView.frame.size.height);
        [self.downSc addSubview:self.head_MenuView];
        [self.downSc sendSubviewToBack:self.head_MenuView];
        self.upSc.backgroundColor = [UIColor clearColor];
        self.upSc.mainView.backgroundColor = [UIColor clearColor];
        for (WMZPageNaviBtn *btn in self.upSc.btnArr) {
            btn.layer.backgroundColor = [UIColor clearColor].CGColor;
        }
        if (self.headView) self.headView.backgroundColor = [UIColor clearColor];
    }
}

/// 底部滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView != self.downSc) return;
    /// 头部放大效果
    if (self.headView && self.param.wHeadScaling) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat yOffset = scrollView.contentOffset.y;
        if (yOffset < 0) {
            CGFloat totalOffset = self.headSize.height + ABS(yOffset);
            CGFloat f = totalOffset / self.headSize.height;
            self.headViewSonView.frame = CGRectMake(- (width * f - width) / 2, yOffset, width * f, totalOffset);
        }
    }
    if (![self canTopSuspension]) return;
    float yOffset  = scrollView.contentOffset.y;
    int topOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    if (yOffset <= 0) {
        self.scrolToBottom = YES;
    }else{
        if (yOffset >= topOffset)
            scrollView.contentOffset = CGPointMake(self.downSc.contentOffset.x, topOffset);
        self.scrolTotop = (yOffset >= topOffset);
        self.scrolToBottom = NO;
    }
    if (self.scrolTotop) {
        self.sonCanScroll = YES;
        self.canScroll = (self.currentScroll.contentSize.height <= self.currentScroll.frame.size.height);
    }else {
        if (!self.canScroll) {
            scrollView.contentOffset = CGPointMake(0, topOffset);
        }else {
            self.sonCanScroll = NO;
        }
    }
    if (![self currentNotSuspennsion])
        [self.downSc setContentOffset:CGPointMake(0, topOffset) animated:NO];
    
    CGFloat delta = MIN(1, MAX(0, scrollView.contentOffset.y/topOffset));
    if (self.param.wNaviAlpha) {
        if (self.navigationController && self.naviBarBackGround) self.naviBarBackGround.alpha =  delta;
        if (self.headView)  self.headView.alpha = !(delta == 1);
    }
    if (self.param.wEventChildVCDidSroll)
        self.param.wEventChildVCDidSroll(self,self.downSc.contentOffset, self.downSc.contentOffset, self.downSc);
    /// 防止第一次加载不成功
    if (self.currentFootView&&
        self.currentFootView.frame.origin.y!=
        self.footViewOrginY)
        [self.currentFootView page_y:self.footViewOrginY];
}

/// 改变菜单栏高度
- (void)changeMenuFrame{
    if (!self.param.wTopChangeHeight) return;
    if (self.upSc.mainView.frame.size.height == self.param.wMenuHeight&&!self.sonCanScroll)return;
    CGFloat offsetHeight = self.param.wTopChangeHeight > 0?
    MIN(self.currentScroll.contentOffset.y, self.param.wTopChangeHeight):
    MAX (-self.currentScroll.contentOffset.y, self.param.wTopChangeHeight);
    if (self.upSc.mainView.frame.size.height == (self.param.wMenuHeight + self.param.wMenuInsets.bottom - self.param.wTopChangeHeight)&& self.sonCanScroll&&offsetHeight == self.param.wTopChangeHeight)  return;
    [self.upSc.mainView page_height:self.param.wMenuHeight + self.param.wMenuInsets.bottom -offsetHeight ];
    [self.upSc.dataView page_y:CGRectGetMaxY(self.upSc.mainView.frame)];
    [self.upSc.dataView page_height:pageDataFrame.size.height+offsetHeight];
    if (offsetHeight == 0) {
        if (self.param.wEventMenuNormalHeight) self.param.wEventMenuNormalHeight(self.upSc.btnArr);
    }else{
        if (self.param.wEventMenuChangeHeight) self.param.wEventMenuChangeHeight(self.upSc.btnArr,self.currentScroll.contentOffset.y);
    }
     if (self.param.wMenuAnimal == PageTitleMenuAiQY||self.param.wMenuAnimal == PageTitleMenuPDD){
        CGRect rect = self.upSc.lineView.frame;
        if (rect.origin.y != ([self.upSc.mainView getMainHeight]-self.param.wMenuIndicatorY-rect.size.height/2)) {
            rect.origin.y = [self.upSc.mainView getMainHeight]-self.param.wMenuIndicatorY-rect.size.height/2;
        }
        self.upSc.lineView.frame = rect;
    }
}

/// 设置悬浮
- (void)setUpSuspension:(UIViewController*)newVC index:(NSInteger)index end:(BOOL)end{
    if (![self canTopSuspension]) return;
    if ([newVC conformsToProtocol:@protocol(WMZPageProtocol)]) {
        UIScrollView *view = nil;
        if ([newVC respondsToSelector:@selector(getMyScrollViews)]) {
            NSArray *arr = [newVC performSelector:@selector(getMyScrollViews)];
            [arr enumerateObjectsUsingBlock:^(UIScrollView*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                 [self topSuspensionView:obj index:index*1000+idx+100];
            }];
            self.currentScrollArr = arr;
        }else{
            if ([newVC respondsToSelector:@selector(getMyTableView)]) {
                UIScrollView *tmpView = [newVC performSelector:@selector(getMyTableView)];
                if (tmpView&&[tmpView isKindOfClass:[UIScrollView class]])  view = tmpView;
            }else if([newVC respondsToSelector:@selector(getMyScrollView)]){
                UIScrollView *tmpView = [newVC performSelector:@selector(getMyScrollView)];
                if (tmpView&&[tmpView isKindOfClass:[UIScrollView class]])  view = tmpView;
            }
            [self topSuspensionView:view index:index];
        }
        if ([newVC respondsToSelector:@selector(fixFooterView)]) {
            UIView *tmpView = [newVC performSelector:@selector(fixFooterView)];
            if (!tmpView) return;
            [self.sonChildFooterViewDic setObject:tmpView forKey:@(index)];
            self.currentFootView = tmpView;
            [self.view addSubview:self.currentFootView];
            self.currentFootView.hidden = NO;
            footerViewIndex = index;
            [self.currentFootView page_y:self.footViewOrginY];
        }else{
            if (self.currentFootView && end && !self.param.wFixFirst) self.currentFootView.hidden = YES;
        }
        if (![self currentNotSuspennsion]) {
            int topOffset = self.downSc.contentSize.height - self.downSc.frame.size.height;
            [self.downSc setContentOffset:CGPointMake(0, topOffset) animated:YES];
        }
    }else{
        self.currentScroll = nil;
        self.currentFootView  = nil;
    }
}

- (void)topSuspensionView:(UIScrollView*)view index:(NSInteger)index{
    if (view &&
        [view isKindOfClass:[UIScrollView class]]) {
        self.currentScroll = view;
        NSString *key = [NSString stringWithFormat:@"%ld",(long)index];
        if (!self.sonChildScrollerViewDic[key]) {
            [view pageAddObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        }else{
            if (self.sonChildScrollerViewDic[key] != view) {
                UIView *tempView = self.sonChildScrollerViewDic[key];
                [tempView paegRemoveObserver:self forKeyPath:@"contentOffset" context:nil];
                [view paegRemoveObserver:self forKeyPath:@"contentOffset" context:nil];
                [view pageAddObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
            }
        }
        [self.sonChildScrollerViewDic setObject:view forKey:key];
        if (self.scrolToBottom)  [view setContentOffset:CGPointMake(view.contentOffset.x,0) animated:NO];
        if (!self.sonCanScroll && !self.scrolToBottom) [view setContentOffset:CGPointZero animated:NO];
    }
}

/// 底部左滑滚动
- (void)pageWithScrollView:(UIScrollView*)scrollView left:(BOOL)left{
    int offset = (int)scrollView.contentOffset.x%(int)self.upSc.frame.size.width;
    NSInteger index = floor(scrollView.contentOffset.x/self.upSc.frame.size.width);
    if (self.currentFootView) {
        int x = 0;
        if (left) {
            if (scrollView.contentOffset.x > (self.upSc.frame.size.width * footerViewIndex)) {
                x -= offset;
            }else{
                x = (int)self.upSc.frame.size.width - offset;
            }
        }else{
            if (scrollView.contentOffset.x > (self.upSc.frame.size.width * footerViewIndex)) {
               x -= offset;
            }else{
               x = (int)self.upSc.frame.size.width - offset;
            }
        }
        if (offset == 0 && [self.sonChildFooterViewDic objectForKey:@(index)])
            x = self.footViewOrginX;
        if (!self.param.wFixFirst)
            [self.currentFootView page_x: x];
    }
}

/// 选中按钮
- (void)selectBtnWithIndex:(NSInteger)index{
    if (!self.currentFootView) return;
    if (!self.param.wFixFirst) [self.currentFootView page_x:self.footViewOrginX];
}

/// 监听子控制器中的滚动视图
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if (![self canTopSuspension]) return;
        if (![self currentNotSuspennsion]) return;
        if (hadWillDisappeal) return;
        if (self.currentScroll!=object) self.currentScroll = object;
        CGPoint newH = [[change objectForKey:@"new"] CGPointValue];
        CGPoint newOld = [[change objectForKey:@"old"] CGPointValue];
        if (newH.y == newOld.y)  return;
        if (self.param.wBounces) self.scrolToBottom = NO;
        if (!self.sonCanScroll && !self.scrolToBottom) {
            self.currentScroll.contentOffset = CGPointZero;
            self.downSc.showsVerticalScrollIndicator = NO;
            self.currentScroll.showsVerticalScrollIndicator = NO;
        }else{
            self.downSc.showsVerticalScrollIndicator = NO;
            self.currentScroll.showsVerticalScrollIndicator = NO;
        }
        [self changeMenuFrame];
        if ((int)newH.y <= 0) {
            self.canScroll = YES;
            if (self.param.wBounces) {
                self.currentScroll.contentOffset = CGPointZero;
            }
        }
    }
}

- (void)updateMenuData{
    [self removeKVO];
    footerViewIndex = -1;
    [self.upSc removeFromSuperview];
    for (UIView *view in self.upSc.dataView.subviews) {
        [view removeFromSuperview];
    }
    for (UIViewController *VC in self.childViewControllers) {
        [VC willMoveToParentViewController:nil];
        [VC.view removeFromSuperview];
        [VC removeFromParentViewController];
    }
    [self.sonChildScrollerViewDic removeAllObjects];
    [self.sonChildFooterViewDic removeAllObjects];
    self.sonChildScrollerViewDic = [NSMutableDictionary new];
    self.sonChildFooterViewDic = [NSMutableDictionary new];
    [self UI];
}

- (void)selectMenuWithIndex:(NSInteger)index{
    [self.upSc.btnArr enumerateObjectsUsingBlock:^(WMZPageNaviBtn*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == index) {
            [obj sendActionsForControlEvents:UIControlEventTouchUpInside];
            *stop = YES;
            return;
        }
    }];
}

- (void)updatePageController{
    [self removeKVO];
    [self.upSc removeFromSuperview];
    [self.downSc removeFromSuperview];
    self.downSc = nil;
    [self.sonChildScrollerViewDic removeAllObjects];
    [self.sonChildFooterViewDic removeAllObjects];
    self.sonChildScrollerViewDic = [NSMutableDictionary new];
    self.sonChildFooterViewDic = [NSMutableDictionary new];
    footerViewIndex = -1;
    for (UIView *view in self.upSc.dataView.subviews) {
        [view removeFromSuperview];
    }
    for (UIViewController *VC in self.childViewControllers) {
        [VC willMoveToParentViewController:nil];
        [VC.view removeFromSuperview];
        [VC removeFromParentViewController];
    }
    [self setParam];
    [self UI];
}

- (void)updateHeadView{
    [self setUpHead];
}

- (void)updateTitle{
    [self.upSc.mainView updateUI];
}

- (void)downScrollViewSetOffset:(CGPoint)point animated:(BOOL)animat;{
    if (CGPointEqualToPoint(point, CGPointZero)) {
        /// 顶点
        int topOffset = self.downSc.contentSize.height - self.downSc.frame.size.height;
        point = CGPointMake(self.downSc.contentOffset.x, topOffset);
        self.scrolTotop = YES;
    }else if(point.y == CGFLOAT_MIN){
        self.canScroll = YES;
    }
    [self.downSc setContentOffset:point animated:animat];
}

- (void)showData{
    [self setParam];
    [self UI];
}

- (BOOL)addMenuTitleWithObjectArr:(NSArray<WMZPageTitleDataModel*>*)insertArr{
    __block BOOL success = YES;
    [insertArr enumerateObjectsUsingBlock:^(WMZPageTitleDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL result = [self addMenuTitleWithObject:obj];
        if (!result) {
            success = NO;
        }
    }];
    return success;
}

- (BOOL)deleteMenuTitleIndexArr:(NSArray*)deleteArr{
    __block BOOL success = YES;
    [deleteArr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL result =  [self deleteMenuTitleIndex:obj];
         if (!result) {
             success = NO;
         }
    }];
    return success;
}

- (BOOL)addMenuTitleWithObject:(WMZPageTitleDataModel*)insertObject{
    if (!insertObject) return NO;
    //插入的位置
    NSInteger index = NSNotFound;
    index = MIN(MAX(insertObject.index, 0), self.param.wTitleArr.count);
    if (index == NSNotFound || index < 0) return NO;
    id insertTitle = insertObject.titleInfo?:(insertObject.title);
    UIViewController* insertController = insertObject.controller;
    if (!insertTitle){NSLog(@"输入插入的标题"); return NO;}
    if (!insertController){NSLog(@"输入插入的控制器"); return NO;}
    NSMutableArray *titleMarr = [NSMutableArray arrayWithArray:self.param.wTitleArr];
    NSMutableArray *controllerArr = [NSMutableArray arrayWithArray:self.param.wControllers];
    BOOL last = (index == self.param.wTitleArr.count);
    
    last?[titleMarr addObject:insertTitle]:[titleMarr insertObject:insertTitle atIndex:index];
    self.param.wTitleArr = [NSArray arrayWithArray:titleMarr];
    last?[controllerArr addObject:insertController]:[controllerArr insertObject:insertController atIndex:index];
    self.param.wControllers = [NSArray arrayWithArray:controllerArr];
    
    WMZPageNaviBtn *btn = [WMZPageNaviBtn buttonWithType:UIButtonTypeCustom];
    WMZPageNaviBtn *temp = nil;
    if (index > 0) {
        temp = [self.upSc.btnArr objectAtIndex:MAX(0, index - 1)];
    }
    [self.upSc.mainView setPropertiesWithBtn:btn withIndex:index withTemp:temp];
    for (int i = 0; i<self.upSc.dataView.subviews.count; i++) {
        UIView *view = self.upSc.dataView.subviews[i];
        CGFloat x = index*self.upSc.dataView.frame.size.width;
        if (view.frame.origin.x>=x) {
            [view page_x:view.frame.origin.x + self.upSc.dataView.frame.size.width];
        }
    }
    WMZPageNaviBtn *currentBtn = nil;
    for (int i = 0 ; i<self.upSc.btnArr.count; i++) {
        WMZPageNaviBtn *btn = self.upSc.btnArr[i];
        if (i>=index) {
            [btn page_x:currentBtn?CGRectGetMaxX(currentBtn.frame):0];
        }
        currentBtn = btn;
        btn.tag = i;
    }
    
    NSMutableDictionary *mdic = [NSMutableDictionary new];
    [self.cache enumerateKeysAndObjectsUsingBlock:^(NSNumber*  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSInteger keyNum = key.integerValue;
        if (keyNum >= index) {
            NSInteger saveKey = MIN(keyNum + 1, self.param.wTitleArr.count - 1);
            [mdic setObject:obj forKey:@(saveKey)];
        }else{
            [mdic setObject:obj forKey:key];
        }
    }];
    self.upSc.dataView.totalCount = self.param.wTitleArr.count;
    self.cache = [NSMutableDictionary dictionaryWithDictionary:mdic];
    self.upSc.dataView.contentSize = CGSizeMake(self.param.wTitleArr.count*PageVCWidth,0);
    if (self.upSc.currentTitleIndex >= index) {
        self.upSc.currentTitleIndex += 1;
        self.upSc.dataView.contentOffset = CGPointMake(self.upSc.currentTitleIndex * self.upSc.dataView.frame.size.width, 0);
    }
    if ([self.cache objectForKey:@(self.upSc.currentTitleIndex)]) {
        self.upSc.currentVC = [self.cache objectForKey:@(self.upSc.currentTitleIndex)];
    }
    [self.upSc.mainView resetMainViewContenSize:self.upSc.btnArr.lastObject];
    [self.upSc.mainView scrollToIndex:self.upSc.currentTitleIndex animal:NO];
    return YES;
}

- (BOOL)deleteMenuTitleIndex:(id)deleteObject{
    if (!deleteObject) return NO;
    NSInteger index = NSNotFound;
    if ([deleteObject isKindOfClass:[NSNumber class]]) {
        NSInteger currentIndex = [deleteObject integerValue];
        if (currentIndex < self.param.wTitleArr.count) {
            index = currentIndex;
        }
    }else{
        index = [self.param.wTitleArr indexOfObject:deleteObject];
    }
    
    if (index == NSNotFound || index < 0) return NO;
    if (self.upSc.mainView.subviews.count>index) {
        UIView *deleteView = self.upSc.mainView.subviews[index];
        [deleteView removeFromSuperview];
        deleteView = nil;
    }
    NSMutableArray *titleMarr = [NSMutableArray arrayWithArray:self.param.wTitleArr];
    if (titleMarr.count>index) {
        [titleMarr removeObjectAtIndex:index];
        self.param.wTitleArr = [NSArray arrayWithArray:titleMarr];
    }
    if (self.upSc.btnArr&&self.upSc.btnArr.count>index) {
        [self.upSc.btnArr removeObjectAtIndex:index];
    }
    NSMutableArray *controllerArr = [NSMutableArray arrayWithArray:self.param.wControllers];
    if (controllerArr.count>index) {
        [controllerArr removeObjectAtIndex:index];
        self.param.wControllers = [NSArray arrayWithArray:controllerArr];
    }
    
    if ([self.cache objectForKey:@(index)]) {
        if (self.upSc.dataView.subviews.count>index) {
            UIView *deleteView = self.upSc.dataView.subviews[index];
            [deleteView removeFromSuperview];
            [deleteView willMoveToSuperview:nil];
            deleteView = nil;
        }
        UIViewController *indexVC = [self.cache objectForKey:@(index)];
        if ([indexVC isKindOfClass:UIViewController.class]) {
            [indexVC willMoveToParentViewController:nil];
            [indexVC.view removeFromSuperview];
            [indexVC removeFromParentViewController];
            indexVC.view = nil;
        }else if([indexVC isKindOfClass:UIView.class]){
            UIView *tempView = (UIView*)indexVC;
            [tempView removeFromSuperview];
        }
        indexVC = nil;
        [self.cache removeObjectForKey:@(index)];
        UIView *obj = [self.sonChildScrollerViewDic objectForKey:@(index)];
        [obj paegRemoveObserver:self forKeyPath:@"contentOffset" context:nil];
        [self.sonChildScrollerViewDic removeObjectForKey:@(index)];
    }
    
    for (int i = 0; i<self.upSc.dataView.subviews.count; i++) {
        UIView *view = self.upSc.dataView.subviews[i];
        CGFloat x = index*self.upSc.dataView.frame.size.width;
        if (view.frame.origin.x>x) {
            [view page_x:view.frame.origin.x - self.upSc.dataView.frame.size.width];
        }
    }
    WMZPageNaviBtn *temp = nil;
    for (int i = 0 ; i<self.upSc.btnArr.count; i++) {
        WMZPageNaviBtn *btn = self.upSc.btnArr[i];
        if (i>=index) {
            [btn page_x:temp?CGRectGetMaxX(temp.frame):0];
        }
        temp = btn;
    }
    self.upSc.dataView.totalCount = self.param.wTitleArr.count;
    [self.upSc.mainView resetMainViewContenSize:self.upSc.btnArr.lastObject];
    self.upSc.dataView.contentSize = CGSizeMake(self.param.wTitleArr.count*PageVCWidth,0);
    if (index == self.upSc.currentTitleIndex) {
        self.upSc.currentTitleIndex = NSNotFound;
        self.upSc.currentVC = nil;
        [self selectMenuWithIndex:MAX(0, MIN(index, self.param.wTitleArr.count - 1))];
    }else if(index < self.upSc.currentTitleIndex){
        self.upSc.currentTitleIndex = MAX(self.upSc.currentTitleIndex - 1, 0);
        NSMutableDictionary *mdic = [NSMutableDictionary new];
        [self.cache enumerateKeysAndObjectsUsingBlock:^(NSNumber*  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSInteger keyNum = key.integerValue;
            if (keyNum > index) {
                NSInteger saveKey = MAX(keyNum - 1, 0);
                [mdic setObject:obj forKey:@(saveKey)];
            }else{
                [mdic setObject:obj forKey:key];
            }
        }];
        self.cache = [NSMutableDictionary dictionaryWithDictionary:mdic];
        if ([self.cache objectForKey:@(self.upSc.currentTitleIndex)]) {
            self.upSc.currentVC = [self.cache objectForKey:@(self.upSc.currentTitleIndex)];
        }
        self.upSc.dataView.contentOffset = CGPointMake(self.upSc.currentTitleIndex * self.upSc.dataView.frame.size.width, 0);
    }
    [self.upSc.mainView scrollToIndex:self.upSc.currentTitleIndex animal:NO];
    return YES;
}

- (BOOL)exchangeMenuDataAtIndex:(NSInteger)index withMenuDataAtIndex:(NSInteger)replaceIndex{
    if (self.param.wTitleArr.count < index ||
        self.param.wTitleArr.count < replaceIndex) {
        NSLog(@"输入正确的index或replaceIndex");
        return NO;
    }
    NSMutableArray *titleMarr = [NSMutableArray arrayWithArray:self.param.wTitleArr];
    [titleMarr exchangeObjectAtIndex:index withObjectAtIndex:replaceIndex];
    self.param.wTitleArr = [NSArray arrayWithArray:titleMarr];
    
    if (self.upSc.btnArr &&
        self.upSc.btnArr.count > index &&
        self.upSc.btnArr.count > replaceIndex) {
        [self.upSc.btnArr exchangeObjectAtIndex:index withObjectAtIndex:replaceIndex];
    }
    NSMutableArray *controllerArr = [NSMutableArray arrayWithArray:self.param.wControllers];
    if (controllerArr.count > index &&
        controllerArr.count > replaceIndex) {
        [controllerArr exchangeObjectAtIndex:index withObjectAtIndex:replaceIndex];
        self.param.wControllers = [NSArray arrayWithArray:controllerArr];
    }
    if ([self.cache objectForKey:@(index)] || [self.cache objectForKey:@(replaceIndex)]) {
        UIViewController *indexVC = [self.cache objectForKey:@(index)];
        UIViewController *replaceVC = [self.cache objectForKey:@(replaceIndex)];
        if (replaceVC) {
            [self.cache removeObjectForKey:@(replaceIndex)];
            [self.cache setObject:replaceVC forKey:@(index)];
            [indexVC.view page_x:index * PageVCWidth];
        }
        if (indexVC) {
            [self.cache removeObjectForKey:@(index)];
            [self.cache setObject:indexVC forKey:@(replaceIndex)];
            [indexVC.view page_x:replaceIndex * PageVCWidth];
        }
        UIScrollView *indexScrollView = [self.sonChildScrollerViewDic objectForKey:@(index)];
        UIScrollView *replaceScrollView = [self.sonChildScrollerViewDic objectForKey:@(replaceIndex)];
        if (replaceScrollView) {
            [self.sonChildScrollerViewDic removeObjectForKey:@(replaceIndex)];
            [self.sonChildScrollerViewDic setObject:replaceScrollView forKey:@(index)];
        }
        if (indexScrollView) {
            [self.sonChildScrollerViewDic removeObjectForKey:@(index)];
            [self.sonChildScrollerViewDic setObject:indexScrollView forKey:@(replaceIndex)];
        }
        if (self.upSc.currentTitleIndex == index) {
            self.upSc.dataView.contentOffset = CGPointMake(replaceIndex * PageVCWidth, 0);
            self.upSc.currentTitleIndex = replaceIndex;
        }
        if ([self.cache objectForKey:@(self.upSc.currentTitleIndex)]) {
            self.upSc.currentVC = [self.cache objectForKey:@(self.upSc.currentTitleIndex)];
        }
    }
    WMZPageNaviBtn *temp = nil;
    for (int i = 0 ; i<self.upSc.btnArr.count; i++) {
        WMZPageNaviBtn *btn = self.upSc.btnArr[i];
        [btn page_x:temp?CGRectGetMaxX(temp.frame):0];
        temp = btn;
    }
    [self.upSc.mainView resetMainViewContenSize:self.upSc.btnArr.lastObject];
    [self.upSc.mainView scrollToIndex:self.upSc.currentTitleIndex animal:NO];
    return YES;
}

- (BOOL)canTopSuspension{
    if (!self.param.wTopSuspension
       ||self.param.wMenuPosition == PageMenuPositionBottom
        ||self.param.wMenuPosition == PageMenuPositionNavi) return NO;
    if (!self.param.wTitleArr.count) return NO;
    return YES;
}

/// 某个子控制不悬浮
- (BOOL)currentNotSuspennsion{
    if (self.param.wTitleArr.count > self.upSc.currentTitleIndex) {
        id data = self.param.wTitleArr[self.upSc.currentTitleIndex];
        if ([data isKindOfClass:[NSDictionary class]] &&
            data[WMZPageKeyCanTopSuspension] &&
            ![data[WMZPageKeyCanTopSuspension] boolValue]) return NO;
    }
    return YES;
}

- (NSMutableDictionary *)sonChildScrollerViewDic{
    if (!_sonChildScrollerViewDic) {
        _sonChildScrollerViewDic =  [NSMutableDictionary new];
    }
    return _sonChildScrollerViewDic;
}

- (NSMutableDictionary *)sonChildFooterViewDic{
    if (!_sonChildFooterViewDic) {
        _sonChildFooterViewDic = [NSMutableDictionary new];
    }
    return _sonChildFooterViewDic;
}

- (WMZPageScroller *)downSc{
    if (!_downSc) {
        _downSc = [[WMZPageScroller alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _downSc.sectionHeaderHeight = 0.01;
        _downSc.estimatedRowHeight = 100;
        _downSc.sectionFooterHeight = 0.01;
        if (@available(iOS 11.0, *)) {
            _downSc.estimatedSectionFooterHeight = 0.01;
            _downSc.estimatedSectionHeaderHeight = 0.01;
            _downSc.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _downSc;
}

- (CGFloat)footViewOrginY{
    if (!_footViewOrginY) {
        _footViewOrginY = CGRectGetMaxY(self.downSc.frame) - self.currentFootView.frame.size.height;
    }
    return _footViewOrginY;
}

- (CGSize)headSize{
    return _headSize.width && _headSize.height ?_headSize:({_headSize = self.headView.frame.size;});
}
    
- (CGFloat)headHeight{
    _headHeight = self.headView.frame.size.height;
    return _headHeight;
}

- (void)setCurrentScroll:(UIScrollView *)currentScroll{
    _currentScroll = currentScroll;
    self.downSc.currentScroll = currentScroll;
}

- (void)setParam:(WMZPageParam *)param{
    _param = param;
    if (self.param.wMenuPosition == PageMenuPositionNavi||
        self.param.wMenuPosition == PageMenuPositionBottom) {
        [self showData];
    }else{
        if (self.param.wLazyLoading) {
            [self performSelector:@selector(showData) withObject:nil afterDelay:CGFLOAT_MIN];
        }else{
            [self showData];
        }
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [self removeKVO];
    [self.cache removeAllObjects];
    [self.sonChildScrollerViewDic removeAllObjects];
}

- (void)removeKVO{
    [self.sonChildScrollerViewDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [obj paegRemoveObserver:self forKeyPath:@"contentOffset" context:nil];
    }];
}

- (void)dealloc{
    [self removeKVO];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
