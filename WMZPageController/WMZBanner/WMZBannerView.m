

//
//  WMZBannerView.m
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZBannerView.h"
#import "WMZBannerFlowLayout.h"
#import "WMZBannerControl.h"
#define COUNT 500
@interface WMZBannerView()<UICollectionViewDelegate,UICollectionViewDataSource>{
    BOOL beganDragging;
}
@property(strong,nonatomic)UICollectionView *myCollectionV;
@property(strong,nonatomic)WMZBannerFlowLayout *flowL ;
@property(strong,nonatomic)WMZBannerControl *bannerControl ;
@property(strong,nonatomic)UIImageView *bgImgView;
@property(strong,nonatomic)NSArray *data;
@property(strong,nonatomic)WMZBannerParam *param;
@property(nonatomic,  weak)NSTimer *timer;
@end
@implementation WMZBannerView
- (instancetype)initConfigureWithModel:(WMZBannerParam *)param withView:(UIView*)parentView{
    if (self = [super init]) {
        self.param = param;
        if (parentView) {
            [parentView addSubview:self];
        }
        [self setFrame:self.param.wFrame];
        self.data = [NSArray arrayWithArray:self.param.wData];
        [self setUp];
    }
    return self;
}

/**
 *  调用方法
 *
 */
- (instancetype)initConfigureWithModel:(WMZBannerParam *)param{
    if (self = [super init]) {
        self.param = param;
        [self setFrame:self.param.wFrame];
        self.data = [NSArray arrayWithArray:self.param.wData];
        [self setUp];
    }
    return self;
}

- (void)updateUI{
    self.data = [NSArray arrayWithArray:self.param.wData];
    [self resetCollection];
}


- (void)resetCollection{
    self.bannerControl.numberOfPages = self.data.count;
    [UIView animateWithDuration:0.0 animations:^{
        [self.myCollectionV reloadData];

        if (self.param.wSelectIndex|| self.param.wRepeat) {
            NSIndexPath *path = [NSIndexPath indexPathForRow: self.param.wRepeat?((COUNT/2)*self.data.count+self.param.wSelectIndex):self.param.wSelectIndex inSection:0];
            [self scrolToPath:path animated:NO];
            self.bannerControl.currentPage = self.param.wSelectIndex;
            self.param.myCurrentPath = self.param.wRepeat?((COUNT/2)*self.data.count+self.param.wSelectIndex):self.param.wSelectIndex;
            if (self.param.wAutoScroll) {
                [self createTimer];
            }else{
                [self cancelTimer];
            }
        }
    } completion:^(BOOL finished) {}];
    
    
}

- (void)setUp{
    if (self.param.wItemSize.height == 0 || self.param.wItemSize.width == 0 ) {
        self.param.wItemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    }else if(self.param.wItemSize.width<self.frame.size.width/2){
        self.param.wItemSize = CGSizeMake(self.frame.size.width/2, self.param.wItemSize.height);
    }else if(self.param.wItemSize.height>self.frame.size.height){
        self.param.wItemSize = CGSizeMake(self.param.wItemSize.width, self.frame.size.height);
    }else if(self.param.wItemSize.width>self.frame.size.width){
        self.param.wItemSize = CGSizeMake(self.frame.size.width, self.param.wItemSize.height);
    }
    
    self.flowL = [[WMZBannerFlowLayout alloc] initConfigureWithModel:self.param];;

    [self addSubview:self.myCollectionV];
    self.myCollectionV.frame = self.bounds;
    self.myCollectionV.scrollEnabled = self.param.wCanFingerSliding;
    [self.myCollectionV registerClass:[Collectioncell class] forCellWithReuseIdentifier:NSStringFromClass([Collectioncell class])];
    if (self.param.wMyCellClassName) {
        [self.myCollectionV registerClass:NSClassFromString(self.param.wMyCellClassName) forCellWithReuseIdentifier:self.param.wMyCellClassName];
    }
    
    self.myCollectionV.pagingEnabled = (self.param.wItemSize.width == self.myCollectionV.frame.size.width&& self.param.wLineSpacing == 0);
    self.bannerControl = [[WMZBannerControl alloc]initWithFrame:CGRectMake(0, self.param.wItemSize.height-40, self.param.wItemSize.width, 30) WithModel:self.param];
    CGFloat center = self.center.x;
    if (self.param.wBannerControlPosition == BannerControlLeft) {
        center = self.center.x*0.2;
    }
    else if (self.param.wBannerControlPosition == BannerControlRight) {
        center = self.center.x*1.7;
    }
    self.bannerControl.center = CGPointMake(center, self.bannerControl.center.y);
    [self addSubview:self.bannerControl];
    self.bannerControl.hidden = self.param.wHideBannerControl;
    
    [self resetCollection];
    
    self.bgImgView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.myCollectionV.backgroundView = self.bgImgView;
    self.bgImgView.hidden = !self.param.wEffect;
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.frame = self.bounds;
    [self.myCollectionV.backgroundView addSubview:effectView];
    
    

}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = self.param.wRepeat?indexPath.row%self.data.count:indexPath.row;
    id dic = self.data[index];
    if (self.param.wMyCell) {
        return self.param.wMyCell([NSIndexPath indexPathForRow:index inSection:indexPath.section], collectionView, dic,self.bgImgView,self.data);
    }else{
        //默认视图
        Collectioncell *cell = (Collectioncell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([Collectioncell class]) forIndexPath:indexPath];
        
        cell.param = self.param;
        if ([dic isKindOfClass:[NSDictionary class]]) {
            [self setIconData:cell.icon withData:dic[@"icon"]];
            [self setIconData:self.bgImgView withData:dic[@"icon"]];
        }else{
            [self setIconData:cell.icon withData:dic];
            [self setIconData:self.bgImgView withData:dic];
        }
      return cell;
        
    }
}

