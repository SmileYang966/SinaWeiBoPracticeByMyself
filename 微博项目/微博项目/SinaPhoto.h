//
//  SinaPhoto.h
//  微博项目
//
//  Created by Evan Yang on 20/05/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SinaPhoto : NSObject

@property(nonatomic,copy) NSString *thumbnail_pic;

+(instancetype)initWithDict:(NSDictionary *)dict;

-(NSArray *)photoesWithDictArray:(NSArray *)dictArray;

@end
