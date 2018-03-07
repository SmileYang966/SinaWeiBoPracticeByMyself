//
//  NewFeaturesIntroductionsViewController.m
//  微博项目
//
//  Created by Evan Yang on 03/03/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "NewFeaturesIntroductionsViewController.h"
#import "WeiBoTabBarController.h"

#define NEWFEATURECOUNT 4

@interface NewFeaturesIntroductionsViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView *newFeatureScrollView;

@property(nonatomic,strong) UIPageControl *pageControl;

@end

@implementation NewFeaturesIntroductionsViewController

- (UIScrollView *)newFeatureScrollView{
    if (_newFeatureScrollView == NULL) {
        _newFeatureScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _newFeatureScrollView.contentSize = CGSizeMake(self.view.bounds.size.width*4,0);
        _newFeatureScrollView.bounces = NO;
        _newFeatureScrollView.delegate = self;
        _newFeatureScrollView.pagingEnabled = YES;
        [self.view addSubview:_newFeatureScrollView];
    }
    return _newFeatureScrollView;
}

- (UIPageControl *)pageControl{
    if (_pageControl == NULL) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,0,150, 40)];
        _pageControl.numberOfPages = 4;
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        CGFloat centerY = self.newFeatureScrollView.height - _pageControl.height;
        _pageControl.center = CGPointMake(self.newFeatureScrollView.center.x, centerY);
        [self.view addSubview:_pageControl];
    }
    return _pageControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    for (int i=0; i<NEWFEATURECOUNT; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x+width*i, y,width,height)];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d",i+1]];
        [self.newFeatureScrollView addSubview:imgView];
        
        //在最后一张imageView上加上一个checkBox的Button以及Label
        //这个下面再添加一个“开始微博”的button
        if (i==NEWFEATURECOUNT-1) {
            //建立一个button
            imgView.userInteractionEnabled = YES;
            
            UIButton *checkBoxBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
            checkBoxBtn.x = (imgView.width - checkBoxBtn.width)*0.5;
            checkBoxBtn.y = imgView.height * 0.7;
            [checkBoxBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
            [checkBoxBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
            checkBoxBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
            [checkBoxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [checkBoxBtn setTitle:@"分享到朋友圈" forState:UIControlStateNormal];
            checkBoxBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            [imgView addSubview:checkBoxBtn];
            [checkBoxBtn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            UIImage *startButtonBg = [UIImage imageNamed:@"new_feature_finish_button"];
            UIImage *startButtonBgHighlighted = [UIImage imageNamed:@"new_feature_finish_button_highlighted"];
            UIButton *startBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 105, 35)];
            startBtn.x = (imgView.width - startBtn.width)*0.5;
            startBtn.y = imgView.height * 0.78;
            [startBtn setBackgroundImage:startButtonBg forState:UIControlStateNormal];
            [startBtn setBackgroundImage:startButtonBgHighlighted forState:UIControlStateHighlighted];
            [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
            [startBtn addTarget:self action:@selector(startWeiBo:) forControlEvents:UIControlEventTouchUpInside];
            [imgView addSubview:startBtn];
        }
    }
    [self.view addSubview:self.pageControl];
}

-(void)checkBtnClicked:(UIButton *)checkBoxBtn{
    checkBoxBtn.selected = !checkBoxBtn.selected;
}

-(void)startWeiBo:(UIButton *)startWeiBoBtn{
    WeiBoTabBarController *tabBarController = [[WeiBoTabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarController;
}

/*
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    CGPoint point = *targetContentOffset;
    NSLog(@"point=%@",NSStringFromCGPoint(point));
    self.pageControl.currentPage = (NSInteger)(point.x/self.newFeatureScrollView.width);
}*/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat percent = self.newFeatureScrollView.contentOffset.x / self.newFeatureScrollView.width;
    
    NSLog(@"percent=%f,进位%f",percent,roundf(percent));
    
    self.pageControl.currentPage = (NSInteger)(roundf(percent));
}

- (void)dealloc{
    SCLog(@"销毁了NewFeaturesIntroductionsViewController");
}

@end
