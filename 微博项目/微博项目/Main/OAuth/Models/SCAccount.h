//
//  SCAccount.h
//  微博项目
//
//  Created by Evan Yang on 17/03/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCAccount : NSObject<NSCoding>

@property(nonatomic,copy) NSString *access_token;
@property(nonatomic,copy) NSNumber *expiredIn;
@property(nonatomic,copy) NSString *uid;
@property(nonatomic,copy) NSDate *storeDate;
@property(nonatomic,copy) NSString *name;

+(instancetype)accountWithDict:(NSDictionary *)dict;

@end
