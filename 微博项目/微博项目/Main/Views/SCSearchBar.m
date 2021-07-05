//
//  SCSearchBar.m
//  微博项目
//
//  Created by Evan Yang on 01/02/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "SCSearchBar.h"

@implementation SCSearchBar

+(instancetype)searchBar{
    
    UITextField *txtField = [[UITextField alloc]init];
    //需要去拉伸图片，直接使用它为背景very ugly
    UIImage *img = [UIImage imageNamed:@"searchbar_textfield_background"];
    UIImage *bgImg = [img stretchableImageWithLeftCapWidth:img.size.width*0.5 topCapHeight:img.size.height*0.5];
    txtField.background = bgImg;
    txtField.borderStyle = UITextBorderStyleNone;
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    imgView.contentMode = UIViewContentModeCenter;
    imgView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
    txtField.leftView = imgView;
    txtField.leftViewMode = UITextFieldViewModeAlways;
    
    return txtField;
}

@end
