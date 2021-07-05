//
//  SCAccountManager.m
//  微博项目
//
//  Created by Evan Yang on 03/04/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "SCAccountManager.h"
#import "SCAccount.h"

#define ACCOUNTPATH     [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject] stringByAppendingString:@"account.plist"]

@implementation SCAccountManager

+(void)saveAccount:(SCAccount *)account{
    /*
    NSDate *currentDate = [NSDate date];
    account.storeDate = currentDate;
    */
    [NSKeyedArchiver archiveRootObject:account toFile:ACCOUNTPATH];
}

+(SCAccount *)account{
    
    SCAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:ACCOUNTPATH];
    
    //有一种scenario，当前的account有可能会过期
    //1.Get到存储的日期
    NSDate *storeDate = account.storeDate;
    
    //2.Get到当前的日期
    NSDate *currentDate = [NSDate date];
    
    //3.Get到expired的时间长，是NSNumber类型的
    long long expiredTime = [account.expiredIn longLongValue];
    
    NSDate *expiredDate = [storeDate dateByAddingTimeInterval:expiredTime];
    if (!([currentDate compare:expiredDate] == kCFCompareLessThan))
        return  nil;
    
    return account;
}

@end
