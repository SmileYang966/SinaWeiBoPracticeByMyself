//
//  NSString+Extension.h
//  微博项目
//
//  Created by Evan Yang on 03/06/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

-(CGSize)getSizeByFont:(UIFont *)font;
-(CGSize)getSizeByFont:(UIFont *)font constraintWidth:(CGFloat)maxWidth;

@end
