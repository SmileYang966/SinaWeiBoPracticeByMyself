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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count>1) {
        viewController.navigationItem.leftBarButtonItem = [self barButtonWithAction:@selector(backBtnClicked:) Image:@"navigationbar_back" HighlightedImage:@"navigationbar_back_highlighted"];
        
        viewController.navigationItem.rightBarButtonItem = [self barButtonWithAction:@selector(backToRootViewController:) Image:@"navigationbar_more" HighlightedImage:@"navigationbar_more_highlighted"];
    }
}

-(UIBarButtonItem *)barButtonWithAction:(SEL)actioin Image:(NSString *)image HighlightedImage:(NSString *)hightlightedImage{
    
    UIButton *backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backImage = [UIImage imageNamed:image];
    UIImage *backHighlightedImage = [UIImage imageNamed:hightlightedImage];
    [backbtn setBackgroundImage:backImage forState:UIControlStateNormal];
    [backbtn setBackgroundImage:backHighlightedImage forState:UIControlStateHighlighted];
    backbtn.size = backImage.size;
    [backbtn addTarget:self action:actioin forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:backbtn];
}

-(void)backBtnClicked:(UIButton *)btn{
    [self popViewControllerAnimated:YES];
}

-(void)backToRootViewController:(UIButton *)btn{
    [self popToRootViewControllerAnimated:YES];
}

@end
