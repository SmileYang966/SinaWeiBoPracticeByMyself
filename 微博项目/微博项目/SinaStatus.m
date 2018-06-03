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

/*需要对微博的原始数据进行修改，自然而然想到的方式是，对于网络上得到的创建时间，将它转化成需要的时间格式后，再存入数据模型中
 *另一种是在数据模型对象中，重写它的get方法，因为此时在get方法中得到的时间模型，其实还是属于网络上传输过来的时间字符串
 */

//从新浪服务器得到的时间格式是
//"created_at" = "Mon May 28 20:25:10 +0800 2018"
//"created_at" = "EEE MMM dd HH:mm:ss Z yyyy"
- (NSString *)created_at{
    //新建一个NSDateFormatter类型的对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //不同的国家可能有不同的日期格式，所以需要开发者自己来指定culture
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    //将当前的日期字符串转化成fmt所定义的日期格式
    NSDate *createDate = [fmt dateFromString:_created_at];
    //当前时间
    NSDate *now = [NSDate date];
    
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    /*从创建时间减去当前时间的差值，应该都是负数
    NSTimeInterval timeInterval = [createDate timeIntervalSinceNow];
    1分钟内,1小时内,1天内，1个月内，1年内，都需要通过这种方式去check，感觉不现实
    if (-timeInterval<60) {} if (-timeInterval>60 && -timeInterval<=3600) {}
     */
    
    /*获取当前calendar对象*/
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //计算两个时间点的差值时，需要指定年，月，日，时，分，秒具体哪个字段的差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour
    | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    
    //计算相关的差值(创建时间和当前时间的差值)
    NSDateComponents *components =  [calendar components:unit fromDate:createDate toDate:now options:0];
    //计算创建时间当时的年月日时分秒 //计算当前时间的年月日时分秒
    /*
    NSDateComponents *componentsForCreateDate = [calendar components:unit fromDate:createDate];
    NSDateComponents *componentsForNow = [calendar components:unit fromDate:now];
     */
    
    if ([createDate isThisYear]) {//今年
        if ([createDate isToday]) {//今天
            if(components.hour >= 1){
                return [NSString stringWithFormat:@"%d小时前",(int)components.hour];
            }else{//小时1小时发的
                if(components.minute >=1 ){//大于1分钟发的
                    return [NSString stringWithFormat:@"%d分钟前",(int)components.minute];
                }else{//小于1分钟发的
                    return @"刚刚";
                }
            }
        }else if([createDate isYesterday]){//昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        }else{//今年除了今天、昨天的其它天
            fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            return [fmt stringFromDate:createDate];
        }
    }else{//非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        return [fmt stringFromDate:createDate];
    }
    
    return @"2017-01-02";
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
