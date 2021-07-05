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
    
    /** Tested Data : used to test the count which more than the 10000
    sinaStatus.comments_count = 123656;
    sinaStatus.reposts_count = 2343732;
    sinaStatus.attitudes_count = 43325532;
     */
    
    //设置评论数
    NSString *commentBtnTitle;
    if (!sinaStatus.comments_count) {
        commentBtnTitle = @"评论";
    }else{
        if (sinaStatus.comments_count>10000) {
            /* 下面这种计算小数的方法是我自己写的，但其实没必要，因为ios在NSString里已经有了很好的封装
             commentBtnTitle = [self calculatedStatisticValue:sinaStatus.comments_count];
            */
            /**这种方式用来保存一位小数是最简单的方法，之前一直不知道，反而用了上面那种很复杂的方法*/
            double wan = sinaStatus.comments_count / 10000.0;
            commentBtnTitle = [NSString stringWithFormat:@"%.1f万",wan];
        }else{
            commentBtnTitle = [NSString stringWithFormat:@" %d",sinaStatus.comments_count];
        }
    }
    [self setValuesWithButton:self.commentBtn title:commentBtnTitle iconName:@"timeline_icon_retweet"];
    

    //设置转发数
    NSString *forwradBtnTitle;
    if (!sinaStatus.reposts_count) {
        forwradBtnTitle = @"转发";
    }else{
        if (sinaStatus.reposts_count>10000) {
            double wan = sinaStatus.reposts_count / 10000.0;
            forwradBtnTitle = [NSString stringWithFormat:@"%.1f万",wan];
        }else{
            forwradBtnTitle = [NSString stringWithFormat:@" %d",sinaStatus.reposts_count];
        }
    }
    [self setValuesWithButton:self.forwardBtn title:forwradBtnTitle iconName:@"timeline_icon_comment"];
    
    //设置点赞数
    NSString *attitudeBtnTitle;
    if (!sinaStatus.attitudes_count) {
        attitudeBtnTitle = @"赞";
    }else{
        if (sinaStatus.attitudes_count>10000) {
            double wan = sinaStatus.attitudes_count / 10000.0;
            attitudeBtnTitle = [NSString stringWithFormat:@"%.1f万",wan];
        }else{
            attitudeBtnTitle = [NSString stringWithFormat:@" %d",sinaStatus.attitudes_count];
        }
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

/**当统计数目大于1万时，只需写笼统的数据,例如1.3万、12.5万
 * 现在发现根本上用不着自己写这个方法，因为NSString关于format已经有了很好的封装
 */
-(NSString *)calculatedStatisticValue:(int)statisticValue{
    if (statisticValue>10000) {
        int tempIntValue = statisticValue / 10000;
        int decimal = statisticValue % 10000;
        int FourthBitValue = decimal / 1000;
        int ThirdBitValue = decimal % 1000 / 100;
        if (ThirdBitValue >=5) {
            FourthBitValue++;
        }
        return [NSString stringWithFormat:@"%d.%d万",tempIntValue,FourthBitValue];
    }
    return @"";
}

@end
