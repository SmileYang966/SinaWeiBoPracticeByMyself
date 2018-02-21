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
        _containerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 217, 200)];
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

-(void)show{
    //2.添加自己到窗口上
    [self.lastWindow addSubview:self];
    
    //3.设置尺寸
    self.frame = self.lastWindow.bounds;
}

- (void)setContent:(UIView *)content{
    _content = content;
    
    //根据content的实际大小来确定这个containerView的实际大小
    content.x = 5;
    content.y = 10;
    content.width = self.containerView.width-2*content.x;
    self.containerView.height = CGRectGetMaxY(content.frame) + 10;
    [self.containerView addSubview:content];
}

- (void)setVc:(UIViewController *)vc{
    _vc = vc;
    
    self.content = vc.view;
}

@end
