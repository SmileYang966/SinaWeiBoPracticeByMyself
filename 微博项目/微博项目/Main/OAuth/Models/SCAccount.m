//
//  SCAccount.m
//  微博项目
//
//  Created by Evan Yang on 17/03/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "SCAccount.h"

@implementation SCAccount

/*
"access_token" = "2.00QiHNPETdnTXC3e779b6921wW3H7D";
"expires_in" = 157679999;
isRealName = true;
"remind_in" = 157679999;
uid = 3889304284;
*/
+(instancetype)accountWithDict:(NSDictionary *)dict{
    SCAccount *account = [[SCAccount alloc]init];
    account.access_token = dict[@"access_token"];
    account.expiredIn = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    /*以下这行代码记录了存储account的时间*/
    account.storeDate = [NSDate date];
    return account;
}

/*编码器，在把对象通过NSKeyedArchiver的方式写入到文件时，必须先指明这个对象中哪些属性是需要
 *写入到这个文件中的
 */
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expiredIn forKey:@"expires_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.storeDate forKey:@"storeDate"];
    [encoder encodeObject:self.name forKey:@"name"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expiredIn = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.storeDate = [aDecoder decodeObjectForKey:@"storeDate"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
