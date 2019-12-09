//
//  WMZPageController.m
//  WMZPageController
//
//  Created by wmz on 2019/9/22.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZPageController.h"
#import "WMZPageScroller.h"
#import "WMZPageLoopView.h"

@interface WMZPageController()<UIScrollViewDelegate,WMZPageLoopDelegate,UITraitEnvironment>
{
    CGFloat lastContentOffset;
    WMZPageNaviBtn *_btnLeft ;
    WMZPageNaviBtn *_btnRight;
    CGRect normalUpScRect;
    
}
//frame数组
@property(nonatomic,strong)NSMutableArray *rectArr;
//头部标题滚动视图
@property(nonatomic,strong)WMZPageLoopView *upSc;
//底部全屏滚动视图
@property(nonatomic,strong)WMZPageScroller *downSc;
//当前视图
@property(nonatomic,assign)NSInteger currentPageIndex;
//可能的下一个视图
@property(nonatomic,assign)NSInteger nextPageIndex;
//上一个视图
@property(nonatomic,assign)NSInteger lastPageIndex;
//子控制器中可以滚动的视图
@property(nonatomic,strong)NSMutableDictionary *sonChildScrollerViewDic;
//是否已经处理了生命周期
@property(nonatomic,assign)BOOL hasDealAppearance;
//是否已经运行了完整的生命周期
@property(nonatomic,assign)BOOL hasEndAppearance;
//是否往相反方向滑动
@property(nonatomic,assign)BOOL hasDifferenrDirection;
//当前显示VC
@property(nonatomic,strong)UIViewController *currentVC;
//缓存
@property(nonatomic,strong)NSCache *cache;
//头部视图
@property(nonatomic,strong)UIView *headView;
//当前子控制器中的滚动视图
@property(nonatomic,strong)UIScrollView *currentScroll;
//返回按钮
@property(nonatomic,strong)UIButton *backBtn;
@end
@implementation WMZPageController

