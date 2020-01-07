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
}
//当前子控制器中的滚动视图
@property(nonatomic,strong)UIScrollView *currentScroll;
//当前子控制器中需要固定的底部视图
@property(nonatomic,strong)UIView *currentFootView;
//头部视图
@property(nonatomic,strong)UIView *headView;
//头部视图菜单栏底部的占位视图(如有需要)
@property(nonatomic,strong)UIView *head_MenuView;
//视图消失时候的透明度 有透明度变化的时候
@property(nonatomic,assign)CGFloat lastAlpah;
//底部tableView是否可以滚动
@property (nonatomic, assign) BOOL canScroll;
//onTableView是否可以滚动
@property (nonatomic, assign) BOOL sonCanScroll;
//到达顶部
@property (nonatomic, assign) BOOL scrolTotop;
//到达底部
@property (nonatomic, assign) BOOL scrolToBottom;
@end
@implementation WMZPageController

- (void)updatePageController{
    [self.upSc removeFromSuperview];
    [self.downSc removeFromSuperview];
    [self.sonChildScrollerViewDic removeAllObjects];
    [self.sonChildFooterViewDic removeAllObjects];
    [self.rectArr removeAllObjects];
    footerViewIndex = -1;
    if (self.headView) {
        [self.headView removeFromSuperview];
        self.headView = nil;
    }
    if (self.head_MenuView) {
        [self.head_MenuView removeFromSuperview];
        self.head_MenuView = nil;
    }
    for (UIViewController *VC in self.childViewControllers) {
        [VC willMoveToParentViewController:nil];
        [VC.view removeFromSuperview];
        [VC removeFromParentViewController];
    }
    [self setParam];
    [self UI];
}

- (void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setParam];
        [self UI];
    });
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.naviBarBackGround&&self.param.wNaviAlpha) {
        self.lastAlpah = self.naviBarBackGround.alpha;
    }
     hadWillDisappeal = YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.naviBarBackGround&&self.param.wNaviAlpha) {
        self.lastAlpah = self.naviBarBackGround.alpha;
        self.naviBarBackGround.alpha = 1;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    hadWillDisappeal = NO;
    if (self.navigationController&&self.param.wNaviAlpha) {
        if (self.naviBarBackGround&&self.lastAlpah!=0){
             self.naviBarBackGround.alpha = self.lastAlpah;
            return;
        }
        if (self.param.wNaviAlphaAll) {
            self.naviBarBackGround = self.navigationController.navigationBar;
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
                   if ([[UIDevice currentDevice].systemVersion intValue]>=12&&[[UIDevice currentDevice].systemVersion intValue]<13){
                       if ([NSStringFromClass([view class]) isEqualToString:@"UIVisualEffectView"]) {
                           self.naviBarBackGround = view;
                           [self.naviBarBackGround setAlpha:0];
                       }
                   }else{
                       if ([NSStringFromClass([view class]) isEqualToString:@"_UIBarBackground"]||[NSStringFromClass([view class]) isEqualToString:@"_UINavigationBarBackground"]) {
                           self.naviBarBackGround = view;
                           [self.naviBarBackGround setAlpha:0];
                       }
                   }
                   if ([NSStringFromClass([view class]) isEqualToString:@"UIImageView"]) {
                       view.hidden = YES;
                   }
               }
           }
        }
    }
}

