//
//  SinaStatus.h
//  微博项目
//
//  Created by Evan Yang on 15/04/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SinaUser;

@interface SinaStatus : NSObject

/**微博正文*/
@property(nonatomic,copy) NSString *text;

/**微博ID号*/
@property(nonatomic,copy) NSString *idstr;

/**发布微博的用户信息*/
@property(nonatomic,strong) SinaUser *user;

/**微博创建时间*/
@property(nonatomic,copy) NSString *created_at;

/**微博来源*/
@property(nonatomic,copy) NSString *source;

/**图片来源*/
@property(nonatomic,strong) NSArray *pic_urls;

/**转发微博，其实又相当于一条微博*/
@property(nonatomic,strong) SinaStatus *retweeted_status;

/**转发数*/
@property(nonatomic,assign) int reposts_count;

/**评论数*/
@property(nonatomic,assign) int comments_count;

/**点赞数*/
@property(nonatomic,assign) int attitudes_count;

-(instancetype)initWithDict:(NSDictionary *)dict;


@end
