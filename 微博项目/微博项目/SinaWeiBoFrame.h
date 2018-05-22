//
//  SinaWeiBoFrame.h
//  微博项目
//
//  Created by Evan Yang on 08/05/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IWSinaWeiBoNameFont [UIFont systemFontOfSize:10]
#define IWSinaWeiBoContentFont [UIFont systemFontOfSize:13]

@class SinaStatus;

@interface SinaWeiBoFrame : NSObject

/**设置新浪数据*/
@property(nonatomic,strong) SinaStatus *sinaStatus;
/**头像*/
@property(nonatomic,assign) CGRect iconImgViewF;
/**用户昵称*/
@property(nonatomic,assign) CGRect sendNameLabelF;
/**会员图标*/
@property(nonatomic,assign) CGRect vipImgViewF;
/**发送时间*/
@property(nonatomic,assign) CGRect sendTimeLabelF;
/**来自于*/
@property(nonatomic,assign) CGRect shareFromLabelF;
/**微博正文*/
@property(nonatomic,assign) CGRect contentLabelF;
/**配图*/
@property(nonatomic,assign) CGRect photoViewF;
/**原创微博整体*/
@property(nonatomic,assign) CGRect originalViewF;


/**设置转发微博整体*/
@property(nonatomic,assign) CGRect retweetedWeiBoF;
/**转发微博整体*/
@property(nonatomic,assign) CGRect retweetedWeiBoContentF;
/**转发微博图片*/
@property(nonatomic,assign) CGRect retweetedWeiBoPictureF;


//设置cell的高度
@property(nonatomic,assign) CGFloat cellHeight;

@end
