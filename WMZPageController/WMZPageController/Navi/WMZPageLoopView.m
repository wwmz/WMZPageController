//
//  WMZPageLoopView.m
//  WMZPageController
//
//  Created by wmz on 2019/9/22.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZPageLoopView.h"
#import "WMZPageController.h"
@interface WMZPageLoopView()<UIScrollViewDelegate>
{
    WMZPageNaviBtn *_btnLeft ;
    WMZPageNaviBtn *_btnRight;
    CGFloat lastContentOffset;
    WMZPageController *page;
}
//最底部下划线
@property(nonatomic,strong)UIView *bottomView;

@property(nonatomic,strong)WMZPageParam  *param;
//图文
@property(nonatomic,assign)BOOL hasImage;
//固定按钮
@property(nonatomic,strong)WMZPageNaviBtn *fixBtn;
@end
@implementation WMZPageLoopView

- (instancetype)initWithFrame:(CGRect)frame param:(WMZPageParam*)param{
    if (self = [super initWithFrame:frame]) {
        self.param = param;
        [self setUp];
    }
    return self;
}

- (void)setUp{
    //标题菜单
    NSDictionary *dic = @{
        @(PageMenuPositionLeft):[NSValue valueWithCGRect:CGRectMake(0, 0 , self.param.wMenuWidth,0)],
        @(PageMenuPositionRight):[NSValue valueWithCGRect:CGRectMake(PageVCWidth-self.param.wMenuWidth, 0  , self.param.wMenuWidth,0)],
        @(PageMenuPositionCenter):[NSValue valueWithCGRect:CGRectMake((PageVCWidth-self.param.wMenuWidth)/2, 0 , self.param.wMenuWidth,0)],
        @(PageMenuPositionNavi):[NSValue valueWithCGRect:CGRectMake((PageVCWidth-self.param.wMenuWidth)/2, 0 , self.param.wMenuWidth,0)],
        @(PageMenuPositionBottom):[NSValue valueWithCGRect:CGRectMake(0, PageVCHeight, self.param.wMenuWidth,0)],
    };
    
    
    
    [self addSubview:self.mainView];
    self.mainView.frame = [dic[@(self.param.wMenuPosition)] CGRectValue] ;
    
    [self addSubview:self.dataView];
    self.dataView.scrollEnabled = self.param.wScrollCanTransfer;
    self.dataView.contentSize = CGSizeMake(self.param.wTitleArr.count*PageVCWidth,0);
    self.dataView.delegate = self;
    
    self.currentTitleIndex = -1;
    NSMutableArray *heightArr = [NSMutableArray new];
    WMZPageNaviBtn *temp = nil;
    for (int i = 0; i<self.param.wTitleArr.count; i++) {
        WMZPageNaviBtn *btn = [WMZPageNaviBtn buttonWithType:UIButtonTypeCustom];
        [self setPropertiesWithBtn:btn withIndex:i withHeightArr:heightArr withTemp:temp];
        temp = btn;
    }
    
    //布局frame
    if (self.param.wMenuPosition == PageMenuPositionBottom) {
        CGRect rect = self.frame;
        rect.origin.y -= self.frame.size.height;
        if (pageIsIphoneX) {
            rect.size.height+=10;
            rect.origin.y-=10;
        }
        self.frame = rect;
    }
    //指示器
    [self setUpIndicator];
    //右边固定标题
    [self setUpFixRightBtn:temp];
    //最底部固定线
    if (self.param.wInsertMenuLine) {
        self.bottomView = [UIView new];
        self.bottomView.backgroundColor = PageColor(0x999999);
        self.bottomView.frame = CGRectMake(0, self.mainView.frame.size.height-PageK1px, self.mainView.frame.size.width, PageK1px);
        self.param.wInsertMenuLine(self.bottomView);
    }
    if (self.bottomView) {
        CGRect lineRect = self.bottomView.frame;
        lineRect.origin.y = self.mainView.frame.size.height- lineRect.size.height;
        if (!lineRect.size.width) {
            lineRect.size.width = self.mainView.frame.size.width;
        }
        self.bottomView.frame = lineRect;
        [self addSubview:self.bottomView];
    }
    
    if (!self.param.wMenuIndicatorY) {
        self.param.wMenuIndicatorY = self.param.wMenuCellPadding/4;
    }
    
}

