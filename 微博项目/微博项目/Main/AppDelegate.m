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

#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*
   NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *accountPath = [docPath stringByAppendingPathComponent:@"account.plist"];
    SCAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:accountPath];
    */
    
    // 使用本地通知 (本例中只是badge，但是还有alert和sound都属于通知类型,其实如果只进行未读数在appIcon显示,只需要badge就可, 这里全写上为了方便以后的使用)
    // 需要继续深入研究
    UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    
    [notificationCenter requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
    }];
    
    
    /*
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        // 进行注册
    [application registerUserNotificationSettings:settings];
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
    
    /*app的状态*/
    /*
     *1.死亡状态
     *2.前台运行状态
     *3.后台暂停状态,停止一切多媒体、定时器、动画、联网操作
     *4.后台运行状态
     */
    //向操作系统申请后台运行资格，能维持多久是不确定的
    UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        //说明系统想在后台结束这个程序时(由于cpu、内存紧张的缘故)，需要关闭该程序
        [application endBackgroundTask:task];
        
        //伪造当前后台运行的程序时0kb的MP3程序
        
    }];
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
