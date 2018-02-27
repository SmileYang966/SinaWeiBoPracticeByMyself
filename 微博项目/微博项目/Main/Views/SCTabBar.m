//
//  SCTabBar.m
//  微博项目
//
//  Created by Evan Yang on 27/02/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "SCTabBar.h"

@interface SCTabBar()
@property(nonatomic,strong) UIButton *plusButton;
@end

@implementation SCTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *plusBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 64, 44)];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
//        plusBtn.center = CGPointMake(self.width*0.5, self.height*0.5);
        [plusBtn addTarget:self action:@selector(plusBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusButton = plusBtn;
    }
    return self;
}

- (void)plusBtnClicked:(SCTabBar *)tabBar{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickedPlusButton:)]) {
        [self.delegate tabBarDidClickedPlusButton:self];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat tabBarItemWidth = self.width / 5;
    CGFloat tabBarItemHeight = self.height;
    CGFloat tabBarItemX = 0;
    CGFloat tabBarItemY = 0;
    int i = 0;
    for (UIView *subView in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([subView isKindOfClass:class]) {
//            subView.backgroundColor = [UIColor blueColor];
            SCLog(@"subView=%@",subView);
            tabBarItemX = tabBarItemWidth * i;
            subView.frame = CGRectMake(tabBarItemX, tabBarItemY, tabBarItemWidth, tabBarItemHeight);
            i++;
        }
        if (i==2) {
            self.plusButton.x = tabBarItemWidth * i;
            i++;
        }
    }
}

@end
