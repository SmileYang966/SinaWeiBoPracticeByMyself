//
//  SinaStatus.m
//  微博项目
//
//  Created by Evan Yang on 15/04/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "SinaUser.h"

@implementation SinaUser

- (instancetype)initWithDict:(NSDictionary *)dict{
    SinaUser *user = [[SinaUser alloc]init];
    user.name = dict[@"name"];
    user.profile_image_url = dict[@"profile_image_url"];
    user.idstr = dict[@"idstr"];
    user.memberRank = (int)dict[@"mbrank"];
    user.memberType = (int)dict[@"mbtype"];
    return user;
}

//这个方法只会在字典转模型的时候调用一次，避免重复的多次调用
- (void)setMemberType:(int)memberType{
    _memberType = memberType;
    self.vip = memberType > 2;
}

@end