- (void)setParam{
    if (self.param.wInsertHeadAndMenuBg) {
        self.head_MenuView = [UIView new];
        self.param.wInsertHeadAndMenuBg(self.head_MenuView);
    }
    if (self.param.wMenuAnimal == PageTitleMenuAiQY) {
        if (!self.param.wMenuIndicatorWidth) {
            self.param.wMenuIndicatorWidth = 20;
        }
    }
    
    if (self.param.wMenuAnimal == PageTitleMenuNone||
        self.param.wMenuAnimal == PageTitleMenuCircle||
        self.param.wMenuAnimal == PageTitleMenuPDD) {
        self.param.wMenuAnimalTitleBig = NO;
        self.param.wMenuAnimalTitleGradient = NO;
    }
    
    
    if (self.param.wMenuAnimal == PageTitleMenuYouKu) {
        self.param.wMenuIndicatorWidth = 6;
        self.param.wMenuIndicatorHeight = 3;
    }
    if (self.param.wMenuAnimal == PageTitleMenuCircle) {
        if (CGColorEqualToColor(self.param.wMenuIndicatorColor.CGColor, PageColor(0xE5193E).CGColor)) {
            self.param.wMenuIndicatorColor = PageColor(0xe1f9fe);
        }
        if (CGColorEqualToColor(self.param.wMenuTitleSelectColor.CGColor, PageColor(0xE5193E).CGColor)) {
            self.param.wMenuTitleSelectColor = PageColor(0x00baf9);
        }
    }
    
    if (self.param.wMenuPosition == PageMenuPositionNavi) {
        if (CGColorEqualToColor(self.param.wMenuBgColor.CGColor, PageColor(0xffffff).CGColor)) {
            self.param.wMenuBgColor = [UIColor clearColor];
        }
    }
    
}


