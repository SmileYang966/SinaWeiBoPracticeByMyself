//
//  SCTabBar.h
//  微博项目
//
//  Created by Evan Yang on 27/02/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCTabBar;

@protocol SCTabBarDelegate<UITabBarDelegate>
@optional
-(void)tabBarDidClickedPlusButton:(SCTabBar *)tabBar;
@end

@interface SCTabBar : UITabBar

@property(nonatomic,weak) id<SCTabBarDelegate> delegate;

@end
