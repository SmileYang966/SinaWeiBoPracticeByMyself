//
//  SinaPhoto.m
//  微博项目
//
//  Created by Evan Yang on 20/05/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "SinaPhoto.h"

@implementation SinaPhoto

+(instancetype)initWithDict:(NSDictionary *)dict{
    SinaPhoto *photo = [[SinaPhoto alloc]init];
    photo.thumbnail_pic = dict[@"thumbnail_pic"];
    return photo;
}

-(NSArray *)photoesWithDictArray:(NSArray *)dictArray{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i=0; i<dictArray.count; i++) {
        SinaPhoto *photo = [SinaPhoto initWithDict:dictArray[i]];
        [arrayM addObject:photo];
    }
    return arrayM;
}

@end
