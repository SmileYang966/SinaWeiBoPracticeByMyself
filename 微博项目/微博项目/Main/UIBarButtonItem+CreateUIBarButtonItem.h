//
//  UIBarButtonItem+CreateUIBarButtonItem.h
//  微博项目
//
//  Created by Evan Yang on 29/01/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CreateUIBarButtonItem)

+(UIBarButtonItem *)barButtonWithAction:(SEL)actioin Image:(NSString *)image HighlightedImage:(NSString *)hightlightedImage;

@end