- (void)UI{

    self.cache = [NSCache new];
    self.cache.countLimit = 30;
    footerViewIndex = -1;
    CGFloat headY = 0;
    CGFloat tabbarHeight = 0;
    CGFloat statusBarHeight = 0;
    if (self.presentingViewController) {
        if (!self.navigationController) {
            statusBarHeight = PageVCStatusBarHeight;
        }
    } else if (self.tabBarController) {
        tabbarHeight = PageVCTabBarHeight;
    } else if (self.navigationController){
        headY = (!self.param.wFromNavi&&
                  self.param.wMenuPosition != PageMenuPositionNavi&&
                  self.param.wMenuPosition != PageMenuPositionBottom)?0:PageVCNavBarHeight;
    }
    if (self.parentViewController) {
        
        if ([self.parentViewController isKindOfClass:[UINavigationController class]]) {
            headY = (!self.param.wFromNavi&&
            self.param.wMenuPosition != PageMenuPositionNavi&&
            self.param.wMenuPosition != PageMenuPositionBottom)?0:PageVCNavBarHeight;
            if (self.parentViewController.tabBarController) {
                tabbarHeight = PageVCTabBarHeight;
            }
        }else if ([self.parentViewController isKindOfClass:[UITabBarController class]]) {
             tabbarHeight = PageVCTabBarHeight;
            if (self.parentViewController.navigationController) {
                headY = (!self.param.wFromNavi&&
                self.param.wMenuPosition != PageMenuPositionNavi&&
                self.param.wMenuPosition != PageMenuPositionBottom)?0:PageVCNavBarHeight;
            }else if(self.parentViewController.presentingViewController){
                statusBarHeight = PageVCStatusBarHeight;
            }
        }else if ([self.parentViewController isKindOfClass:[WMZPageController class]]) {
            headY = 0;
            tabbarHeight = 0;
            statusBarHeight = 0;
        }
    }
    
    
    //全屏
      if (self.navigationController) {
          for (UIGestureRecognizer *gestureRecognizer in self.downSc.gestureRecognizers) {
              [gestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
          }
      }
      if (@available(iOS 11.0, *)) {
          self.downSc.estimatedRowHeight = 0.01;
          self.downSc.estimatedSectionFooterHeight = 0.01;
          self.downSc.estimatedSectionHeaderHeight = 0.01;
          self.downSc.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
      }else{
           self.downSc.estimatedRowHeight = 0;
      }
      self.downSc.sectionHeaderHeight = 0.01;
      self.downSc.sectionFooterHeight = 0.01;
      self.downSc.delegate = self;
      self.downSc.bounces = self.param.wBounces;
      self.downSc.frame = CGRectMake(0, headY, self.view.frame.size.width, self.view.frame.size.height-headY-tabbarHeight);
      [self.view addSubview:self.downSc];
    
    //头部视图
    if(self.param.wMenuHeadView&&
       self.param.wMenuPosition != PageMenuPositionNavi&&
       self.param.wMenuPosition != PageMenuPositionBottom) {
        self.headView = self.param.wMenuHeadView();
        self.headView.frame = CGRectMake(self.headView.frame.origin.x,  0, self.headView.frame.size.width, self.headView.frame.size.height);
        self.downSc.tableHeaderView = self.headView;
    }else{
        self.downSc.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake( 0, 0,self.view.frame.size.width, 0.01)];
    }

    
   //滚动和菜单视图
    self.upSc = [[WMZPageLoopView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) param:self.param];
    self.upSc.loopDelegate = self;
    self.downSc.tableFooterView = self.upSc;
    
    if (self.navigationController) {
        
        for (UIGestureRecognizer *gestureRecognizer in self.upSc.gestureRecognizers) {
            [gestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
        }
    }
    //底部
    CGFloat sonChildVCY = 0;
    CGFloat sonChildVCHeight = 0;
    CGFloat titleMenuhHeight = self.upSc.mainView.frame.size.height;
    if (self.param.wMenuPosition == PageMenuPositionNavi) {
        sonChildVCY = 0;
        sonChildVCHeight = self.downSc.frame.size.height;
    }else if (self.param.wMenuPosition == PageMenuPositionBottom) {
        sonChildVCY = 0;
        sonChildVCHeight = self.downSc.frame.size.height - titleMenuhHeight;
    }else{
        sonChildVCY = 0;
        sonChildVCHeight = self.downSc.frame.size.height - titleMenuhHeight;
        
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
        [self.upSc.dataView page_y:CGRectGetMaxY(self.upSc.mainView.frame)];
        [self.upSc.dataView page_height:sonChildVCHeight];
        [self.upSc page_height:CGRectGetMaxY(self.upSc.dataView.frame)];
    }
    for (int i = 0; i<self.param.wTitleArr.count; i++) {
        CGFloat height = [self canTopSuspension]?self.upSc.dataView.frame.size.height :(sonChildVCHeight-self.headView.frame.size.height);
        if ([self canTopSuspension]) {
            if (!self.parentViewController) {
                height -=PageVCStatusBarHeight;
            }else{
                if (!self.param.wFromNavi) {
                    height -=PageVCNavBarHeight;
                }
            }
        }
        CGRect frame = CGRectMake(i * self.downSc.frame.size.width,
                                  [self canTopSuspension]?0:sonChildVCY,
                                  self.downSc.frame.size.width,
                                  height);
        [self.rectArr addObject:[NSValue valueWithCGRect:frame]];
    }
    self.param.titleHeight = self.upSc.mainView.frame.size.height;
    self.downSc.menuTitleHeight = self.param.titleHeight;
    self.downSc.canScroll = [self canTopSuspension];
    self.downSc.scrollEnabled = [self canTopSuspension];
    self.downSc.wFromNavi = self.param.wFromNavi;
    //全景
    if (self.head_MenuView) {
        self.head_MenuView.frame = CGRectMake(0, self.headView?CGRectGetMinX(self.headView.frame):CGRectGetMinX(self.upSc.frame), self.upSc.frame.size.width, CGRectGetMaxY(self.upSc.frame)-self.upSc.dataView.frame.size.height);
        [self.downSc insertSubview:self.head_MenuView belowSubview:self.headView?self.headView:self.upSc];
        self.upSc.mainView.backgroundColor = [UIColor clearColor];
        for (WMZPageNaviBtn *btn in self.upSc.btnArr) {
            btn.backgroundColor = [UIColor clearColor];
        }
        if (self.headView) {
            self.headView.backgroundColor = [UIColor clearColor];
        }
    }
    if (self.param.wCustomMenuTitle) {
        self.param.wCustomMenuTitle(self.upSc.btnArr);
    }
    
    [self.upSc.btnArr enumerateObjectsUsingBlock:^(WMZPageNaviBtn*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == self.param.wMenuDefaultIndex) {
            self.upSc.first = YES;
            [obj sendActionsForControlEvents:UIControlEventTouchUpInside];
            *stop = YES;
        }
    }];
    self.canScroll = YES;
    self.scrolToBottom = YES;
    
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView!=self.downSc) return;
    if (![self canTopSuspension]) return;
    //偏移量
    float yOffset  = scrollView.contentOffset.y;
    //顶点
    int topOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    if (!self.parentViewController) {
        topOffset -=PageVCStatusBarHeight;
    }else{
        if (!self.param.wFromNavi) {
            topOffset -=PageVCNavBarHeight;
        }
    }
    if (yOffset<=0) {
        self.scrolToBottom = YES;
    }else{
        if (yOffset >= topOffset) {
            scrollView.contentOffset = CGPointMake(self.downSc.contentOffset.x, topOffset);
            self.scrolTotop = YES;
        }else{
            self.scrolTotop = NO;
        }
        self.scrolToBottom = NO;
    }
    if (self.scrolTotop) {
        self.sonCanScroll = YES;
        self.canScroll = NO;
    }else {
        if (!self.canScroll) {
            scrollView.contentOffset = CGPointMake(0, topOffset);
        }else {
             self.sonCanScroll = NO;
        }
    }
    CGFloat delta = scrollView.contentOffset.y/topOffset;
    if (delta>1) {
        delta = 1;
    }else if (delta < 0){
        delta = 0;
    }
    if (self.param.wNaviAlpha) {
        if (self.navigationController&&self.naviBarBackGround) {
            self.naviBarBackGround.alpha =  delta;
        }
        if (self.headView) {
            if (delta == 1) {
                self.headView.alpha = 0;
            }else{
                self.headView.alpha = 1;
            }
        }
    }
    if (self.param.wEventChildVCDidSroll) {
        self.param.wEventChildVCDidSroll(self,self.downSc.contentOffset, self.downSc.contentOffset, self.downSc);
    }
    //防止第一次加载不成功
    if (self.currentFootView&&
        self.currentFootView.frame.origin.y!=
        CGRectGetMaxY(self.downSc.frame)-self.currentFootView.frame.size.height) {
        [self.currentFootView page_y:CGRectGetMaxY(self.downSc.frame)-self.currentFootView.frame.size.height];
    }
}