- (void)setIconData:(UIImageView*)icon withData:(id)data{
    if ([data isKindOfClass:[NSString class]]) {
        if ([(NSString*)data hasPrefix:@"http"]) {
            [icon sd_setImageWithURL:[NSURL URLWithString:(NSString*)data] placeholderImage:self.param.wPlaceholderImage?[UIImage imageNamed:self.param.wPlaceholderImage]:nil];
            
        }else{
            icon.image = [UIImage imageNamed:(NSString*)data];
        }
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.param.wRepeat?self.data.count*COUNT:self.data.count;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.param.wEventClick) {
        NSInteger index = self.param.wRepeat?indexPath.row%self.data.count:indexPath.row;
        id dic = self.data[index];
        self.param.wEventClick(dic, index);
    }
}



//滚动处理
- (void)scrolToPath:(NSIndexPath*)path animated:(BOOL)animated{
    if (self.param.wRepeat?(path.row> self.data.count*COUNT-1):(path.row> self.data.count-1)){
        [self cancelTimer];
        return;
    }
    if (self.data.count==0) return;
    [self.myCollectionV scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animated];
    if ([self.myCollectionV isPagingEnabled]) return;
    if(self.param.wContentOffsetX>0.5){
        self.myCollectionV.contentOffset = CGPointMake(self.myCollectionV.contentOffset.x-(self.param.wContentOffsetX-0.5)*self.myCollectionV.frame.size.width, self.myCollectionV.contentOffset.y);
    }else if(self.param.wContentOffsetX<0.5){
        self.myCollectionV.contentOffset = CGPointMake(self.myCollectionV.contentOffset.x+self.myCollectionV.frame.size.width *(0.5-self.param.wContentOffsetX), self.myCollectionV.contentOffset.y);
    }
}


//定时器
- (void)createTimer{
    
    [self cancelTimer];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.param.wAutoScrollSecond  target:self selector:@selector(autoScrollAction) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

//定时器方法
- (void)autoScrollAction{
    if (beganDragging) return;
    if (!self.param.wAutoScroll) {
        [self cancelTimer];
        return;
    }

    self.param.myCurrentPath+=1;
    if (self.param.wRepeat&&  self.param.myCurrentPath == (self.data.count*COUNT)) {
       self.param.myCurrentPath = 0;
    }
    else if(!self.param.wRepeat&&  self.param.myCurrentPath == self.data.count){
        [self cancelTimer];
        return;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem: self.param.myCurrentPath inSection:0];
    [self scrolToPath:nextIndexPath animated:YES];
}

//定时器销毁
- (void)cancelTimer{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

//开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    beganDragging = YES;
    if (self.param.wAutoScroll) {
        [self cancelTimer];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.myCollectionV isPagingEnabled]) {
        NSInteger index = scrollView.contentOffset.x/(scrollView.frame.size.width+self.param.wLineSpacing);
        self.param.myCurrentPath = index;
        self.bannerControl.currentPage = self.param.wRepeat?index %self.data.count:index;
    }
}

//拖动结束
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    beganDragging = NO;
    if (![self.myCollectionV isPagingEnabled]) {
        self.bannerControl.currentPage = self.param.wRepeat?self.param.myCurrentPath%self.data.count:self.param.myCurrentPath;
    }
    if (self.param.wAutoScroll) {
        [self createTimer];
    }
    
}



- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (![self.myCollectionV isPagingEnabled]) {
        self.bannerControl.currentPage = self.param.wRepeat?self.param.myCurrentPath%self.data.count:self.param.myCurrentPath;
    }
}


- (UICollectionView *)myCollectionV{
    if (!_myCollectionV) {
        _myCollectionV = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:_flowL];
        _myCollectionV.delegate = self;
        _myCollectionV.dataSource = self;
        _myCollectionV.showsVerticalScrollIndicator = NO;
        _myCollectionV.showsHorizontalScrollIndicator = NO;
        _myCollectionV.backgroundColor = [UIColor clearColor];
        _myCollectionV.decelerationRate = _param.wDecelerationRate;
    }
    return _myCollectionV;
}

- (WMZBannerControl *)bannerControl{
    if (!_bannerControl) {
        _bannerControl = [[WMZBannerControl alloc]initWithFrame:CGRectZero WithModel:_param];
    }
    return _bannerControl;
}

- (void)dealloc{
    [self cancelTimer];
}

@end

@implementation Collectioncell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.icon = [UIImageView new];
        self.icon.layer.masksToBounds = YES;
        [self.contentView addSubview:self.icon];
        self.icon.frame = self.contentView.bounds;
//        self.contentView.layer.masksToBounds = YES;
//        self.contentView.layer.cornerRadius = 5;
    }
    return self;
}

- (void)setParam:(WMZBannerParam *)param{
    _param = param;
    self.icon.contentMode = param.wImageFill?UIViewContentModeScaleAspectFill:UIViewContentModeScaleToFill;
}
@end
