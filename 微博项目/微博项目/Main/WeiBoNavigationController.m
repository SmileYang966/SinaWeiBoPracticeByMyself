//
//  WeiBoNavigationController.m
//  微博项目
//
//  Created by Evan Yang on 24/01/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "WeiBoNavigationController.h"

@interface WeiBoNavigationController ()

@end

@implementation WeiBoNavigationController

+ (void)initialize{
    [super initialize];
    
    //统一设置其enable 和 disable状态
    //When the right barButtonItem is enabel , show the normal attribute
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    NSDictionary *attributeDict = @{NSFontAttributeName : [UIFont systemFontOfSize:15.0],
                                    NSForegroundColorAttributeName : [UIColor orangeColor]
                                    };
    [barButtonItem setTitleTextAttributes:attributeDict forState:UIControlStateNormal];
    
    //when the right barButtonItem is disable,it will show the lightGray color and the
    // relative barButtonItem was disabled.
    NSDictionary *attributeDictDisabled = @{NSFontAttributeName : [UIFont systemFontOfSize:15.0],
                                    NSForegroundColorAttributeName : [UIColor blueColor]
                                    };
    [barButtonItem setTitleTextAttributes:attributeDictDisabled forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
 * We always use the function of "pushViewController: animated:" to catch the pushed
 * viewcontroller, that we can change the behaviors for that.
 */

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count>0) {
        /* It's better if we use the category of UIBarButtonItem , and put it in the
         pch file , that we can use it to create the appropriate instance of UIBarButtonItem.
         But the important things was that we need to also pass by value for "Target" self, because we use the the "Action" as method
         */
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonWithTarget:self Action:@selector(backBtnClicked:) Image:@"navigationbar_back" HighlightedImage:@"navigationbar_back_highlighted"];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonWithTarget:self Action:@selector(backToRootViewController:) Image:@"navigationbar_more" HighlightedImage:@"navigationbar_more_highlighted"];
        
        /*
        viewController.navigationItem.leftBarButtonItem = [self barButtonWithAction:@selector(backBtnClicked:) Image:@"navigationbar_back" HighlightedImage:@"navigationbar_back_highlighted"];
        
        viewController.navigationItem.rightBarButtonItem = [self barButtonWithAction:@selector(backToRootViewController:) Image:@"navigationbar_more" HighlightedImage:@"navigationbar_more_highlighted"];
         */
    }
    [super pushViewController:viewController animated:animated];
}

/*
-(UIBarButtonItem *)barButtonWithAction:(SEL)actioin Image:(NSString *)image HighlightedImage:(NSString *)hightlightedImage{
    
    UIButton *backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backImage = [UIImage imageNamed:image];
    UIImage *backHighlightedImage = [UIImage imageNamed:hightlightedImage];
    [backbtn setBackgroundImage:backImage forState:UIControlStateNormal];
    [backbtn setBackgroundImage:backHighlightedImage forState:UIControlStateHighlighted];
    backbtn.size = backImage.size;
    [backbtn addTarget:self action:actioin forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:backbtn];
}*/

-(void)backBtnClicked:(UIButton *)btn{
    [self popViewControllerAnimated:YES];
}

-(void)backToRootViewController:(UIButton *)btn{
    [self popToRootViewControllerAnimated:YES];
}

@end
