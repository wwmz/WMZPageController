//
//  WMZTaoBaoDemo.m
//  WMZPageController
//
//  Created by wmz on 2020/7/23.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZTaoBaoDemo.h"
#import "UIImageView+WebCache.h"
#import "CollectionViewPopDemo.h"
@interface WMZTaoBaoDemo ()

@end

@implementation WMZTaoBaoDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    //标题数组
       __weak WMZTaoBaoDemo *weakSelf = self;
       NSArray *data = @[@"全部\n猜你喜欢",@"直播\n新品搭配购",@"便宜好货\n低价抢购",@"买家秀\n真实晒单"];
       WMZPageParam *param =
       PageParam()
       .wTitleArrSet(data)
       .wViewControllerSet(^UIViewController *(NSInteger index) {
          return [CollectionViewPopDemo new];
        })
       .wMenuHeightSet(80)
       //⚠️此为改变菜单栏高度的属性  传入正数为高度减少的数值 负数为高度增加的数值
       .wTopChangeHeightSet(20)
       //悬浮开启
       .wTopSuspensionSet(YES)
       .wMenuIndicatorColorSet([UIColor orangeColor])
       .wMenuAnimalSet(PageTitleMenuAiQY)
       .wMenuTitleWidthSet(self.view.frame.size.width / 4)
       //顶部可下拉
       .wBouncesSet(YES)
       .wMenuAnimalTitleGradientSet(NO)
       //头视图y坐标从0开始
       .wFromNaviSet(NO)
       .wNaviAlphaSet(YES)
       //头部
       .wMenuHeadViewSet(^UIView *{
           UIView *back = [UIView new];
           back.frame = CGRectMake(0, 0, PageVCWidth, 300);
           UIImageView *image = [UIImageView new];
           [image sd_setImageWithURL:[NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/9163368-02e26751674a3bc6.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"]];
           image.frame =back.bounds;
           [back addSubview:image];
           return back;
       })
        //自定义常态富文本
        .wCustomMenuTitleSet(^(NSArray *titleArr) {
             __strong WMZTaoBaoDemo *strongSelf = weakSelf;
            [titleArr enumerateObjectsUsingBlock:^(WMZPageNaviBtn*  _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
                [strongSelf customBtn:btn];
            }];
        })
        //⚠️自定义改变高度的UI变化
       .wEventMenuChangeHeightSet(^(NSArray<WMZPageNaviBtn *> *titleArr, CGFloat offset) {
            __strong WMZTaoBaoDemo *strongSelf = weakSelf;
           if (offset >= 20) {
               [titleArr enumerateObjectsUsingBlock:^(WMZPageNaviBtn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                   [strongSelf changeBtn:obj];
               }];
               [strongSelf.upSc.lineView setHidden:NO];
           }
        })
        //⚠️自定义恢复高度的UI变化
       .wEventMenuNormalHeightSet(^(NSArray<WMZPageNaviBtn *> *titleArr) {
            __strong WMZTaoBaoDemo *strongSelf = weakSelf;
           [titleArr enumerateObjectsUsingBlock:^(WMZPageNaviBtn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               [strongSelf customBtn:obj];
           }];
           [strongSelf.upSc.lineView setHidden:YES];
       });
       self.param = param;
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           self.upSc.lineView.hidden = YES;
       });
}

//正常富文本
- (void)customBtn:(WMZPageNaviBtn*)btn{
    //闲置
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:btn.normalText];
    //选中
    NSMutableAttributedString *mSelectStr = [[NSMutableAttributedString alloc] initWithString:btn.normalText];
    NSArray *array = [btn.normalText componentsSeparatedByString:@"\n"];
      
    [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:[btn.normalText rangeOfString:btn.normalText]];
    [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f weight:20] range:[btn.normalText rangeOfString:array[0]]];
    [mStr addAttribute:NSForegroundColorAttributeName value:PageColor(0x333333) range:[btn.normalText rangeOfString:array[0]]];
    [mStr addAttribute:NSBackgroundColorAttributeName value:[UIColor clearColor] range:[btn.normalText rangeOfString:btn.normalText]];
    
    [mSelectStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f weight:20] range:[btn.normalText rangeOfString:array[0]]];
    [mSelectStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:[btn.normalText rangeOfString:array[0]]];
    
    if (!btn.attributedSelectImage) {
        btn.attributedSelectImage = [btn setImageWithStr:array[1] font:[UIFont boldSystemFontOfSize:15.0f] textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] height:18.0f backgroundColor:[UIColor orangeColor] cornerRadius:9];
    }
    if (!btn.attributedImage) {
        btn.attributedImage = [btn setImageWithStr:array[1] font:[UIFont boldSystemFontOfSize:15.0f] textAlignment:NSTextAlignmentCenter textColor:PageColor(0x333333) height:18.0f backgroundColor:nil cornerRadius:0];
    }
    
    [mStr replaceCharactersInRange:[btn.normalText rangeOfString:array[1]] withAttributedString:btn.attributedImage];
    [mSelectStr replaceCharactersInRange:[btn.normalText rangeOfString:array[1]] withAttributedString:btn.attributedSelectImage];
    [btn setAttributedTitle:mStr forState:UIControlStateNormal];
    [btn setAttributedTitle:mSelectStr forState:UIControlStateSelected];
    
}

//改变高度富文本
- (void)changeBtn:(WMZPageNaviBtn*)btn{
    NSArray *array = [btn.normalText componentsSeparatedByString:@"\n"];
    NSString *str = [NSString stringWithFormat:@"%@\n%@",array[0],@" "];
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableAttributedString *mSelectStr = [[NSMutableAttributedString alloc] initWithString:str];
    [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:[str rangeOfString:str]];
    [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f weight:20] range:[str rangeOfString:str]];
    [mSelectStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f weight:20] range:[str rangeOfString:str]];
    [mStr addAttribute:NSForegroundColorAttributeName value:PageColor(0x333333) range:[str rangeOfString:str]];
    [mSelectStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:[str rangeOfString:str]];
    [mStr addAttribute:NSBackgroundColorAttributeName value:[UIColor clearColor] range:[str rangeOfString:str]];
    [btn setAttributedTitle:mStr forState:UIControlStateNormal];
    [btn setAttributedTitle:mSelectStr forState:UIControlStateSelected];
}
@end
