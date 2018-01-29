//
//  TestingViewController.m
//  微博项目
//
//  Created by Evan Yang on 27/01/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "TestingViewController.h"
#import "Testing2ViewController.h"

@interface TestingViewController ()

@end

@implementation TestingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"正在测试中";
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width,20)];
    [btn setTitle:@"Go" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
}

- (void)btnClicked:(UIButton *)btn{
    Testing2ViewController *testing2VC = [[Testing2ViewController alloc]init];
    [self.navigationController pushViewController:testing2VC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