//初始化指示器
- (void)setUpIndicator{
    self.lineView = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self.param.wMenuIndicatorImage) {
        [self.lineView setImage:[UIImage imageNamed:self.param.wMenuIndicatorImage] forState:UIControlStateNormal];
    }else{
        self.lineView.backgroundColor = self.param.wMenuIndicatorColor;
    }
    [self.mainView addSubview:self.lineView];
    if (self.param.wMenuAnimal == PageTitleMenuCircle) {
        self.lineView.userInteractionEnabled = NO;
        [self.mainView sendSubviewToBack:self.lineView];
    }
    self.lineView.hidden = (self.param.wMenuAnimal == PageTitleMenuNone||
                            self.param.wMenuAnimal == PageTitleMenuTouTiao
                            );
    if (self.param.wMenuIndicatorRadio) {
        self.lineView.layer.cornerRadius = self.param.wMenuIndicatorRadio;
        self.lineView.layer.masksToBounds = YES;
    }
       
}

//设置右边固定标题
- (void)setUpFixRightBtn:(WMZPageNaviBtn*)temp{
    if (self.param.wMenuFixRightData) {
        WMZPageNaviBtn *fixBtn = [WMZPageNaviBtn buttonWithType:UIButtonTypeCustom];
        CGFloat menuFixWidth = self.param.wMenuFixWidth;
        id text = [self getTitleData:self.param.wMenuFixRightData key:@"name"];
        id image = [self getTitleData:self.param.wMenuFixRightData key:@"image"];
        id selectImage = [self getTitleData:self.param.wMenuFixRightData key:@"selectImage"];
        if (text) {
            [fixBtn setTitle:text forState:UIControlStateNormal];
        }
        if (image) {
            [fixBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        }
        if (selectImage) {
            [fixBtn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
        }
        if (text && image) {
            [fixBtn TagSetImagePosition:self.param.wMenuImagePosition spacing:self.param.wMenuImageMargin];
            menuFixWidth+=30;
        }
        fixBtn.titleLabel.font = [UIFont systemFontOfSize:self.param.wMenuTitleFont weight:self.param.wMenuTitleWeight];
        [fixBtn setTitleColor:self.param.wMenuTitleColor forState:UIControlStateNormal];
        fixBtn.frame = CGRectMake(CGRectGetWidth(self.frame)-menuFixWidth, temp.frame.origin.y, menuFixWidth, temp.frame.size.height);
        fixBtn.tag = 10086;
        [self addSubview:fixBtn];
        [self bringSubviewToFront:fixBtn];
        if (self.param.wMenuFixShadow) {
           [fixBtn viewShadowPathWithColor:PageColor(0x333333) shadowOpacity:0.8 shadowRadius:3 shadowPathType:PageShadowPathLeft shadowPathWidth:2];
            fixBtn.alpha = 0.9;
        }
        [fixBtn  setAdjustsImageWhenHighlighted:NO];
        [fixBtn addTarget:self action:@selector(fixTap:) forControlEvents:UIControlEventTouchUpInside];
        self.fixBtn = fixBtn;
        self.mainView.contentSize = CGSizeMake(self.mainView.contentSize.width+menuFixWidth, 0);
        [self.btnArr addObject:fixBtn];
    }
}

//设置按钮样式
- (void)setPropertiesWithBtn:(WMZPageNaviBtn*)btn withIndex:(int)i withHeightArr:(NSMutableArray*)heightArr withTemp:(WMZPageNaviBtn*)temp{
   CGFloat margin = self.param.wMenuCellMargin;
   CGFloat padding = self.param.wMenuCellPadding;
   btn.param = self.param;
   [btn  setAdjustsImageWhenHighlighted:NO];
   [btn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
   id name = [self getTitleData:self.param.wTitleArr[i] key:@"name"];
   if (name) {
       [btn setTitle:name forState:UIControlStateNormal];
       btn.normalText = name;
   }
   CGSize size =  btn.maxSize;
   //设置图片
     id image = [self getTitleData:self.param.wTitleArr[i] key:@"image"];
     id selectImage = [self getTitleData:self.param.wTitleArr[i] key:@"selectImage"];
     if (image) {
        [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
         btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
         if (name) {
            [btn TagSetImagePosition:self.param.wMenuImagePosition spacing:self.param.wMenuImageMargin];
            self.hasImage = YES;
         }
     }
     if (image&&selectImage) {
        [btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
     }

     if (size.width == 0 && image) {
         size.width = 20.0f;
     }
     if (size.height == 0 && image) {
         size.height = 20.0f;
     }
     btn.maxSize = size;
     if (self.hasImage) {
        if (self.param.wMenuImagePosition == PageBtnPositionLeft || self.param.wMenuImagePosition == PageBtnPositionRight ) {
           margin+=20;
           margin+=self.param.wMenuImageMargin;
        }
        if (self.param.wMenuImagePosition == PageBtnPositionTop || self.param.wMenuImagePosition == PageBtnPositionBottom ) {
           padding+=20;
           padding+=self.param.wMenuImageMargin;
           btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
           btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        }
     }

     btn.titleLabel.font = [UIFont systemFontOfSize:self.param.wMenuTitleFont weight:self.param.wMenuTitleWeight];

     id selectColor = [self getTitleData:self.param.wTitleArr[i] key:@"titleSelectColor"];
     [btn setTitleColor:selectColor?:self.param.wMenuTitleSelectColor forState:UIControlStateSelected];
     [btn setTitleColor:self.param.wMenuTitleColor forState:UIControlStateNormal];
     btn.tag = i;
     btn.frame = CGRectMake(temp?(CGRectGetMaxX(temp.frame)+self.param.wMenuTitleOffset):0, self.param.wMenuCellMarginY, self.param.wMenuTitleWidth?:size.width + margin, size.height + padding);
     [heightArr addObject:@(btn.frame.size.height+self.param.wMenuCellMarginY)];
     [self.mainView addSubview:btn];
     [self.btnArr addObject:btn];
     //设置右上角红点
     NSString *badge = [self getTitleData:self.param.wTitleArr[i] key:@"badge"];
     if (badge) {
        [btn showBadgeWithTopMagin:self.param.wTitleArr[i]];
     }
       
     if (self.param.wMenuPosition != PageMenuPositionNavi) {
        btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
     }
     //设置富文本
     id wrapColor = [self getTitleData:self.param.wTitleArr[i] key:@"wrapColor"];
     id firstColor = [self getTitleData:self.param.wTitleArr[i] key:@"firstColor"];
     if ([btn.titleLabel.text containsString:@"\n"]&&(wrapColor||firstColor)) {
         NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:btn.titleLabel.text];
         NSMutableAttributedString *mSelectStr = [[NSMutableAttributedString alloc] initWithString:btn.titleLabel.text];
         [mSelectStr addAttribute:NSForegroundColorAttributeName value:self.param.wMenuTitleSelectColor range:[btn.titleLabel.text rangeOfString:btn.titleLabel.text]];
         NSArray *array = [btn.titleLabel.text componentsSeparatedByString:@"\n"];
         if (wrapColor) {
             [mStr addAttribute:NSForegroundColorAttributeName value:wrapColor range:[btn.titleLabel.text rangeOfString:array[1]]];
         }
         if (firstColor) {
             [mStr addAttribute:NSForegroundColorAttributeName value:firstColor range:[btn.titleLabel.text rangeOfString:array[0]]];
         }
         [btn setAttributedTitle:mStr forState:UIControlStateNormal];
         [btn setAttributedTitle:mSelectStr forState:UIControlStateSelected];
         btn.attributed = YES;
      }
      //重新设置布局
      if (i == (self.param.wTitleArr.count -1)) {
          if (CGRectGetMaxX(btn.frame) <= self.frame.size.width) {
            self.mainView.scrollEnabled = NO;
          }else{
            self.mainView.scrollEnabled = YES;
          }
          float max =[[heightArr valueForKeyPath:@"@max.floatValue"] floatValue];
          if (pageIsIphoneX&&self.param.wMenuPosition == PageMenuPositionBottom) {
              max+=15;
          }
          [self.mainView page_height:max];
          self.mainView.contentSize = CGSizeMake(CGRectGetMaxX(btn.frame), 0);
      }
     if (self.param.wCustomMenuView) {
         self.param.wCustomMenuView(self.mainView);
     }
}

//解析字典
- (NSString*)getTitleData:(id)model key:(NSString*)key{
    if ([model isKindOfClass:[NSString class]]) {
        return [key isEqualToString:@"name"]?model:nil;
    }else if ([model isKindOfClass:[NSDictionary class]]) {
         return [model objectForKey:key]?:nil;
    }
    return nil;
}

//点击
- (void)tap:(UIButton*)btn{
    if (!self.first) {
        if (self.param.wEventClick) {
            self.param.wEventClick(btn, btn.tag);
        }
    }
    if (self.currentTitleIndex == btn.tag) return;
    NSInteger index = btn.tag;
    if (self.loopDelegate&&[self.loopDelegate respondsToSelector:@selector(selectBtnWithIndex:)]) {
        [self.loopDelegate selectBtnWithIndex:index];
    }
    if (self.first) {
         self.lastPageIndex = self.currentTitleIndex;
         self.nextPageIndex = index;
         self.currentTitleIndex = index;
         UIViewController *newVC = [self getVCWithIndex:index];
         [newVC beginAppearanceTransition:YES animated:YES];
         [self addChildVC:index VC:newVC];
         self.dataView.contentOffset = CGPointMake(index*PageVCWidth, 0);
         [newVC endAppearanceTransition];
         if (self.loopDelegate&&[self.loopDelegate respondsToSelector:@selector(setUpSuspension:index:end:)]) {
             [self.loopDelegate setUpSuspension:newVC index:index end:YES];
         }
        self.first = NO;

    }else{

        [self beginAppearanceTransitionWithIndex:index withOldIndex:self.currentTitleIndex];
        self.lastPageIndex = self.currentTitleIndex;
        self.nextPageIndex = index;
        self.currentTitleIndex = index;
        [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.lastPageIndex isFlag:NO];
        self.dataView.contentOffset = CGPointMake(index*PageVCWidth, 0);
    }
        
    
    [self scrollToIndex:index];
}

//固定标题点击
- (void)fixTap:(UIButton*)btn{
    btn.selected = ![btn isSelected];
    if (self.param.wEventFixedClick) {
        self.param.wEventFixedClick(btn, btn.tag);
    }
}

//滚动到中间
- (void)scrollToIndex:(NSInteger)newIndex{
    WMZPageNaviBtn *btn = self.btnArr[newIndex] ;
    //隐藏右上角红点
    [btn hidenBadge];
    //改变背景色
    id backgroundColor = [self getTitleData:self.param.wTitleArr[newIndex] key:@"backgroundColor"];
    //改变指示器颜色
    id indicatorColor = [self getTitleData:self.param.wTitleArr[newIndex] key:@"indicatorColor"];
    //改变其他未选中标题的颜色
    id titleColor = [self getTitleData:self.param.wTitleArr[newIndex] key:@"titleColor"];
    
    //改变标题颜色
    for (WMZPageNaviBtn *temp in self.btnArr) {
        temp.selected = (temp.tag == newIndex ?YES:NO);
        if ([temp isSelected]) {
            UIColor *tempBackgroundColor = self.param.wMenuBgColor;
            UIColor *fixBackgroundColor = self.param.wMenuBgColor;
            if (backgroundColor) {
                //渐变色
                if ([backgroundColor isKindOfClass:[NSArray class]]) {
                    if ([backgroundColor count]==2) {
                        tempBackgroundColor = [UIColor bm_colorGradientChangeWithSize:self.mainView.frame.size direction:PageGradientChangeDirectionLevel startColor:backgroundColor[0] endColor:backgroundColor[1]];
                        fixBackgroundColor = backgroundColor[1];
                    }else{
                        tempBackgroundColor = backgroundColor[0];
                        fixBackgroundColor = tempBackgroundColor;
                    }
                }
                else if ([backgroundColor isKindOfClass:[UIColor class]]){
                    tempBackgroundColor = backgroundColor;
                    fixBackgroundColor = tempBackgroundColor;
                }
            }
            if (!self.param.wInsertHeadAndMenuBg) {
                self.mainView.backgroundColor = tempBackgroundColor;
            }
            if (!self.param.wMenuIndicatorImage) {
                self.lineView.backgroundColor = indicatorColor?:self.param.wMenuIndicatorColor;
            }
            self.fixBtn.backgroundColor = fixBackgroundColor;
            [self.fixBtn setTitleColor:titleColor?:self.param.wMenuTitleColor forState:UIControlStateNormal];
            if (self.param.wMenuAnimalTitleBig) {
                temp.titleLabel.font = [UIFont systemFontOfSize:self.param.wMenuTitleSelectFont weight:self.param.wMenuTitleWeight];
            }
        }else{
            [temp setTitleColor:titleColor?:self.param.wMenuTitleColor forState:UIControlStateNormal];
            if (self.param.wMenuAnimalTitleBig) {
               temp.titleLabel.font = [UIFont systemFontOfSize:self.param.wMenuTitleFont weight:self.param.wMenuTitleWeight];
            }
        }
    }
    
    
    //滚动到中间
    CGFloat centerX = self.mainView.frame.size.width/2 ;
    CGRect indexFrame = btn.frame;
    CGFloat contenSize = self.mainView.contentSize.width;
    CGPoint point = CGPointZero;
    if (indexFrame.origin.x<= centerX) {
        point = CGPointMake(0, 0);
    }else if (CGRectGetMaxX(indexFrame) > (contenSize-centerX)) {
        point = CGPointMake(self.mainView.contentSize.width-self.mainView.frame.size.width , 0);
    }else{
        point = CGPointMake(CGRectGetMaxX(indexFrame) -  centerX-  indexFrame.size.width/2, 0);
    }
    
    if ([self.mainView isScrollEnabled]) {
        [UIView animateWithDuration:0.25f animations:^(void){
           [self.mainView setContentOffset:point];
        }];
    }
    CGFloat dataWidth = btn.titleLabel.frame.size.width?:btn.maxSize.width;
    //改变指示器frame
    CGRect lineRect = indexFrame;
    lineRect.size.height = self.param.wMenuIndicatorHeight?:PageK1px;
    lineRect.origin.y = [self getMainHeight] - lineRect.size.height/2 - self.param.wMenuIndicatorY;
    lineRect.size.width =  self.param.wMenuIndicatorWidth?:(dataWidth+10);
    lineRect.origin.x =  (indexFrame.size.width - lineRect.size.width)/2 + indexFrame.origin.x;
    
    if (self.param.wMenuAnimal == PageTitleMenuYouKu) {
        lineRect.size.height = lineRect.size.width;
        self.lineView.layer.masksToBounds = YES;
        self.lineView.layer.cornerRadius = lineRect.size.height/2;
    }
    
    if (self.param.wMenuAnimal == PageTitleMenuPDD) {
        lineRect.origin.y = self.frame.size.height - lineRect.size.height;
        lineRect.size.width = self.param.wMenuIndicatorWidth?:dataWidth;
        lineRect.origin.x =  (indexFrame.size.width - lineRect.size.width)/2 + indexFrame.origin.x;
    }
    
    if (self.param.wMenuAnimal == PageTitleMenuCircle) {
        lineRect = indexFrame;
        lineRect.origin.x =  lineRect.origin.x - 2;
        lineRect.origin.y =  lineRect.origin.y + 4;
        lineRect.size.width =  lineRect.size.width + 4;
        lineRect.size.height =  lineRect.size.height - 8 ;
        self.lineView.layer.masksToBounds = YES;
        self.lineView.layer.cornerRadius =  self.param.wMenuCircilRadio?:(lineRect.size.height/2);
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        self.lineView.frame = lineRect;
    } completion:^(BOOL finished) {
        
    }];
    
    self.currentTitleIndex = newIndex;
    if (self.param.wInsertHeadAndMenuBg) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    if (self.param.wCustomMenuSelectTitle) {
        self.param.wCustomMenuSelectTitle(self.btnArr);
    }
}

- (CGFloat)getMainHeight{
    return ((pageIsIphoneX&&self.param.wMenuPosition == PageMenuPositionBottom)?(self.mainView.frame.size.height - 15):self.mainView.frame.size.height);
}

#pragma -mark- scrollerDeleagte
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView != self.dataView) return;
    lastContentOffset = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView != self.dataView) return;
    if (![scrollView isDecelerating]&&![scrollView isDragging]) return;
    if (scrollView.contentOffset.x>0 &&scrollView.contentOffset.x<=self.btnArr.count*PageVCWidth ) {
         [self lifeCycleManage:scrollView];
         [self animalAction:scrollView lastContrnOffset:lastContentOffset];
    }
    
    if (scrollView.contentOffset.y == 0) return;
    CGPoint contentOffset = scrollView.contentOffset;
    contentOffset.y = 0.0;
    scrollView.contentOffset = contentOffset;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView != self.dataView) return;
    if (!decelerate) {
        [self endAninamal];
        NSInteger newIndex = scrollView.contentOffset.x/PageVCWidth;
        self.currentTitleIndex = newIndex;
        if (self.loopDelegate && [self.loopDelegate respondsToSelector:@selector(pageScrollEndWithScrollView:)]) {
            [self.loopDelegate pageScrollEndWithScrollView:scrollView];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView != self.dataView) return;
    [self endAninamal];
    NSInteger newIndex = scrollView.contentOffset.x/PageVCWidth;
    self.currentTitleIndex = newIndex;
    if (!self.hasEndAppearance) {
        [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.lastPageIndex isFlag:NO];
    }
    self.hasEndAppearance = NO;
    [self scrollToIndex:newIndex];
    
    if (self.loopDelegate && [self.loopDelegate respondsToSelector:@selector(pageScrollEndWithScrollView:)]) {
        [self.loopDelegate pageScrollEndWithScrollView:scrollView];
    }
}

