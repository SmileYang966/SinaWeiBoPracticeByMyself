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
#import "OAuthViewController.h"
#import "SCAccount.h"
#import "SCAccountManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*
   NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *accountPath = [docPath stringByAppendingPathComponent:@"account.plist"];
    SCAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:accountPath];
    */
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyWindow];
    
    //通过SCAccountManager这个类去管理账户，这边只负责去取这个account，若取不到，则需要进入相应的授权页面
    //重新授权
    SCAccount *account =  [SCAccountManager account];
    
    if (account) {
        [UIWindow switchedRootViewController];
    }else{
        self.window.rootViewController = [[OAuthViewController alloc]init];
    }
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