- (void)updatePageController{
    [self setParam];
    
    [self.cache removeAllObjects];
    [self.upSc removeFromSuperview];
    [self.downSc removeFromSuperview];
    [self.sonChildScrollerViewDic removeAllObjects];
    [self.rectArr removeAllObjects];
    self.hasEndAppearance = NO;
    self.hasDealAppearance = NO;
    self.currentVC = nil;
    self.headView = nil;
    self.currentScroll = nil;
    self.hasDifferenrDirection = NO;
    self.currentPageIndex = 0;
    self.lastPageIndex = 0;
    self.nextPageIndex = 0;
    for (UIViewController *VC in self.childViewControllers) {
        [VC willMoveToParentViewController:nil];
        [VC.view removeFromSuperview];
        [VC removeFromParentViewController];
    }
    
    [self UI];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setParam];
    [self UI];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.navigationController&&self.param.wNaviAlpha) {
        if (self.navigationController.navigationBar.alpha != 1) {
            self.navigationController.navigationBar.alpha = 1;
        }
    }
    if (self.backBtn) {
        [self.backBtn removeFromSuperview];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.navigationController&&self.navigationItem.hidesBackButton) {
         self.navigationItem.hidesBackButton = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)setParam{
    self.view.backgroundColor = [UIColor whiteColor];
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
    self.cache.countLimit = 15;

    //全屏
    self.downSc = [[WMZPageScroller alloc]initWithFrame:self.view.bounds];
    [self.view sendSubviewToBack:self.downSc];
    if (self.navigationController) {
        for (UIGestureRecognizer *gestureRecognizer in self.downSc.gestureRecognizers) {
            [gestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
        }
    }
    self.downSc.delegate = self;
    [self.view addSubview:self.downSc];
    
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
        }
    }
    
    //头部视图
    if(self.param.wMenuHeadView&&
       self.param.wMenuPosition != PageMenuPositionNavi&&
       self.param.wMenuPosition != PageMenuPositionBottom) {
        self.headView = self.param.wMenuHeadView();
        CGRect rect = self.headView.frame;
        self.headView.frame = CGRectMake(self.headView.frame.origin.x,  self.headView.frame.origin.y + (self.param.wFromNavi?headY:0), self.headView.frame.size.width, self.headView.frame.size.height);
        headY += CGRectGetMaxY(rect);
        [self.view addSubview:self.headView];
        if (self.param.wNaviAlpha&&!self.param.wFromNavi) {
            self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.backBtn.frame = CGRectMake(15, 52, 20, 20);
            [self.backBtn addTarget:self action:@selector(backction) forControlEvents:UIControlEventTouchUpInside];
            [self.backBtn setImage:[UIImage pageBundleImage:@"page_back"] forState:UIControlStateNormal];
            [PageWindow addSubview:self.backBtn];
            self.navigationItem.hidesBackButton = YES;
        }
    }
    
    //标题菜单
    NSDictionary *dic = @{
        @(PageMenuPositionLeft):[NSValue valueWithCGRect:CGRectMake(0, self.headView?CGRectGetMaxY(self.headView.frame):headY , self.param.wMenuWidth,0)],
        @(PageMenuPositionRight):[NSValue valueWithCGRect:CGRectMake(PageVCWidth-self.param.wMenuWidth, self.headView?CGRectGetMaxY(self.headView.frame):headY  , self.param.wMenuWidth,0)],
        @(PageMenuPositionCenter):[NSValue valueWithCGRect:CGRectMake((PageVCWidth-self.param.wMenuWidth)/2, self.headView?CGRectGetMaxY(self.headView.frame):headY  , self.param.wMenuWidth,0)],
        @(PageMenuPositionNavi):[NSValue valueWithCGRect:CGRectMake((PageVCWidth-self.param.wMenuWidth)/2, 0 , self.param.wMenuWidth,0)],
        @(PageMenuPositionBottom):[NSValue valueWithCGRect:CGRectMake(0, PageVCHeight, self.param.wMenuWidth,0)],
    };
    
    self.upSc = [[WMZPageLoopView alloc]initWithFrame:[dic[@(self.param.wMenuPosition)] CGRectValue] param:self.param];
    self.upSc.loopDelegate = self;
    
    //刘海屏适配
    if (statusBarHeight&&!self.headView) {
        CGRect rect = self.upSc.frame;
        rect.size.height += statusBarHeight;
        self.upSc.frame = rect;
        CGRect mainRect = self.upSc.mainView.frame;
        mainRect.origin.y += statusBarHeight;
        self.upSc.mainView.frame = mainRect;
    }
    if (self.navigationController) {
        for (UIGestureRecognizer *gestureRecognizer in self.upSc.gestureRecognizers) {
            [gestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
        }
    }
    
    
    if (self.param.wMenuPosition == PageMenuPositionNavi && self.navigationController) {
        self.navigationItem.titleView = self.upSc;
    }else{
        [self.view addSubview:self.upSc];
    }
    normalUpScRect = self.upSc.frame;

    //底部
    CGFloat sonChildVCY = 0;
    CGFloat sonChildVCHeight = 0;
    if (self.param.wMenuPosition == PageMenuPositionNavi) {
        sonChildVCY = headY;
        sonChildVCHeight = self.downSc.frame.size.height-sonChildVCY-tabbarHeight;
    }else if (self.param.wMenuPosition == PageMenuPositionBottom) {
        sonChildVCY = headY;
        sonChildVCHeight = self.downSc.frame.size.height-sonChildVCY - tabbarHeight - self.upSc.frame.size.height;
    }else{
        sonChildVCY = headY + self.upSc.frame.size.height;
        sonChildVCHeight = self.downSc.frame.size.height-sonChildVCY - tabbarHeight;
        
    }
    for (int i = 0; i<self.param.wTitleArr.count; i++) {
        CGRect frame = CGRectMake(i * self.downSc.frame.size.width,
                                  [self canTopSuspension]?0:sonChildVCY,
                                  self.downSc.frame.size.width,
                                  [self canTopSuspension]?(self.downSc.frame.size.height - tabbarHeight):sonChildVCHeight);
        [self.rectArr addObject:[NSValue valueWithCGRect:frame]];
    }
    self.downSc.scrollEnabled = self.param.wScrollCanTransfer;
    self.downSc.contentSize = CGSizeMake(self.param.wTitleArr.count*PageVCWidth, 0);
    
    self.param.titleHeight = self.upSc.frame.size.height;
}

