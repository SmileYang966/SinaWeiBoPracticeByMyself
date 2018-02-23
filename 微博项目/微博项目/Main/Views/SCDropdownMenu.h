//
//  SCDropdownMenu.h
//  微博项目
//
//  Created by Evan Yang on 10/02/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCDropdownMenu : UIView

+(instancetype)menu;
-(void)showFrom:(UIView *)fromView;

@property(nonatomic,strong) UIView *content;
@property(nonatomic,strong) UIViewController *vc;

@end
