//
//  WMZPageLoopView.m
//  WMZPageController
//
//  Created by wmz on 2019/9/22.
//  Copyright © 2019 wmz. All rights reserved.
//


#import "WMZPageLoopView.h"
@interface WMZPageLoopView()
@property(nonatomic,strong)WMZPageParam  *param;
@property(nonatomic,assign)NSInteger currentTitleIndex;
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
    self.mainView = [UIScrollView new];
    self.mainView.frame = CGRectMake(0, 0,self.bounds.size.width, self.bounds.size.height) ;
    self.mainView.showsVerticalScrollIndicator = NO;
    self.mainView.showsHorizontalScrollIndicator = NO;
    self.mainView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.mainView.bouncesZoom = NO;
    if (@available(iOS 11.0, *)) {
        self.mainView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:self.mainView];
    
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
            self.param.wMenuFixWidth+=30;
        }
        fixBtn.titleLabel.font = [UIFont systemFontOfSize:self.param.wMenuTitleFont weight:self.param.wMenuTitleWeight];
        [fixBtn setTitleColor:self.param.wMenuTitleColor forState:UIControlStateNormal];
        fixBtn.frame = CGRectMake(CGRectGetWidth(self.frame)-self.param.wMenuFixWidth, temp.frame.origin.y, self.param.wMenuFixWidth, temp.frame.size.height);
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
        self.mainView.contentSize = CGSizeMake(self.mainView.contentSize.width+self.param.wMenuFixWidth, 0);
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
     if ([self getTitleData:self.param.wTitleArr[i] key:@"badge"]) {
        [btn showBadgeWithTopMagin:0];
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
          self.mainView.frame = CGRectMake(0, 0, self.frame.size.width, max) ;
          self.mainView.contentSize = CGSizeMake(CGRectGetMaxX(btn.frame), 0);
          CGRect rect = self.frame;
          rect.size.height = self.mainView.frame.size.height;
          self.frame = rect;
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
    if (self.param.wEventClick) {
        self.param.wEventClick(btn, btn.tag);
    }
    if (self.currentTitleIndex == btn.tag) return;
    
    if (self.loopDelegate && [self.loopDelegate respondsToSelector:@selector(selectWithBtn:first:)]) {
        [self.loopDelegate selectWithBtn:btn first:self.first];
        self.first = NO;
    }
    [self scrollToIndex:btn.tag];
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
    if (self.currentTitleIndex == newIndex) return;

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
            self.backgroundColor = tempBackgroundColor;
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
    CGFloat centerX = self.frame.size.width/2 ;
    CGRect indexFrame = btn.frame;
    CGFloat contenSize = self.mainView.contentSize.width;
    CGPoint point = CGPointZero;
    if (indexFrame.origin.x<= centerX) {
        point = CGPointMake(0, 0);
    }else if (CGRectGetMaxX(indexFrame) > (contenSize-centerX)) {
        point = CGPointMake(self.mainView.contentSize.width-self.frame.size.width , 0);
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
    lineRect.origin.y = self.mainView.frame.size.height - lineRect.size.height/2 - self.param.wMenuCellPadding/4;
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
        self.lineView.layer.cornerRadius = lineRect.size.height/2;
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


- (NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr = [NSMutableArray new];
    }
    return _btnArr;
}



@end
