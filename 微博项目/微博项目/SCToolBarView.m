//
//  SCToolBarView.m
//  微博项目
//
//  Created by Evan Yang on 26/05/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "SCToolBarView.h"
#import "SinaStatus.h"

@interface SCToolBarView()
@property(nonatomic,strong) NSMutableArray *btnArrayM;
@property(nonatomic,strong) NSMutableArray *divideLineArray;

@property(nonatomic,strong) UIButton *forwardBtn;
@property(nonatomic,strong) UIButton *commentBtn;
@property(nonatomic,strong) UIButton *attitudeBtn;

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
    
    self.forwardBtn = [[UIButton alloc]init];
    [self addSubview:self.forwardBtn];
    
    self.commentBtn = [[UIButton alloc]init];
    [self addSubview:self.commentBtn];
    
    self.attitudeBtn = [[UIButton alloc]init];
    [self addSubview:self.attitudeBtn];
    
    self.btnArrayM = [NSMutableArray array];
    [self.btnArrayM addObjectsFromArray:@[self.forwardBtn,self.commentBtn,self.attitudeBtn]];
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

- (void)setSinaStatus:(SinaStatus *)sinaStatus{
    _sinaStatus = sinaStatus;
    
    //设置评论数
    NSString *commentBtnTitle;
    if (!sinaStatus.comments_count) {
        commentBtnTitle = @"评论";
    }else{
        commentBtnTitle = [NSString stringWithFormat:@" %d",sinaStatus.comments_count];
    }
    [self setValuesWithButton:self.commentBtn title:commentBtnTitle iconName:@"timeline_icon_retweet"];
    

    //设置转发数
    NSString *forwradBtnTitle;
    if (!sinaStatus.reposts_count) {
        forwradBtnTitle = @"转发";
    }else{
        forwradBtnTitle = [NSString stringWithFormat:@" %d",sinaStatus.reposts_count];
    }
    [self setValuesWithButton:self.forwardBtn title:forwradBtnTitle iconName:@"timeline_icon_comment"];
    
    //设置点赞数
    NSString *attitudeBtnTitle;
    if (!sinaStatus.attitudes_count) {
        attitudeBtnTitle = @"赞";
    }else{
        attitudeBtnTitle = [NSString stringWithFormat:@" %d",sinaStatus.attitudes_count];
    }
    [self setValuesWithButton:self.attitudeBtn title:attitudeBtnTitle iconName:@"timeline_icon_unlike"];
}

-(void)setValuesWithButton:(UIButton *)button title:(NSString *)title iconName:(NSString *)iconName{
    [button setTitle:title forState:UIControlStateNormal];
    NSDictionary *attributeDict = @{
                                    NSFontAttributeName : [UIFont systemFontOfSize:12.0f]
                                    };
    NSAttributedString *attributeStr = [[NSAttributedString alloc]initWithString:title attributes:attributeDict];
    [button setAttributedTitle:attributeStr forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
}

@end
