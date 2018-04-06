//
//  SCAccountManager.h
//  微博项目
//
//  Created by Evan Yang on 03/04/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SCAccount;

@interface SCAccountManager : NSObject

+(void)saveAccount:(SCAccount *)account;

+(SCAccount *)account;

@end
