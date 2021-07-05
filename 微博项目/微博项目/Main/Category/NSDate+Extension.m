//
//  NSDate+Extension.m
//  微博项目
//
//  Created by Evan Yang on 03/06/2018.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**判断一个给定的日期是否为今年*/
-(BOOL)isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //得到给定日期的的年信息
    NSDateComponents *createDateComponent = [calendar components:NSCalendarUnitYear fromDate:self];
    //得到当前时刻的年信息
    NSDateComponents *currentDateComponent = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return createDateComponent.year == currentDateComponent.year;
}

/**判断一个给定的日期是否为昨天*/
-(BOOL)isYesterday{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd";
    //转换成"年-月-日"这种格式
    NSString *createDateStr = [format stringFromDate:self];
    NSString *currentDateStr = [format stringFromDate:[NSDate date]];
    
    NSDate *createDateValue = [format dateFromString:createDateStr];
    NSDate *currentDateValue = [format dateFromString:currentDateStr];
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *compoents = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:createDateValue toDate:currentDateValue options:0];
    
    return compoents.year==0 && compoents.month==0 && compoents.day==1;
}

/**是否为今天*/
-(BOOL)isToday{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd";
    NSString *createDateStr = [format stringFromDate:self];
    NSString *currentDateStr = [format stringFromDate:[NSDate date]];
    
    return  [createDateStr isEqualToString:currentDateStr];
}

@end
