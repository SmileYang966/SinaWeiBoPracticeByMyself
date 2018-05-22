//
//  SinaWeiBoFrame.m
//  微博项目
//
//  Created by Evan Yang on 08/05/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "SinaWeiBoFrame.h"
#import "SinaStatus.h"
#import "SinaUser.h"
#import "SinaStatus.h"

#define IWSinaWeiBoCellBorderW 10
#define IWSinaWeiBoCellBorderH 10


@implementation SinaWeiBoFrame

- (void)setSinaStatus:(SinaStatus *)sinaStatus{
    _sinaStatus = sinaStatus;
    
    SinaUser *user = sinaStatus.user;
    
    //头像
    CGFloat iconWH = 50;
    CGFloat iconX = IWSinaWeiBoCellBorderW;
    CGFloat iconY = IWSinaWeiBoCellBorderH;
    self.iconImgViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    //用户昵称
    CGSize nameSize = [self getSizeByStringAndFont:user.name font:IWSinaWeiBoNameFont];
    CGFloat nameX = CGRectGetMaxX(self.iconImgViewF) + IWSinaWeiBoCellBorderW;
    CGFloat nameY = IWSinaWeiBoCellBorderH;
    self.sendNameLabelF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    //会员图标
    if (user.vip) {
        CGFloat vipIconWH = 10;
        CGFloat vipIconX = CGRectGetMaxX(self.sendNameLabelF) + IWSinaWeiBoCellBorderW;
        CGFloat vipIconY = IWSinaWeiBoCellBorderH;
        self.vipImgViewF = CGRectMake(vipIconX, vipIconY,vipIconWH , vipIconWH);
    }
    
    //发送时间
    CGFloat sendTimeX = nameX;
    CGFloat sendTimeY = CGRectGetMaxY(self.sendNameLabelF) + IWSinaWeiBoCellBorderH;
    CGSize sendTimeSize = [self getSizeByStringAndFont:sinaStatus.created_at font:IWSinaWeiBoNameFont];
    self.sendTimeLabelF = CGRectMake(sendTimeX, sendTimeY, sendTimeSize.width, sendTimeSize.height);
    
    //来自于
    CGFloat sourceX = CGRectGetMaxX(self.sendTimeLabelF) + IWSinaWeiBoCellBorderW;
    CGFloat sourceY = sendTimeY;
    CGSize sourceSize = [self getSizeByStringAndFont:sinaStatus.source font:IWSinaWeiBoNameFont];
    self.shareFromLabelF = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    
    //微博正文
    CGFloat contextX = IWSinaWeiBoCellBorderW;
    CGFloat contextY = MAX(CGRectGetMaxY(self.iconImgViewF), CGRectGetMaxY(self.sendNameLabelF)) + IWSinaWeiBoCellBorderH;
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 2 * IWSinaWeiBoCellBorderW;
    CGSize contentSize = [self getSizeByStringAndFont:sinaStatus.text font:IWSinaWeiBoContentFont constraintSize:maxWidth];
    self.contentLabelF = CGRectMake(contextX, contextY, contentSize.width, contentSize.height);
    
    //设置photoView
    if (sinaStatus.pic_urls.count>0) {
        CGFloat photoViewX = IWSinaWeiBoCellBorderW;
        CGFloat photoViewY = CGRectGetMaxY(self.contentLabelF);
        CGFloat photoViewWidth = 100;
        CGFloat photoViewHeight = 100;
        self.photoViewF = CGRectMake(photoViewX, photoViewY, photoViewWidth, photoViewHeight);
    }
    
    //原创微博整体
    //计算出原创微博整体
    CGFloat originalViewX = 0;
    CGFloat originalViewY = 0;
    CGFloat originalViewWidth = [UIScreen mainScreen].bounds.size.width;
    //计算原创微博图片的高度，需要考虑有没有配图这种情况
    CGFloat originalViewHeight = CGRectGetMaxY(self.contentLabelF) + self.photoViewF.size.height;
    self.originalViewF = CGRectMake(originalViewX, originalViewY, originalViewWidth, originalViewHeight);
    
    if (sinaStatus.retweeted_status) {
        
        SinaStatus *retweedSinaStatus = sinaStatus.retweeted_status;
        SinaUser *retweedSinaUser = retweedSinaStatus.user;
        
        /**被转发微博的Frame*/
        
        
        /**被转发微博的正文的frame*/
        CGFloat retweetedContextX = IWSinaWeiBoCellBorderW;
        CGFloat retweetedContextY = IWSinaWeiBoCellBorderH;
        
        NSString *contextString = [NSString stringWithFormat:@"%@ : %@",retweedSinaUser.name,retweedSinaStatus.text];
        CGSize retweetedContextSize = [self getSizeByStringAndFont:contextString font:IWSinaWeiBoContentFont constraintSize:maxWidth];
        self.retweetedWeiBoContentF = CGRectMake(retweetedContextX, retweetedContextY, retweetedContextSize.width, retweetedContextSize.height);
        
        /**被转发微博的配图的frame*/
        if (retweedSinaStatus.pic_urls.count) {
            CGFloat retweetedWeiBoPictureX = IWSinaWeiBoCellBorderW;
            CGFloat retweetedWeiBoPictureY = CGRectGetMaxY(self.retweetedWeiBoContentF) + IWSinaWeiBoCellBorderH;
            CGFloat retweetedWeiBoPictureW = 100;
            CGFloat retweetedWeiBoPictureH = 100;
            
            self.retweetedWeiBoPictureF = CGRectMake(retweetedWeiBoPictureX, retweetedWeiBoPictureY, retweetedWeiBoPictureW, retweetedWeiBoPictureH);
        }
        
        /**被转发微博整体*/
        CGFloat retweetedWeiBoX = 0;
        CGFloat retweetedWeiBoY = CGRectGetMaxY(self.originalViewF) + IWSinaWeiBoCellBorderH;
        CGFloat retweetedWeiBoWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat retweetedWeiBoHeight = retweedSinaStatus.pic_urls.count > 0 ? (CGRectGetMaxY(self.retweetedWeiBoPictureF) + IWSinaWeiBoCellBorderH) :
        (CGRectGetMaxY(self.retweetedWeiBoContentF) + IWSinaWeiBoCellBorderH);
        self.retweetedWeiBoF = CGRectMake(retweetedWeiBoX,retweetedWeiBoY,retweetedWeiBoWidth,retweetedWeiBoHeight);
        
        //设置高度
        self.cellHeight = CGRectGetMaxY(self.retweetedWeiBoF);
    }else{
        
        //设置高度
        self.cellHeight = CGRectGetMaxY(self.originalViewF);
    }
    

}

-(CGSize)getSizeByStringAndFont:(NSString *)str font:(UIFont *) font{
    NSDictionary *dict = @{NSFontAttributeName : font};
    CGSize size = [str sizeWithAttributes:dict];
    return size;
}

-(CGSize)getSizeByStringAndFont:(NSString *)str font:(UIFont *)font constraintSize:(CGFloat)maxWidth{
    NSDictionary *dict = @{NSFontAttributeName : font};
    
    CGSize apprepriateSize = CGSizeMake(maxWidth, MAXFLOAT);
    return [str boundingRectWithSize:apprepriateSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}

@end
