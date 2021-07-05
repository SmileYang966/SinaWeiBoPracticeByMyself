//
//  NSString+Extension.m
//  微博项目
//
//  Created by Evan Yang on 03/06/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

-(CGSize)getSizeByFont:(UIFont *)font{
    NSDictionary *dict = @{NSFontAttributeName : font};
    CGSize size = [self sizeWithAttributes:dict];
    return size;
}

-(CGSize)getSizeByFont:(UIFont *)font constraintWidth:(CGFloat)maxWidth{
    NSDictionary *dict = @{NSFontAttributeName : font};
    CGSize apprepriateSize = CGSizeMake(maxWidth, MAXFLOAT);
    return [self boundingRectWithSize:apprepriateSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}


@end