- (void)backction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)selectWithBtn:(UIButton *)btn first:(BOOL)first{
    NSInteger index = btn.tag;
    if (first) {
         self.lastPageIndex = self.currentPageIndex;
         self.nextPageIndex = index;
         self.currentPageIndex = index;
         UIViewController *newVC = [self getVCWithIndex:index];
         [newVC beginAppearanceTransition:YES animated:YES];
         [self addChildVC:index VC:newVC];
         [self.downSc setContentOffset:CGPointMake(index*PageVCWidth, 0) animated:YES];
         [newVC endAppearanceTransition];
         [self setUpSuspension:newVC index:index];
    }else{
        [self beginAppearanceTransitionWithIndex:index withOldIndex:self.currentPageIndex];
        [self.downSc setContentOffset:CGPointMake(index*PageVCWidth, 0) animated:YES];
        self.nextPageIndex = index;
        self.currentPageIndex = index;
        self.lastPageIndex = self.currentPageIndex;
        [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.lastPageIndex isFlag:NO];
    }
}

#pragma -mark- scrollerDeleagte
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView != self.downSc) return;
    lastContentOffset = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView != self.downSc) return;
    if (![scrollView isDecelerating]&&![scrollView isDragging]) return;
    
    if (scrollView.contentOffset.x>0 &&scrollView.contentOffset.x<=self.upSc.btnArr.count*PageVCWidth ) {
         [self lifeCycleManage:scrollView];
         [self animalAction:scrollView];
    }
    
    if (scrollView.contentOffset.y == 0) return;
    CGPoint contentOffset = scrollView.contentOffset;
    contentOffset.y = 0.0;
    scrollView.contentOffset = contentOffset;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView != self.downSc) return;
    if (!decelerate) {
        [self endAninamal];
        NSInteger newIndex = scrollView.contentOffset.x/PageVCWidth;
        self.currentPageIndex = newIndex;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView != self.downSc) return;
    [self endAninamal];
    NSInteger newIndex = scrollView.contentOffset.x/PageVCWidth;
    self.currentPageIndex = newIndex;
    if (!self.hasEndAppearance) {
        [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.lastPageIndex isFlag:NO];
    }
    self.hasEndAppearance = NO;
    [self.upSc scrollToIndex:newIndex];
}

//管理生命周期
- (void)lifeCycleManage:(UIScrollView*)scrollView{
    CGFloat diffX = scrollView.contentOffset.x - lastContentOffset;
    if (diffX < 0) {
        self.currentPageIndex = ceil(scrollView.contentOffset.x/PageVCWidth);
    }else{
        self.currentPageIndex = (scrollView.contentOffset.x/PageVCWidth);
    }
    if (diffX > 0) {
        if (self.hasDealAppearance&&self.nextPageIndex == self.currentPageIndex) {
            self.hasEndAppearance = YES;
            [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.currentPageIndex-1 isFlag:YES];
            [self endAninamal];
            return;
        }
        
        if (!self.hasDealAppearance || self.nextPageIndex != self.currentPageIndex + 1) {
            self.hasDealAppearance = YES;
            if (self.nextPageIndex == self.currentPageIndex - 1) {
               [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.currentPageIndex isFlag:NO];
                self.hasDifferenrDirection = YES;
            }
            self.nextPageIndex = self.currentPageIndex + 1;
            self.lastPageIndex = self.currentPageIndex ;
            [self beginAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.currentPageIndex];
        }
        
    }else if(diffX < 0){
        if (self.hasDealAppearance&&self.nextPageIndex == self.currentPageIndex) {
            self.hasEndAppearance = YES;
            [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.currentPageIndex+1 isFlag:YES];
            [self endAninamal];
            return;
        }
        
        if (!self.hasDealAppearance || self.nextPageIndex != self.currentPageIndex - 1) {
            self.hasDealAppearance = YES;
            if (self.nextPageIndex == self.currentPageIndex + 1) {
                [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.currentPageIndex isFlag:NO];
                self.hasDifferenrDirection = YES;
            }
            self.nextPageIndex = self.currentPageIndex - 1;
            self.lastPageIndex = self.currentPageIndex ;
            [self beginAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.currentPageIndex];
        }
    }
    
    
}

