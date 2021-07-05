//
//  UIBarButtonItem+CreateUIBarButtonItem.m
//  微博项目
//
//  Created by Evan Yang on 29/01/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "UIBarButtonItem+CreateUIBarButtonItem.h"

@implementation UIBarButtonItem (CreateUIBarButtonItem)

+(UIBarButtonItem *)barButtonWithTarget:(id)target Action:(SEL)actioin Image:(NSString *)image HighlightedImage:(NSString *)hightlightedImage{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backImage = [UIImage imageNamed:image];
    UIImage *backHighlightedImage = [UIImage imageNamed:hightlightedImage];
    [btn setBackgroundImage:backImage forState:UIControlStateNormal];
    [btn setBackgroundImage:backHighlightedImage forState:UIControlStateHighlighted];
    btn.size = backImage.size;
    [btn addTarget:target action:actioin forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc]initWithCustomView:btn];
}

@end
