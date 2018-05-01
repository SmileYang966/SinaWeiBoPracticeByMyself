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

@property(nonatomic,copy) NSString *text;
@property(nonatomic,copy) NSString *idstr;
@property(nonatomic,strong) SinaUser *user;

-(instancetype)initWithDict:(NSDictionary *)dict;

@end