- (UIViewController*)getVCWithIndex:(NSInteger)index{
    if (index < 0|| index >= self.param.wControllers.count) {
        return nil;
    }
    
    if ([self.cache objectForKey:@(index)]) {
        return [self.cache objectForKey:@(index)];
    }
    
    return self.param.wControllers[index];
}


- (void)beginAppearanceTransitionWithIndex:(NSInteger)index withOldIndex:(NSInteger)old{
    UIViewController *newVC = [self getVCWithIndex:index];
    UIViewController *oldVC = [self getVCWithIndex:old];
    if (!newVC||!oldVC||(index==old)) return;
    [newVC beginAppearanceTransition:YES animated:YES];
    [self addChildVC:index VC:newVC];
    [oldVC beginAppearanceTransition:NO  animated:YES];
    self.currentVC = newVC;
    [self setUpSuspension:newVC index:index];
    
    if (self.param.wEventBeganTransferController) {
        self.param.wEventBeganTransferController(oldVC, newVC, old, index);
    }
}

- (void)addChildVC:(NSInteger)index VC:(UIViewController*)newVC{
    if (![self.childViewControllers containsObject:newVC]) {
        [self addChildViewController:newVC];
        newVC.view.frame = [self.rectArr[index] CGRectValue];
        [self.downSc addSubview:newVC.view];
        [newVC didMoveToParentViewController:self];
        [self.cache setObject:newVC forKey:@(index)];
    }
}

- (void)endAppearanceTransitionWithIndex:(NSInteger)index withOldIndex:(NSInteger)old  isFlag:(BOOL)flag{
    UIViewController *newVC = [self getVCWithIndex:index];
    UIViewController *oldVC = [self getVCWithIndex:old];
    if (!newVC||!oldVC||(index==old))   return;
    if (self.currentPageIndex == self.nextPageIndex) {

        [oldVC willMoveToParentViewController:nil];
        [oldVC.view removeFromSuperview];
        [oldVC removeFromParentViewController];
        
        [newVC endAppearanceTransition];
        [oldVC endAppearanceTransition];
        
        if (flag&&self.hasDifferenrDirection) {
            [newVC endAppearanceTransition];
            [oldVC endAppearanceTransition];
            self.hasDifferenrDirection = NO;
        }
        
        if (self.param.wEventEndTransferController) {
            self.param.wEventEndTransferController(oldVC, newVC, old, index);
        }
        
        self.currentVC = newVC;
        self.currentPageIndex = index;

    }else{
        [newVC willMoveToParentViewController:nil];
        [newVC.view removeFromSuperview];
        [newVC removeFromParentViewController];
        
        [oldVC beginAppearanceTransition:YES animated:YES];
        [oldVC endAppearanceTransition];
        [newVC beginAppearanceTransition:NO animated:YES];
        [newVC endAppearanceTransition];
        
        if (self.param.wEventEndTransferController) {
            self.param.wEventEndTransferController(newVC, oldVC, index, old);
        }
        
        self.currentVC = oldVC;
        self.currentPageIndex = old;
    }
    self.hasDealAppearance = NO;
    self.nextPageIndex = -999;
    
}

- (BOOL)canTopSuspension{
    if (!self.param.wTopSuspension
       ||self.param.wMenuPosition == PageMenuPositionBottom
       ||self.param.wMenuPosition == PageMenuPositionNavi){
          return NO;
    }
    return YES;
}

