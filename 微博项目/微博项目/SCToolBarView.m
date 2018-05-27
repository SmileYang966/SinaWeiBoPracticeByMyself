//
//  SCToolBarView.m
//  微博项目
//
//  Created by Evan Yang on 26/05/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "SCToolBarView.h"

@interface SCToolBarView()
@property(nonatomic,strong) NSMutableArray *btnArrayM;
@property(nonatomic,strong) NSMutableArray *divideLineArray;
@end


@implementation SCToolBarView

+(instancetype) toolBarView{
    return [[self alloc]init];
}

/*在init阶段重写initWithFrame方法，这个阶段就创建了三个button*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //添加buttons
        [self setUpButtons];
        
        //添加分割线
        [self setUpDivideLine];
    }
    return self;
}

-(void)setUpButtons{
    //添加3个button，分别是转发按钮、评论按钮以及点赞按钮
    UIButton *forwardBtn = [self addButtonWithTitle:@"转发" iconName:@"timeline_icon_retweet"];
    UIButton *commentBtn = [self addButtonWithTitle:@"评论" iconName:@"timeline_icon_comment"];
    UIButton *zanBtn = [self addButtonWithTitle:@"赞" iconName:@"timeline_icon_unlike"];
    
    [self addSubview:forwardBtn];
    [self addSubview:commentBtn];
    [self addSubview:zanBtn];
    
    self.btnArrayM = [NSMutableArray array];
    [self.btnArrayM addObjectsFromArray:@[forwardBtn,commentBtn,zanBtn]];
}

-(void)setUpDivideLine{
    self.divideLineArray = [NSMutableArray array];
    for (int i=0; i<2; i++) {
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
        [self addSubview:imgView];
        [self.divideLineArray addObject:imgView];
    }
}


-(UIButton *)addButtonWithTitle:(NSString *)title iconName:(NSString *)iconName{
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    
    NSDictionary *attributeDict = @{
                                    NSFontAttributeName : [UIFont systemFontOfSize:12.0f]
                                    };
    NSAttributedString *attributeStr = [[NSAttributedString alloc]initWithString:title attributes:attributeDict];
    [btn setAttributedTitle:attributeStr forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    return btn;
}

/*layoutSubViews阶段去遍历所有的ToolBar，并且设置相应的frame,一般情况下只有在
 *对这个toolBar的frame进行赋值的时候，会重写调用layoutSubviews这个方法
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat divideLineWidth = 1;
    CGFloat divideLineHeight = self.height;
    CGFloat divideLineX = 0;
    CGFloat divideLineY = 0;
    
    CGFloat btnWidth = (self.width - 2 * divideLineWidth) / 3;
    CGFloat btnHeight = self.height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    
    CGFloat width = self.width / 3;
    
    //设置每个toolBar的frame
    int toolBtnIndex = 0;
    for (UIButton *btn in self.btnArrayM) {
        btnX = toolBtnIndex * width;
        toolBtnIndex++;
        btn.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
    }
    
    //设置每个divideLine的frame
    int divideLineIndex = 0;
    for (UIImageView *divideImgView in self.divideLineArray) {
        divideLineIndex++;
        divideLineX = (width * divideLineIndex)-divideLineWidth;
        divideImgView.frame = CGRectMake(divideLineX, divideLineY, divideLineWidth, divideLineHeight);
    }
}

@end