//管理生命周期
- (void)lifeCycleManage:(UIScrollView*)scrollView{
    CGFloat diffX = scrollView.contentOffset.x - lastContentOffset;
    if (diffX < 0) {
        self.currentTitleIndex = ceil(scrollView.contentOffset.x/PageVCWidth);
    }else{
        self.currentTitleIndex = (scrollView.contentOffset.x/PageVCWidth);
    }
    if (self.loopDelegate && [self.loopDelegate respondsToSelector:@selector(pageWithScrollView:left:)]) {
        [self.loopDelegate pageWithScrollView:scrollView left:(diffX < 0)];
    }
    if (diffX > 0) {
        if (self.hasDealAppearance&&self.nextPageIndex == self.currentTitleIndex) {
            self.hasEndAppearance = YES;
            [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.currentTitleIndex-1 isFlag:YES];
            [self endAninamal];
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
            [self endAninamal];
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
    if (index < 0|| index >= self.param.wControllers.count) {
        return nil;
    }
    
    if ([[self findBelongViewControllerForView:self].cache objectForKey:@(index)]) {
        return [[self findBelongViewControllerForView:self].cache objectForKey:@(index)];
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
    
    if (self.loopDelegate&&[self.loopDelegate respondsToSelector:@selector(setUpSuspension:index:end:)]) {
        [self.loopDelegate setUpSuspension:newVC index:index end:NO];
    }

    if (self.param.wEventBeganTransferController) {
        self.param.wEventBeganTransferController(oldVC, newVC, old, index);
    }
}

- (void)addChildVC:(NSInteger)index VC:(UIViewController*)newVC{
    if (![[self findBelongViewControllerForView:self].childViewControllers containsObject:newVC]) {
        [[self findBelongViewControllerForView:self] addChildViewController:newVC];
        CGRect frame = CGRectMake(index * self.dataView.frame.size.width,0,self.dataView.frame.size.width,
                                  self.dataView.frame.size.height);
        newVC.view.frame = frame;
        [self.dataView addSubview:newVC.view];
        [newVC didMoveToParentViewController:[self findBelongViewControllerForView:self]];
        [[self findBelongViewControllerForView:self].cache setObject:newVC forKey:@(index)];
    }
}

- (void)endAppearanceTransitionWithIndex:(NSInteger)index withOldIndex:(NSInteger)old  isFlag:(BOOL)flag{
    UIViewController *newVC = [self getVCWithIndex:index];
    UIViewController *oldVC = [self getVCWithIndex:old];
    
    if (!newVC||!oldVC||(index==old))   return;
    if (self.currentTitleIndex == self.nextPageIndex) {

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
        self.currentTitleIndex = index;
        
        if (self.loopDelegate&&[self.loopDelegate respondsToSelector:@selector(setUpSuspension:index:end:)]) {
            [self.loopDelegate setUpSuspension:newVC index:index end:YES];
        }
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
        self.currentTitleIndex = old;
        
        if (self.loopDelegate&&[self.loopDelegate respondsToSelector:@selector(setUpSuspension:index:end:)]) {
            [self.loopDelegate setUpSuspension:oldVC index:old end:YES];
        }
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

//动画管理
- (void)animalAction:(UIScrollView*)scrollView lastContrnOffset:(CGFloat)lastContentOffset{
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
        _btnRight = [self safeObjectAtIndex:selectIndex data:self.btnArr];
        _btnLeft = [self safeObjectAtIndex:selectIndex-1 data:self.btnArr];
    } else if (contentOffsetX > lastContentOffset ){
        _btnRight = [self safeObjectAtIndex:selectIndex+1 data:self.btnArr];
        _btnLeft = [self safeObjectAtIndex:selectIndex data:self.btnArr];
                
    }
    
    //跟随滑动
    if (self.param.wMenuAnimal == PageTitleMenuAiQY || self.param.wMenuAnimal == PageTitleMenuYouKu) {
        CGRect rect = self.lineView.frame;
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
        if (rect.origin.y != ([self getMainHeight]-self.param.wMenuIndicatorY-rect.size.height/2)) {
            rect.origin.y = [self getMainHeight]-self.param.wMenuIndicatorY-rect.size.height/2;
        }
        self.lineView.frame = rect;
    }
    
    //变大
    if (self.param.wMenuAnimalTitleBig) {
        _btnLeft.transform = CGAffineTransformMakeScale(1+(1-0.9)*(1-scale), 1+(1-0.9)*(1-scale));
        _btnRight.transform = CGAffineTransformMakeScale(1+(1-0.9)*scale, 1+(1-0.9)*scale);
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
        CGRect rect = self.lineView.frame;
        rect.size.height = rect.size.width;
        rect.origin.y = [self getMainHeight]-rect.size.height/2-self.param.wMenuCellPadding/4;
        self.lineView.frame = rect;
        self.lineView.layer.cornerRadius = rect.size.height/2;
    }else if (self.param.wMenuAnimal == PageTitleMenuAiQY){
        CGRect rect = self.lineView.frame;
        if (rect.origin.y != ([self getMainHeight]-self.param.wMenuIndicatorY-rect.size.height/2)) {
            rect.origin.y = [self getMainHeight]-self.param.wMenuIndicatorY-rect.size.height/2;
        }
        self.lineView.frame = rect;
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


- (nullable WMZPageController *)findBelongViewControllerForView:(UIView *)view {
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass:[WMZPageController class]]) {
            return (WMZPageController *)responder;
        }
    return nil;
}

- (UIScrollView *)mainView{
    if (!_mainView) {
        _mainView = [UIScrollView new];
        _mainView.showsVerticalScrollIndicator = NO;
        _mainView.showsHorizontalScrollIndicator = NO;
        _mainView.decelerationRate = UIScrollViewDecelerationRateFast;
        _mainView.bouncesZoom = NO;
        if (@available(iOS 11.0, *)) {
            _mainView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _mainView;
}

- (UIScrollView *)dataView{
    if (!_dataView) {
        _dataView = [UIScrollView new];
        _dataView.showsVerticalScrollIndicator = NO;
        _dataView.showsHorizontalScrollIndicator = NO;
        _dataView.pagingEnabled = YES;
        _dataView.bounces = NO;
        _dataView.scrollsToTop = NO;
        if (@available(iOS 11.0, *)) {
            _dataView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _dataView.frame = CGRectMake(0, CGRectGetMaxY(self.mainView.frame),self.bounds.size.width, 0) ;
    }
    return _dataView;
}

- (NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr = [NSMutableArray new];
    }
    return _btnArr;
}

- (void)dealloc{
    
}

@end