//设置悬浮
- (void)setUpSuspension:(UIViewController*)newVC index:(NSInteger)index{
    if (![self canTopSuspension]) return;
    if ([newVC conformsToProtocol:@protocol(WMZPageProtocol)]) {
       if ([newVC respondsToSelector:@selector(getMyTableView)]) {
           UIScrollView *view = [newVC performSelector:@selector(getMyTableView)];
           if (view&&[view isKindOfClass:[UIScrollView class]]) {
               self.currentScroll = view;
               [self.sonChildScrollerViewDic setObject:view forKey:@(index)];
               CGFloat nowTitleY = CGRectGetMaxY(self.upSc.frame);
               view.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(normalUpScRect), 0, 0, 0);
               if (self.currentScroll.contentOffset.y<-nowTitleY) {
                    view.contentOffset = CGPointMake(view.contentOffset.x,-nowTitleY);
               }else if ((int)nowTitleY == (int)CGRectGetMaxY(normalUpScRect)){
                    view.contentOffset = CGPointMake(view.contentOffset.x,-nowTitleY);
               }
               [view pageAddObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
           }
       }
   }
}

//监听子控制器中的滚动视图
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if (![self canTopSuspension]) return;
        if (self.currentScroll!=object) return;
        CGPoint newH = [[change objectForKey:@"new"] CGPointValue];
        CGPoint newOld = [[change objectForKey:@"new"] CGPointValue];
        CGFloat navigationHeight = self.navigationController?PageVCNavBarHeight:PageVCStatusBarHeight;
        CGFloat upScHeight = self.upSc.frame.size.height;
        CGFloat allHeight = navigationHeight + upScHeight;
        CGRect upRect = self.upSc.frame;
        if (newH.y >-CGRectGetMaxY(normalUpScRect) ) {
            if (newH.y > -allHeight) {
                upRect.origin.y = navigationHeight;
            }else{
                upRect.origin.y = fabs(newH.y) - upScHeight;
            }
        }
        if (upRect.origin.y>normalUpScRect.origin.y) {
            upRect.origin.y = normalUpScRect.origin.y;
        }else if (upRect.origin.y  < navigationHeight){
            upRect.origin.y  = navigationHeight;
        }
        self.upSc.frame = upRect;
        
        if (self.headView) {
            CGRect headRect = self.headView.frame;
            headRect.origin.y = CGRectGetMinY(upRect)-headRect.size.height;
            self.headView.frame = headRect;
        }
       
        CGFloat delta = navigationHeight/CGRectGetMinY(self.upSc.frame);
        if (delta>1) {
            delta = 1;
        }else if (delta < 0){
            delta = 0;
        }
        
        if (ceil(upRect.origin.y) >= CGRectGetMinY(normalUpScRect)) {
            self.currentScroll.bounces = YES;
            delta = 0;
        }else if (upRect.origin.y<= PageVCNavBarHeight){
            self.currentScroll.bounces = YES;
            delta = 1;
        }else{
            self.currentScroll.bounces = NO;
        }
         if (self.param.wNaviAlpha) {
             if (self.navigationController) {
                 self.navigationController.navigationBar.alpha = delta;
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
            self.param.wEventChildVCDidSroll(self,newOld, newH, self.currentScroll);
        }
        
    }
}