//设置悬浮
- (void)setUpSuspension:(UIViewController*)newVC index:(NSInteger)index end:(BOOL)end{
    if (![self canTopSuspension]) return;
    if ([newVC conformsToProtocol:@protocol(WMZPageProtocol)]) {
        UIScrollView *view = nil;
       if ([newVC respondsToSelector:@selector(getMyTableView)]) {
           UIScrollView *tmpView = [newVC performSelector:@selector(getMyTableView)];
           if (tmpView&&[tmpView isKindOfClass:[UIScrollView class]]) {
               view = tmpView;
           }
       }else if([newVC respondsToSelector:@selector(getMyScrollView)]){
           UIScrollView *tmpView = [newVC performSelector:@selector(getMyScrollView)];
           if (tmpView&&[tmpView isKindOfClass:[UIScrollView class]]) {
               view = tmpView;
           }
       }
        if (view) {
            self.currentScroll = view;
            [self.sonChildScrollerViewDic setObject:view forKey:@(index)];
            if (self.scrolToBottom) {
                view.contentOffset = CGPointMake(view.contentOffset.x,0);
            }
            [self.currentScroll pageAddObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        }
        
        if ([newVC respondsToSelector:@selector(fixFooterView)]) {
            UIView *tmpView = [newVC performSelector:@selector(fixFooterView)];
            [self.sonChildFooterViewDic setObject:view forKey:@(index)];
            self.currentFootView = tmpView;
            [self.view addSubview:self.currentFootView];
            self.currentFootView.hidden = NO;
            footerViewIndex = index;
            [self.currentFootView page_y:CGRectGetMaxY(self.downSc.frame)-self.currentFootView.frame.size.height];
        }else{
            if (self.currentFootView&&
                end) {
                self.currentFootView.hidden = YES;
            }
        }
    }else{
        self.currentScroll = nil;
        self.currentFootView  = nil;
    }
}

//底部左滑滚动
- (void)pageWithScrollView:(UIScrollView*)scrollView left:(BOOL)left{
    int offset = (int)scrollView.contentOffset.x%(int)self.upSc.frame.size.width;
    NSInteger index = floor(scrollView.contentOffset.x/self.upSc.frame.size.width);
    if (self.currentFootView) {
        int x = 0;
        CGFloat width = self.footViewSizeWidth;
        if (left) {
            if (scrollView.contentOffset.x>(self.upSc.frame.size.width*footerViewIndex)) {
                x = 0;
                width -= offset;
            }else{
                x = (int)self.upSc.frame.size.width - offset;
            }
        }else{
            if (scrollView.contentOffset.x>(self.upSc.frame.size.width*footerViewIndex)) {
               x = 0;
               width -= offset;
            }else{
               x = (int)self.upSc.frame.size.width - offset;
            }
        }
        if (offset == 0 && [self.sonChildFooterViewDic objectForKey:@(index)]) {
            x = self.footViewOrginX;
        }
        [self.currentFootView page_x: x];
        [self.currentFootView page_width:width];
    }
}


//选中按钮
- (void)selectBtnWithIndex:(NSInteger)index{
    if (self.currentFootView) {
        [self.currentFootView page_x:self.footViewOrginX];
    }
}

//监听子控制器中的滚动视图
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if (![self canTopSuspension]) return;
        if (self.currentScroll!=object) return;
        if (hadWillDisappeal) return;
        CGPoint newH = [[change objectForKey:@"new"] CGPointValue];
        CGPoint newOld = [[change objectForKey:@"old"] CGPointValue];
        if (newH.y==newOld.y)  return;
        if (!self.sonCanScroll&&!self.scrolToBottom) {
            self.currentScroll.contentOffset = CGPointZero;
            self.downSc.showsVerticalScrollIndicator = YES;
            self.currentScroll.showsVerticalScrollIndicator = NO;
        }else{
            self.downSc.showsVerticalScrollIndicator = NO;
            self.currentScroll.showsVerticalScrollIndicator = YES;
        }

        if ((int)newH.y<=0) {
            self.canScroll = YES;
        }
    }
}

