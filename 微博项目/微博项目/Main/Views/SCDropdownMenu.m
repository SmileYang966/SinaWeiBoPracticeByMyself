//
//  SCDropdownMenu.m
//  微博项目
//
//  Created by Evan Yang on 10/02/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "SCDropdownMenu.h"

@interface SCDropdownMenu()

@property(nonatomic,strong) UIImageView *containerView;
@property(nonatomic,strong) UIWindow *lastWindow;

@end

@implementation SCDropdownMenu

- (UIImageView *)containerView{
    if (_containerView == NULL) {
        _containerView = [[UIImageView alloc]init];
        _containerView.image = [UIImage imageNamed:@"popover_background"];
        _containerView.center = CGPointMake(self.lastWindow.center.x, 164);
        _containerView.userInteractionEnabled = true;
        [self addSubview:_containerView];
    }
    return _containerView;
}

- (UIWindow *)lastWindow{
    if (_lastWindow == NULL) {
        _lastWindow = [[UIApplication sharedApplication].windows lastObject];
    }
    return _lastWindow;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self containerView];
    }
    return self;
}


+(instancetype)menu{
    return [[self alloc]init];
}

-(void)showFrom:(UIView *)fromView{
    //2.添加自己到窗口上
    [self.lastWindow addSubview:self];
    
    //3.设置尺寸
    self.frame = self.lastWindow.bounds;
    
    //需要设置self.containerView的frame,但是因为这里的fromView相对的是HomeViewController的view为
    //参照物，但是我们要在这个fromView下面加上一个self.containerView就需要认定它是相对于当前window
    //这个坐标系,所以需要进行坐标的转换
    CGRect rect = [fromView convertRect:fromView.bounds toView:self.lastWindow];
    CGFloat maxY = CGRectGetMaxY(rect);
    CGFloat middleX = CGRectGetMidX(rect);
    self.containerView.y = maxY;
    self.containerView.centerX = middleX;
}

- (void)dismiss{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDidDismiss:)]) {
        [self.delegate dropDownMenuDidDismiss:self];
    }
}

- (void)setContent:(UIView *)content{
    _content = content;
    
    //根据content的实际大小来确定这个containerView的实际大小
    content.x = 5;
    content.y = 10;
    self.containerView.height = CGRectGetMaxY(content.frame) + 10;
    self.containerView.width = content.width + 2*content.x;
    NSLog(@"height=%f,width=%f",self.containerView.height,self.containerView.width);
    [self.containerView addSubview:content];
}

- (void)setVc:(UIViewController *)vc{
    _vc = vc;
    self.content = vc.view;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}

@end
