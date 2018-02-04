//
//  HomeViewController.m
//  微博项目
//
//  Created by Evan Yang on 23/01/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonWithTarget:self Action:@selector(leftBarButtonItemClicked:) Image:@"navigationbar_friendsearch" HighlightedImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonWithTarget:self Action:@selector(rightBarButtonItemClicked:) Image:@"navigationbar_pop" HighlightedImage:@"navigationbar_pop_highlighted"];
    
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.backgroundColor = [UIColor redColor];
    NSDictionary *fontAttr = @{NSFontAttributeName : [UIFont systemFontOfSize:18.0]};
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"首页" attributes:fontAttr];
    [titleBtn setAttributedTitle:attrStr forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(titleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
}

//另外这里非常重要的一个知识点就是关于对图片的拉伸技术，
//请到Assets.xcassets目录中去找到其对应的popover_background图片，然后对它的属性进行设置
//Assets.xcassets -> find popover_background image -> Slicing -> Slices -> Vertical
//这张图片我们只能垂直方向拉伸，因为水平方向是不规则的，一旦拉伸，原来的图片形状就变了
//记住一个要点：做拉伸操作，只能对规则的那个方向(垂直还是水平)进行拉伸
-(void)titleBtnClicked:(UIButton *)btn{
    UIImageView *dropDownMenu = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 217, 200)];
    dropDownMenu.center = CGPointMake(self.view.center.x, dropDownMenu.center.y);
    dropDownMenu.image = [UIImage imageNamed:@"popover_background"];
    //如何保证我们当前的TitleBodyView始终在当前控制器的最上层
    //事实上，我们可以手动创建多个UIWindow，但如何保证我们这个DropDownMenu始终保持在最上方呢
    //这就需要用到下面的UIApplication的实例当中去取出最后一个也就是最上层的那个window
    [[[UIApplication sharedApplication].windows lastObject] addSubview:dropDownMenu];
}

- (void)leftBarButtonItemClicked:(UIBarButtonItem *)item{
}

- (void)rightBarButtonItemClicked:(UIBarButtonItem *)item{
}


@end
