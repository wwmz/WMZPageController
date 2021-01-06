//
//  AppDelegate.m
//  WMZPageController
//
//  Created by wmz on 2019/9/17.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeVC.h"
#import "WMZPageCustomNaviVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    UITabBarController *ta = [UITabBarController new];
    
    UINavigationController *na1 = [[UINavigationController alloc]initWithRootViewController:[HomeVC new]];
    na1.tabBarItem.title = @"页面";
    UINavigationController *na3 = [[UINavigationController alloc]initWithRootViewController:[HomeVC new]];
    na3.tabBarItem.title = @"页面";
    ta.viewControllers = @[na1,[WMZPageCustomNaviVC new],na3];
    ta.view.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = ta;
//    [UITabBar appearance].translucent = NO;
//    [UINavigationBar appearance].translucent = NO;
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
