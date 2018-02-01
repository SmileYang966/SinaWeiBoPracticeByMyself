//
//  DiscoverViewController.m
//  微博项目
//
//  Created by Evan Yang on 23/01/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "DiscoverViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITextField *txtField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.view.size.width-20, 30)];
    //需要去拉伸图片，直接使用它为背景very ugly
    UIImage *img = [UIImage imageNamed:@"searchbar_textfield_background"];
    UIImage *bgImg = [img stretchableImageWithLeftCapWidth:img.size.width*0.5 topCapHeight:img.size.height*0.5];
    txtField.background = bgImg;
    txtField.borderStyle = UITextBorderStyleNone;
    self.navigationItem.titleView = txtField;
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    imgView.contentMode = UIViewContentModeCenter;
    imgView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
    txtField.leftView = imgView;
    txtField.leftViewMode = UITextFieldViewModeAlways;
}

@end
