# WMZPageController - 分页控制器,替换UIPageController方案,具备完整的生命周期,多种指示器样式,多种标题样式,可悬浮,支持ios13暗黑模式(仿淘宝,优酷,爱奇艺,今日头条,简书,京东等多种标题菜单)（cocopod更新至1.2.0，使用有问题的话先看看是不是最新的版本,有问题加群937909825）

# 注意⚠️⚠️  使用悬浮样式需要实现协议 WMZPageProtocol 

演示
==============
### 动画样式 
| 动画样式                | 作用   (默认值)                                 |
|-----------------------|-----------------------------------------------------|
| 爱奇艺样式               | ![AQY.gif](https://upload-images.jianshu.io/upload_images/9163368-2aeb8a149df8c985.gif?imageMogr2/auto-orient/strip)|
| 优酷样式               | ![YouKu.gif](https://upload-images.jianshu.io/upload_images/9163368-4444482198f9a013.gif?imageMogr2/auto-orient/strip)|
| 头条样式              | ![Toutiao.gif](https://upload-images.jianshu.io/upload_images/9163368-07204254c59bb15c.gif?imageMogr2/auto-orient/strip)|
| 京东样式              | ![Jingdong.gif](https://upload-images.jianshu.io/upload_images/9163368-cc1f472eabfe9fcf.gif?imageMogr2/auto-orient/strip)|
|QQ样式              | ![QQ.gif](https://upload-images.jianshu.io/upload_images/9163368-f700c66170ba6f16.gif?imageMogr2/auto-orient/strip)|


### 标题样式 
| 标题样式                | 作用   (默认值)                                 |
|-----------------------|-----------------------------------------------------|
| 换行               |  ![换行.gif](https://upload-images.jianshu.io/upload_images/9163368-0ccff6215a919dc2.gif?imageMogr2/auto-orient/strip) |
| 富文本               |![富文本.gif](https://upload-images.jianshu.io/upload_images/9163368-5c5d1cd20b6c8509.gif?imageMogr2/auto-orient/strip) |
| 固定宽度             |![固定宽度.gif](https://upload-images.jianshu.io/upload_images/9163368-7d730925c56b7200.gif?imageMogr2/auto-orient/strip)  |
| 图文              |![带图片.gif](https://upload-images.jianshu.io/upload_images/9163368-383d923b19d3e1c4.gif?imageMogr2/auto-orient/strip) |
|固定右边              |![](https://upload-images.jianshu.io/upload_images/9163368-7daf3d6d8092d256.gif?imageMogr2/auto-orient/strip)|
|嵌套              |![嵌套.gif](https://upload-images.jianshu.io/upload_images/9163368-e6981080bae7c68c.gif?imageMogr2/auto-orient/strip)|
|自定义标题样式              |![自定义标题样式.gif](https://upload-images.jianshu.io/upload_images/9163368-246160d93223dfe4.gif?imageMogr2/auto-orient/strip)|

### 悬浮样式
| 悬浮样式                | 作用   (默认值)                                 |
|-----------------------|-----------------------------------------------------|
| 悬浮导航栏透明度不变化+刷新在中间              |  ![悬浮导航栏透明度不变化.gif](https://upload-images.jianshu.io/upload_images/9163368-c816c09bfe3919c9.gif?imageMogr2/auto-orient/strip) |
| 悬浮导航栏透明度变化+刷新在顶部               |![悬浮导航栏透明度变化+刷新在顶部.gif](https://upload-images.jianshu.io/upload_images/9163368-13ae25b5672ab495.gif?imageMogr2/auto-orient/strip)|
| 自定义复杂嵌套悬浮UI            |![自定义复杂嵌套悬浮UI.gif](https://upload-images.jianshu.io/upload_images/9163368-face20117ca38861.gif?imageMogr2/auto-orient/strip) |

### 特殊使用
| 样式                | 作用   (默认值)                                 |
|-----------------------|-----------------------------------------------------|
| 作为tabbar使用              | ![tabbar.gif](https://upload-images.jianshu.io/upload_images/9163368-c3d9cb4339d6082a.gif?imageMogr2/auto-orient/strip) |
| 淘宝首页效果           | ![taobao.gif](https://upload-images.jianshu.io/upload_images/9163368-ef84ae02f9d8bebf.gif?imageMogr2/auto-orient/strip)|
| 美团外卖商家详情效果(子控制器多级联动)           |![meituan.gif](https://upload-images.jianshu.io/upload_images/9163368-caec9456b1383756.gif?imageMogr2/auto-orient/strip) |

特性
==============
- 链式语法 结构优雅
- 支持顶部悬浮
- 支持自定义头部视图
- 支持多种指示器样式
- 支持富文本标题
- 支持图文混合标题
- 支持完整的生命周期
- 替换系统UIPageController的方案,减少内存,避免UIPageController的bug
- 支持ios13暗黑模式
- 支持固定最右边标题
- 支持自定义菜单标题
- 支持子控制器多个滚动视图联动

用法
==============

### 默认模式

     WMZPageParam *param = PageParam()
    .wTitleArrSet(@[@"推荐",@"LOOK直播",@"画",@"现场",@"翻唱",@"MV",@"广场",@"游戏"])
    .wControllersSet(@[[Test new],[Test new],[Test new],[Test new],[Test new],[Test new],[Test new],[Test new]]);
     WMZPageController *VC =  [WMZPageController new];
     VC.param = param;
    [vc.navigationController pushViewController:VC animated:YES];


### 爱奇艺
	
     param.wTitleArrSet(data)
      .wControllersSet(vcArr)
      .wMenuTitleFontSet(17)
      .wMenuTitleWeightSet(50)
      .wMenuTitleColorSet(PageColor(0xeeeeee))
      .wMenuTitleSelectColorSet(PageColor(0xffffff))
      .wMenuIndicatorColorSet(PageColor(0x00dea3))
      .wMenuIndicatorWidthSet(10.0f)
      .wMenuFixRightDataSet(@"≡")
      .wMenuAnimalTitleGradientSet(NO)
      .wTopSuspensionSet(YES)
      .wMenuAnimalSet(PageTitleMenuAiQY);
    
    //数据源
    data = @[
    @{
       @"name":@"推荐",
       @"backgroundColor":@[PageColor(0x15314b),PageColor(0x009a93)]},
    @{
       @"name":@"家务男",
       @"backgroundColor":PageColor(0xffdfa2),
       @"indicatorColor":PageColor(0x9b4f2d),
       @"titleSelectColor":PageColor(0x9b4f2d),
       @"titleColor":PageColor(0xd79869)
    },
    @{
       @"name":@"70年",
       @"titleColor":PageColor(0xffaa68),
       @"backgroundColor":PageColor(0xd70022),
       @"indicatorColor":PageColor(0xfffcc6),
       @"titleSelectColor":PageColor(0xfffcc6)
     },
     @{
       @"name":@"VIP",
       @"backgroundColor":PageColor(0x3d4659),
       @"titleSelectColor":PageColor(0xe2c285),
       @"indicatorColor":PageColor(0xe2c285),
       @"titleColor":PageColor(0x9297a5)
     },
     @{@"name":@"热点",@"backgroundColor":@[PageColor(0x15314b),PageColor(0x009a93)]},
     @{@"name":@"电视剧",@"backgroundColor":@[PageColor(0x15314b),PageColor(0x009a93)]},
     @{@"name":@"电影",@"backgroundColor":PageColor(0x007e80)},
     @{@"name":@"儿童",@"backgroundColor":@[PageColor(0x15314b),PageColor(0x009a93)]},
     @{@"name":@"游戏",@"backgroundColor":PageColor(0x1c2c3b)},
    ];
}


      
    
### 京东

       param.wTitleArrSet(data)
       .wControllersSet(vcArr)
       .wMenuTitleSelectColorSet(PageColor(0xFFFBF0))
       .wMenuBgColorSet(PageColor(0xff183b))
       .wMenuTitleColorSet(PageColor(0xffffff))
       .wMenuAnimalTitleGradientSet(NO)
       .wMenuIndicatorImageSet(@"E")
       .wMenuIndicatorHeightSet(15)
       .wMenuIndicatorWidthSet(20)
       .wMenuCellPaddingSet(40)
       .wMenuAnimalSet(PageTitleMenuLine);
       
       //数据源
       data = @[
         @"推荐",
         @{@"image":@"F"},
         @"榜单",
         @"5G",
         @"抽奖",
         @"新时代",
         @{@"image":@"F",@"selectImage":@"D"},
         @"电竞",
         @"明星"]
         
###  悬浮 (需实现WMZPageProtocol协议返回可滚动的视图)
       param.wTitleArrSet(data)
       .wControllersSet(vcArr)
        //悬浮开启
       .wTopSuspensionSet(YES)
        //导航栏透明度变化
       .wNaviAlphaSet(YES)
        //头视图y坐标从0开始
       .wFromNaviSet(NO)
        //头部
       .wMenuHeadViewSet(^UIView *{
            UIView *back = [UIView new];
            back.backgroundColor = [UIColor whiteColor];
            back.frame = CGRectMake(0, 0, PageVCWidth, 70+PageVCStatusBarHeight);
            UISearchBar *bar = [UISearchBar new];
            bar.tag = 999;
            bar.barTintColor = [UIColor whiteColor];
            bar.backgroundColor = [UIColor whiteColor];
            bar.searchBarStyle = UISearchBarStyleMinimal;
            bar.searchTextField.textAlignment = NSTextAlignmentCenter;
            bar.placeholder = @"请搜索";
            bar.frame = CGRectMake(10, PageVCStatusBarHeight, PageVCWidth-20, 70);
            [back addSubview:bar];
            return back;
       });
       
    
###  暗黑模式 传入的color用宏 PageDarkColor(PageColor(0x333333), PageColor(0xffffff))#####   第一个是正常的颜色 第二个是暗黑模式下的颜色

     
    

### 可配置的全部参数说明
      //标题数组 必传
      wTitleArr
      
      //VC数组 必传
      wControllers
      
      //能否滑动切换 default YES
      wScrollCanTransfer
      
      //特殊属性 菜单滑动到顶部悬浮 default NO
      wTopSuspension
      
      //导航栏透明度变化 default NO
      wNaviAlpha
      
      //头部视图frame从导航栏下方开始 default YES
      wFromNavi
      
      //菜单最右边固定内容是否开启左边阴影 defaulf YES
      wMenuFixShadow
      
      //选中变大 default yes
      wMenuAnimalTitleBig
      
      //开启渐变色 default yes
      wMenuAnimalTitleGradient
      
      //默认选中 default 0
      wMenuDefaultIndex
      
      //菜单最右边固定内容 default nil
      wMenuFixRightData
      
      //菜单最右边固定内容宽度 defaulf 45
      wMenuFixWidth
      
      //菜单标题动画效果 default  PageTitleMenuMove
      wMenuAnimal
      
      //头部视图 default nil
      wMenuHeadView
      
      //菜单宽度 default 屏幕宽度
      wMenuWidth
      
      //菜单背景颜色 default ffffff
      wMenuBgColor
      
      //菜单按钮的左右间距 default 20
      wMenuCellMargin
      
      //菜单按钮的上下间距 default 20 (可根据此属性改变导航栏的高度)
      wMenuCellPadding
      
      //菜单的位置 default PageMenuPositionLeft
      wMenuPosition
      
      //菜单标题左右间距 default 0
      wMenuTitleOffset
      
      //菜单标题字体 default 15.0f
      wMenuTitleFont
      
      //菜单标题固定宽度 default 文本内容宽度+wMenuCellMargin
      wMenuTitleWidth
      
      //菜单标题字体粗体 default 0
      wMenuTitleWeight
      
      //菜单字体颜色 default 333333
      wMenuTitleColor
      
      //菜单字体选中颜色 default E5193E
      wMenuTitleSelectColor
      
      //菜单图文位置 default PageBtnPositionTop
      wMenuImagePosition
      
      //菜单图文位置间距 default 5
      wMenuImageMargin
      
      //指示器颜色 default E5193E
      wMenuIndicatorColor
      
      //指示器宽度 default 标题宽度+10
      wMenuIndicatorWidth
      
      //指示器图片 default nil
      wMenuIndicatorImage
      
      //指示器高度 default k1px
      wMenuIndicatorHeight
      
      //指示器圆角 default 0
      wMenuIndicatorRadio
      
      //初始化
      WMZPageParam * PageParam(void);
      
      //右边固定标题点击
      wEventFixedClick
      
      //标题点击
      wEventClick
      
      //控制器开始切换
      wEventBeganTransferController
      
      //控制器结束切换
      wEventEndTransferController
      
      //子控制器滚动(做滚动时候自己的操作)  =>开启悬浮有效
      wEventChildVCDidSroll
      
### 传入菜单数据说明

      普通
      @[@"推荐",@"LOOK直播",@"画",@"现场",@"翻唱",@"MV",@"广场",@"游戏"];
      
      换行 
      @[@"推荐\n10",@"LOOK直播\n100",@"画\n1000",@"现场\n6",@"翻唱\n4",@"MV\n好看的MV",@"广场\n4",@"游戏\n30"]
      
      带红点普通标题 badge红点
      @[
        @{@"name":@"推荐",@"badge":@(YES)},
        @"LOOK直播",
        @"画",
        @"现场",
        @{@"name":@"翻唱",@"badge":@(YES)},
        @"MV",
        @"广场",
        @{@"name":@"游戏",@"badge":@(YES)},
     ];
     
     带富文本  wrapColor第二行标题  firstColor第一行标题 
     @[
        @{@"name":@"推荐\n10",@"wrapColor":[UIColor brownColor]},
        @"LOOK直播\n10",
        @{@"name":@"画\n10",@"badge":@(YES),@"wrapColor":[UIColor purpleColor]},
        @"现场\n10",
        @{@"name":@"翻唱\n10",@"wrapColor":[UIColor blueColor],@"firstColor":[UIColor cyanColor]},
        @"MV\n10",
        @"MV\n10",
        @{@"name":@"游戏\n10",@"badge":@(YES),@"wrapColor":[UIColor yellowColor]},
    ];
    
    图片  image图片  selectImage选中图片
    @[
        @{@"name":@"推荐",@"image":@"B",@"selectImage":@"D"},
        @{@"name":@"LOOK直播",@"image":@"C",@"selectImage":@"D"},
        @{@"name":@"画",@"image":@"B",@"selectImage":@"D"},
        @{@"name":@"现场",@"image":@"C",@"selectImage":@"D"},
        @{@"name":@"翻唱",@"image":@"B",@"selectImage":@"D"},
        @{@"name":@"MV",@"image":@"C",@"selectImage":@"D"},
        @{@"name":@"游戏",@"badge":@(YES),@"image":@"B",@"selectImage":@"D"},
        @{@"name":@"广场",@"image":@"C",@"selectImage":@"D"},
    ];
    
    /*爱奇艺标题
    (滚动完改变颜色)
    indicatorColor 指示器颜色
    titleSelectColor 选中字体颜色
    titleColor 未选中字体颜色
    backgroundColor 选中背景颜色 (如果是数组则是背景色渐变色)
    */
    {
    return @[
    @{
       @"name":@"推荐",
       @"backgroundColor":@[PageColor(0x15314b),PageColor(0x009a93)]},
    @{
       @"name":@"家务男",
       @"backgroundColor":PageColor(0xffdfa2),
       @"indicatorColor":PageColor(0x9b4f2d),
       @"titleSelectColor":PageColor(0x9b4f2d),
       @"titleColor":PageColor(0xd79869)
    },
    @{
       @"name":@"70年",
       @"titleColor":PageColor(0xffaa68),
       @"backgroundColor":PageColor(0xd70022),
       @"indicatorColor":PageColor(0xfffcc6),
       @"titleSelectColor":PageColor(0xfffcc6)
     },
     @{
       @"name":@"VIP",
       @"backgroundColor":PageColor(0x3d4659),
       @"titleSelectColor":PageColor(0xe2c285),
       @"indicatorColor":PageColor(0xe2c285),
       @"titleColor":PageColor(0x9297a5)
     },
     @{@"name":@"热点",@"backgroundColor":@[PageColor(0x15314b),PageColor(0x009a93)]},
     @{@"name":@"电视剧",@"backgroundColor":@[PageColor(0x15314b),PageColor(0x009a93)]},
     @{@"name":@"电影",@"backgroundColor":PageColor(0x007e80)},
     @{@"name":@"儿童",@"backgroundColor":@[PageColor(0x15314b),PageColor(0x009a93)]},
     @{@"name":@"游戏",@"backgroundColor":PageColor(0x1c2c3b)},
    ];
### 详情看demo    

###  更新 改变wTitleArr和wControllers后直接调用实例方法即可
     /*
     *更新(全部重新渲染)
     */
     - (void)updatePageController;
     
     /*
     *更新头部
     */
     - (void)updateHeadView;

     /*
     *手动调用菜单到第index个
     */
     - (void)selectMenuWithIndex:(NSInteger)index;
     
     /*
     *底部手动滚动  传入CGPointZero则为吸顶临界点
     */
     - (void)downScrollViewSetOffset:(CGPoint)point animated:(BOOL)animat;

### 依赖
无任何依赖 

安装
==============

### CocoaPods
1. 将 cocoapods 更新至最新版本.
2. 在 Podfile 中添加 `pod 'WMZPageController'`。
3. 执行 `pod install` 或 `pod update`。
4. 导入 #import "WMZPageController.h"。

### 注:要消除链式编程的警告 
要在Buildding Settings 把CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF 设为NO

### 手动安装

1. 下载 WMZPageController 文件夹内的所有内容。
2. 将 WMZPageController 内的源文件添加(拖放)到你的工程。
3. 导入 #import "WMZPageController.h"

系统要求
==============
该库最低支持 `iOS 9.0` 和 `Xcode 9.0`。



许可证
==============
LEETheme 使用 MIT 许可证，详情见 [LICENSE](LICENSE) 文件。


个人主页
==============
使用过程中如果有什么bug欢迎给我提issue 我看到就会解决
[我的简书](https://www.jianshu.com/p/32e997b74d74)
ios问题交流群 937909825(有问题加群哈)

更新日记
==============
- 20191104 更新cocopod到1.0.1版本 修复一些问题
- 20191207 更新cocopod到1.0.3版本 修复悬浮问题
- 20191209 更新cocopod到1.0.4版本 修复bug
- 20191213 更新cocopod到1.0.5版本 增加demo说明 新增自定义菜单接口
- 20191213 更新cocopod到1.1.0版本 建议更新 新增可添加tableviewCell功能
- 20200104 更新cocopod到1.1.1版本 修复bug
- 20200107 更新cocopod到1.1.3版本 修复bug 新增可固定底部
- 20200202 更新cocopod到1.1.4版本 修复bug 
- 20200202 新增wFixFirst属性 固定在所有控制器的底部的尾视图
- 20200328 修复设置导航栏translant和tabbar设置translant的布局问题 更新至1.1.5
- 20200409 修复偏移问题 更新至1.1.6
- 20200424 修复细节问题 更新至1.1.7
- 20200511 修复bug 更新至1.1.8
- 20200605 新增自定义红点和特殊样式1 更新至1.1.9
- 20200726 新增淘宝分页效果/美团商家分页效果 更新至1.2.0
