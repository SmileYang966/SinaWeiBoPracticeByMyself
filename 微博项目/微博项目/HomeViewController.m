//
//  HomeViewController.m
//  微博项目
//
//  Created by Evan Yang on 23/01/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "HomeViewController.h"
#import "SCDropdownMenu.h"
#import "HomeDropMenuTableViewController.h"

@interface HomeViewController ()<SCDropDownMenuDelegate>

@property(nonatomic,strong)UIButton *titleBtn;

@end

@implementation HomeViewController

- (UIButton *)titleBtn{
    if (_titleBtn == NULL) {
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.width = 100;
        NSDictionary *fontAttr = @{NSFontAttributeName : [UIFont systemFontOfSize:17.0]};
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"首页" attributes:fontAttr];
        [titleBtn setAttributedTitle:attrStr forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        [titleBtn addTarget:self action:@selector(titleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 55, 0, 0);
        titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
        _titleBtn = titleBtn;
    }
    return _titleBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonWithTarget:self Action:@selector(leftBarButtonItemClicked:) Image:@"navigationbar_friendsearch" HighlightedImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonWithTarget:self Action:@selector(rightBarButtonItemClicked:) Image:@"navigationbar_pop" HighlightedImage:@"navigationbar_pop_highlighted"];
    
    self.navigationItem.titleView = self.titleBtn;
    
    UIButton *randomBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 30)];
    randomBtn.backgroundColor = [UIColor redColor];
    [randomBtn setTitle:@"Test" forState:UIControlStateNormal];
    [randomBtn addTarget:self action:@selector(randomBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:randomBtn];
}

- (void)randomBtnClicked:(UIButton *)btn
{
    SCDropdownMenu *dropDownMenu1 = [SCDropdownMenu menu];
    HomeDropMenuTableViewController *dropMenuTableVC = [[HomeDropMenuTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    dropMenuTableVC.view.height = 100;
    dropMenuTableVC.view.width = 200;
    dropDownMenu1.vc = dropMenuTableVC;
    [dropDownMenu1 showFrom:btn];
}

//另外这里非常重要的一个知识点就是关于对图片的拉伸技术，
//请到Assets.xcassets目录中去找到其对应的popover_background图片，然后对它的属性进行设置
//Assets.xcassets -> find popover_background image -> Slicing -> Slices -> Vertical
//这张图片我们只能垂直方向拉伸，因为水平方向是不规则的，一旦拉伸，原来的图片形状就变了
//记住一个要点：做拉伸操作，只能对规则的那个方向(垂直还是水平)进行拉伸
-(void)titleBtnClicked:(UIButton *)btn{
    /*
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
     */
    SCDropdownMenu *dropDownMenu1 = [SCDropdownMenu menu];
    [self dropdownMenuDidShow:dropDownMenu1];
    dropDownMenu1.delegate = self;
    HomeDropMenuTableViewController *dropMenuTableVC = [[HomeDropMenuTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    dropMenuTableVC.view.height = 200;
    dropMenuTableVC.view.width = 130;
    dropDownMenu1.vc = dropMenuTableVC;
    [dropDownMenu1 showFrom:btn];
}

-(void)dropdownMenuDidShow:(SCDropdownMenu *)menu{
    self.titleBtn.selected = YES;
}

- (void)dropDownMenuDidDismiss:(SCDropdownMenu *)menu{
//    [self.titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    self.titleBtn.selected = NO;
}

- (void)leftBarButtonItemClicked:(UIBarButtonItem *)item{
}

- (void)rightBarButtonItemClicked:(UIBarButtonItem *)item{
}

@end
