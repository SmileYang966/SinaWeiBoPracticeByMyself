//
//  WeiBoTabBarController.m
//  微博项目
//
//  Created by Evan Yang on 24/01/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "WeiBoTabBarController.h"
#import "HomeViewController.h"
#import "MessageCenterViewController.h"
#import "DiscoverViewController.h"
#import "ProfileViewController.h"
#import "WeiBoNavigationController.h"

#import "SCTabBar.h"

@interface WeiBoTabBarController ()<SCTabBarDelegate>

@end

@implementation WeiBoTabBarController

- (instancetype)init{
    if (self=[super init]) {
        //Home viewController
        HomeViewController *homeVC = [[HomeViewController alloc]init];
        [self addChildWithViewController:homeVC ImageName:@"tabbar_home" SelectedImageName:@"tabbar_home_selected" title:@"首页"];
        
        //Message Center ViewController
        MessageCenterViewController *messageCenterVC = [[MessageCenterViewController alloc]init];
        [self addChildWithViewController:messageCenterVC ImageName:@"tabbar_message_center" SelectedImageName:@"tabbar_message_center_selected" title:@"消息中心"];
        
        //Discover ViewController
        DiscoverViewController *discoverVC = [[DiscoverViewController alloc]init];
        [self addChildWithViewController:discoverVC ImageName:@"tabbar_discover" SelectedImageName:@"tabbar_discover_selected" title:@"发现"];
        
        //Profile ViewController
        ProfileViewController *profileVC = [[ProfileViewController alloc]init];
        [self addChildWithViewController:profileVC ImageName:@"tabbar_profile" SelectedImageName:@"tabbar_profile_selected" title:@"个人中心"];
    }
    return self;
}

- (void)addChildWithViewController:(UIViewController *)vc ImageName:(NSString *)imgName SelectedImageName:(NSString *)selectedImageName title:(NSString *)title{
    UIImage *homeImg = [UIImage imageNamed:imgName];
    UIImage *homeImgSelected = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:homeImg selectedImage:homeImgSelected];
    
    NSDictionary *attributeSelected = @{NSForegroundColorAttributeName : [UIColor orangeColor]};
    [vc.tabBarItem setTitleTextAttributes:attributeSelected forState:UIControlStateSelected];
    vc.view.backgroundColor = SCRandomColor;
    
    WeiBoNavigationController *nav = [[WeiBoNavigationController alloc]initWithRootViewController:vc];
    vc.title = title;
    [self addChildViewController:nav];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SCTabBar *scTabBar = [[SCTabBar alloc]initWithFrame:self.tabBar.bounds];
    scTabBar.delegate = self;
    [self setValue:scTabBar forKeyPath:@"tabBar"];
}

- (void)tabBarDidClickedPlusButton:(SCTabBar *)tabBar{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor redColor];
    [self presentViewController:vc animated:true completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (UIView *subView in self.tabBar.subviews) {
        NSLog(@"---subview=%@,subviews.count=%d",subView,(int)self.tabBar.subviews.count);
    }
}

@end
