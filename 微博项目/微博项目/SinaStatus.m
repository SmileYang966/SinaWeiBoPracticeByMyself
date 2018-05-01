//
//  SinaStatus.m
//  微博项目
//
//  Created by Evan Yang on 15/04/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "SinaStatus.h"
#import "SinaUser.h"

@implementation SinaStatus

-(instancetype)initWithDict:(NSDictionary *)dict{
    SinaStatus *status = [[SinaStatus alloc]init];
    
    status.text = dict[@"text"];
    status.idstr = dict[@"idstr"];
    SinaUser *user = [[SinaUser alloc]initWithDict:dict[@"user"]];
    status.user = user;
    
    return status;
}

@end