- (BOOL)canTopSuspension{
    if (!self.param.wTopSuspension
       ||self.param.wMenuPosition == PageMenuPositionBottom
       ||self.param.wMenuPosition == PageMenuPositionNavi){
          return NO;
    }
    return YES;
}
- (NSMutableArray *)rectArr{
    if (!_rectArr) {
        _rectArr = [NSMutableArray new];
    }
    return _rectArr;
}

- (NSMutableDictionary *)sonChildScrollerViewDic{
    if (!_sonChildScrollerViewDic) {
        _sonChildScrollerViewDic = [NSMutableDictionary new];
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
        _downSc = [[WMZPageScroller alloc]initWithFrame:CGRectMake(0, 0, PageVCWidth, PageVCHeight) style:UITableViewStyleGrouped];
    }
    return _downSc;
}


- (CGFloat)footViewSizeWidth{
    if (!_footViewSizeWidth) {
        _footViewSizeWidth = self.upSc.frame.size.width;
    }
    return _footViewSizeWidth;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [self.cache removeAllObjects];
    [self.sonChildScrollerViewDic removeAllObjects];
}

- (void)dealloc{
    [self.sonChildScrollerViewDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [obj removeAllObserverdKeyPath:self withKey:@"contentOffset"];
    }];
}
@end
