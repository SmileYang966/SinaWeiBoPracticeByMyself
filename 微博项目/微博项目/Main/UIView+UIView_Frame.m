//
//  UIView+UIView_Frame.m
//  微博项目
//
//  Created by Evan Yang on 29/01/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "UIView+UIView_Frame.h"

@implementation UIView (UIView_Frame)

- (void)setX:(CGFloat)x{
    CGRect changedFrame = self.frame;
    changedFrame.origin.x = x;
    self.frame = changedFrame;
}

- (void)setY:(CGFloat)y{
    CGRect changedFrame = self.frame;
    changedFrame.origin.y = y;
    self.frame = changedFrame;
}

- (void)setWidth:(CGFloat)width{
    CGRect changedFrame = self.frame;
    changedFrame.size.width = width;
    self.frame = changedFrame;
}

- (void)setHeight:(CGFloat)height{
    CGRect changedFrame = self.frame;
    changedFrame.size.height = height;
    self.frame = changedFrame;
}

- (void)setSize:(CGSize)size{
    CGRect changedFrame = self.frame;
    changedFrame.size = size;
    self.frame = changedFrame;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect changedFrame = self.frame;
    changedFrame.origin = origin;
    self.frame = changedFrame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (CGSize)size{
    return self.frame.size;
}

- (CGPoint)origin{
    return self.frame.origin;
}

@end
