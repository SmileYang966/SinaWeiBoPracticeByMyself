//
//  SinaStatus.m
//  微博项目
//
//  Created by Evan Yang on 15/04/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "SinaStatus.h"
#import "SinaUser.h"
#import "SinaPhoto.h"
#import "MJExtension.h"

@implementation SinaStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [SinaPhoto class]};
}


//下面这个用不到了，因为在用了"MJExtension.h"方法后，就不需要自己做字典转模型了
-(instancetype)initWithDict:(NSDictionary *)dict{
    SinaStatus *status = [[SinaStatus alloc]init];
    
    status.text = dict[@"text"];
    status.idstr = dict[@"idstr"];
    status.created_at = dict[@"created_at"];
    status.source = dict[@"source"];
    
    /*数组对象里每个元素其实又是一个模型对象*/
    /*
    NSMutableArray *arrayM = [NSMutableArray array];
    NSArray *array = dict[@"pic_urls"];
    for (int i=0; i<array.count; i++) {
        SinaPhoto *photo = [[SinaPhoto alloc]init];
        photo.thumbnail_pic = array[i][@"thumbnail_pic"];
        [arrayM addObject:photo];
    }
     status.pictures = arrayM;
     */
    
    /*
     * 这里是有一个数组对象在SinaStatus里的，但这个数组里应该存储所有的SinaPhoto对象.
     * 而服务器穿过来的其实是一个字典数组，所以需要遍历字典数组，将每个字典转化成SinaPhoto模型对象
     */
    status.pic_urls = [[SinaPhoto alloc]photoesWithDictArray:dict[@"pic_urls"]];
    
    /*Get the user model*/
    SinaUser *user = [[SinaUser alloc]initWithDict:dict[@"user"]];
    status.user = user;
    
    /**Get the retweetWeiBo model*/
//    status.retweetWeiBo = [[SinaStatus alloc]initWithDict:dict[@"retweeted_status"]];
    
    return status;
}

@end
