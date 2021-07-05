//
//  UIWindow+Extension.m
//  微博项目
//
//  Created by Evan Yang on 06/04/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "NewFeaturesIntroductionsViewController.h"
#import "WeiBoTabBarController.h"

@implementation UIWindow (Extension)

+(void)switchedRootViewController{
    NSString *key = @"CFBundleVersion";
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    //其实不太明白这里为什么要获取的是keyWindow
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if (![currentVersion isEqualToString:lastVersion]) {
        //显示新特性
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:currentVersion forKey:key];
        [userDefault synchronize];
        
        NewFeaturesIntroductionsViewController *newFeature = [[NewFeaturesIntroductionsViewController alloc]init];
        window.rootViewController = newFeature;
    }else{
        //显示主tabBarController
        WeiBoTabBarController *tabBarController = [[WeiBoTabBarController alloc]init];
        window.rootViewController = tabBarController;
    }
}

@end
