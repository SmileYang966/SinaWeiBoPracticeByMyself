//
//  AppDelegate.m
//  微博项目
//
//  Created by Evan Yang on 23/01/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "AppDelegate.h"
#import "WeiBoTabBarController.h"
#import "NewFeaturesIntroductionsViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //需要先判断，显示新特性还是显示微博的WeiBoTabBarController
    NSString *key = @"CFBundleVersion";
    
    //获取当前的Version
     NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    //获取上一次从存储在沙盒中的version
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if (![currentVersion isEqualToString:lastVersion]) {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NewFeaturesIntroductionsViewController *newFeature = [[NewFeaturesIntroductionsViewController alloc]init];
        self.window.rootViewController = newFeature;
    }else{
         WeiBoTabBarController *tabBarController = [[WeiBoTabBarController alloc]init];
         self.window.rootViewController = tabBarController;
    }
    
    [self.window makeKeyWindow];
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
