//
//  SinaStatus.m
//  微博项目
//
//  Created by Evan Yang on 15/04/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "SinaUser.h"

@implementation SinaUser

-(instancetype)initWithDict:(NSDictionary *)dict{
    SinaUser *user = [[SinaUser alloc]init];
    user.name = dict[@"name"];
    user.profile_image_url = dict[@"profile_image_url"];
    user.idstr = dict[@"idstr"];
    return user;
}

@end