//动画管理
- (void)animalAction:(UIScrollView*)scrollView{
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    CGFloat sWidth =  PageVCWidth;
    CGFloat content_X = (contentOffsetX / sWidth);
    NSArray *arr = [[NSString stringWithFormat:@"%f",content_X] componentsSeparatedByString:@"."];
    int num = [arr[0] intValue];
    CGFloat scale = content_X - num;
    int selectIndex = contentOffsetX/sWidth;
    
    // 拖拽
    if (contentOffsetX <= lastContentOffset ){
        selectIndex = selectIndex+1;
        _btnRight = [self safeObjectAtIndex:selectIndex data:self.upSc.btnArr];
        _btnLeft = [self safeObjectAtIndex:selectIndex-1 data:self.upSc.btnArr];
    } else if (contentOffsetX > lastContentOffset ){
        _btnRight = [self safeObjectAtIndex:selectIndex+1 data:self.upSc.btnArr];
        _btnLeft = [self safeObjectAtIndex:selectIndex data:self.upSc.btnArr];
                
    }
    
    //跟随滑动
    if (self.param.wMenuAnimal == PageTitleMenuAiQY || self.param.wMenuAnimal == PageTitleMenuYouKu) {
        CGRect rect = self.upSc.lineView.frame;
        if (scale < 0.5 ) {
            rect.size.width = self.param.wMenuIndicatorWidth + ( _btnRight.center.x-_btnLeft.center.x) * scale*2;
            rect.origin.x = _btnLeft.center.x -self.param.wMenuIndicatorWidth/2;
        }else if(scale >= 0.5 ){
            rect.size.width =  self.param.wMenuIndicatorWidth+(_btnRight.center.x-_btnLeft.center.x) * (1-scale)*2;
            rect.origin.x = _btnLeft.center.x +  2*(scale-0.5)*(_btnRight.center.x - _btnLeft.center.x)-self.param.wMenuIndicatorWidth/2;
        }
        if (rect.size.height!= (self.param.wMenuIndicatorHeight?:PageK1px)) {
            rect.size.height = self.param.wMenuIndicatorHeight?:PageK1px;
        }
        if (rect.origin.y != (self.upSc.mainView.frame.size.height-self.param.wMenuCellPadding/4-rect.size.height/2)) {
            rect.origin.y = self.upSc.mainView.frame.size.height-self.param.wMenuCellPadding/4-rect.size.height/2;
        }
        self.upSc.lineView.frame = rect;
    }
    
    //变大
    if (self.param.wMenuAnimalTitleBig) {
        _btnLeft.transform = CGAffineTransformMakeScale(0.9+(1-0.9)*(1-scale), 0.9+(1-0.9)*(1-scale));
        _btnRight.transform = CGAffineTransformMakeScale(0.9+(1-0.9)*scale, 0.9+(1-0.9)*scale);
    }
    
    //渐变
    if (self.param.wMenuAnimalTitleGradient) {
        WMZPageNaviBtn *tempBtn = _btnLeft?:_btnRight;
        CGFloat difR = tempBtn.selectedColorR - tempBtn.unSelectedColorR;
        CGFloat difG = tempBtn.selectedColorG - tempBtn.unSelectedColorG;
        CGFloat difB = tempBtn.selectedColorB - tempBtn.unSelectedColorB;
        UIColor *leftItemColor  = [UIColor colorWithRed:tempBtn.unSelectedColorR+scale*difR green:tempBtn.unSelectedColorG+scale*difG blue:tempBtn.unSelectedColorB+scale*difB alpha:1];
        UIColor *rightItemColor = [UIColor colorWithRed:tempBtn.unSelectedColorR+(1-scale)*difR green:tempBtn.unSelectedColorG+(1-scale)*difG blue:tempBtn.unSelectedColorB+(1-scale)*difB alpha:1];
        
        _btnLeft.titleLabel.textColor = rightItemColor;
        _btnRight.titleLabel.textColor = leftItemColor;
    }
}

//结束动画处理
- (void)endAninamal{
    if (self.param.wMenuAnimal == PageTitleMenuYouKu) {
        CGRect rect = self.upSc.lineView.frame;
        rect.size.height = rect.size.width;
        rect.origin.y = self.upSc.mainView.frame.size.height-rect.size.height/2-self.param.wMenuCellPadding/4;
        self.upSc.lineView.frame = rect;
        self.upSc.lineView.layer.cornerRadius = rect.size.height/2;
    }
}

- (id)safeObjectAtIndex:(NSUInteger)index data:(NSArray*)data
{
    if (index < data.count) {
        return [data objectAtIndex:index];
    } else {
        return nil;
    }
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
