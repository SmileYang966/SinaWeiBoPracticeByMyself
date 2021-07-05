//
//  SinaStatus.h
//  微博项目
//
//  Created by Evan Yang on 15/04/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SinaUser : NSObject

@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *profile_image_url;
@property(nonatomic,copy) NSString *idstr;
@property(nonatomic,assign) int memberRank;
@property(nonatomic,assign) int memberType;
@property(nonatomic,assign) BOOL vip;

-(instancetype)initWithDict:(NSDictionary *)dict;

@end
