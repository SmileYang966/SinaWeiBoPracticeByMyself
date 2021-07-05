//
//  ProfileViewController.m
//  微博项目
//
//  Created by Evan Yang on 23/01/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(settingClicked:)];
}

//在View即将显示的时候，再设置navigationBar右边BarButtonItem为不可点击状态
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //这个item在Disabled时候就能在右边的BarButtonItem为不可点击状态下，显示其对应的属性
    self.navigationItem.rightBarButtonItem.enabled = false;
}

- (void)settingClicked:(UIBarButtonItem *)item{
    //To do in future
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
