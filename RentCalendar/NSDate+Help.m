//
//  NSDate+Help.m
//  iKanReader
//
//  Created by liutian liutian on 12-4-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



#import "NSDate+Help.h"


@implementation NSDate(Help)

//获取日
- (NSUInteger)getDay{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:self];
	return [dayComponents day];
}
//获取月
- (NSUInteger)getMonth
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:self];
	return [dayComponents month];
}
//获取年
- (NSUInteger)getYear
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:self];
	return [dayComponents year];
}

//获取小时
- (int )getHour {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSUInteger unitFlags =NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
	NSDateComponents *components = [calendar components:unitFlags fromDate:self];
	NSInteger hour = [components hour];
	return (int)hour;
}
//获取分钟
- (int)getMinute {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSUInteger unitFlags =NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
	NSDateComponents *components = [calendar components:unitFlags fromDate:self];
	NSInteger minute = [components minute];
	return (int)minute;
}

+(NSString *)timeIntervalToString:(NSString *)timeInterval
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]/1000];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateString = [df stringFromDate:date];
    return dateString;
}


/**
 *  比较两个时间
 *
 *  @param oldTime
 *
 *  @return
 */
+ (BOOL)compareTime:(NSString *)oldTime
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *createDate = [fmt dateFromString:oldTime];
    if ([self isToday:createDate]) {
        return YES;
    }
    return NO;
}
/**
 *  判断某个时间是否为今天
 */
+ (BOOL)isToday:(NSDate *)date
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:date];
    NSString *nowStr = [fmt stringFromDate:now];
    return [dateStr isEqualToString:nowStr];
}


+(NSString *)stringToDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate: date];
    return strDate;
}

+(NSString *)strToDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate: date];
    return strDate;
}

+(NSDate *)strToShortDate:(NSString *)string
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-DD HH:mm:ss SSS"];
    NSDate *date = [dateFormatter dateFromString:string];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *currentDate = [date  dateByAddingTimeInterval: interval];
    return currentDate;
    
}
+(NSString*)dateToShortStr:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate: date];
    return strDate;
}

+(NSDate*)dateToStr:(NSString*)string 
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss SSS"];
    NSDate *date = [dateFormatter dateFromString:string];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *currentDate = [date  dateByAddingTimeInterval: interval];  
    return currentDate;
}



+(NSString *)getCurrentTime{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *currentTime = [dateFormatter stringFromDate:today];
    return currentTime;
}

+(NSString *)timestampConversionWithLong:(long)timeInterval{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval /1000];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy年MM月dd日HH时mm分ss秒";
    NSString *dateString = [df stringFromDate:date];

    return dateString;
}
+(NSString *)timestampConversionWithInt:(long)timeInterval{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval /1000];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateString = [df stringFromDate:date];
    
    return dateString;
}
+(NSString *)timestampConversion:(NSString *)timeInterval{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]/1000];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy年MM月dd日HH时mm分ss秒";
    NSString *dateString = [df stringFromDate:date];
   
    return dateString;
}

+(NSString *)conversationTimeStamp:(NSString *)timeInterval{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]/1000];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateString = [df stringFromDate:date];
    return dateString;
}

+(NSString *)timeConversion:(NSString *)timeInterval{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]/1000];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"dd日HH小时mm分ss秒";
    NSString *dateString = [df stringFromDate:date];
    
    return dateString;
}




+(NSString *)timeDifference:(NSString *)endTime{
    NSRange range = [endTime rangeOfString:@"年"];
    range.location= 0;
    range.length = 4;
    NSString *year = [endTime substringWithRange:range];
    
    NSRange range_month = [endTime rangeOfString:@"月"];
    range_month.location= range.length+1;
    range_month.length = 2;
    NSString *month = [endTime substringWithRange:range_month];
    
    NSRange range_day = [endTime rangeOfString:@"日"];
    range_day.location=range_month.location+3;
    range_day.length=2;
    NSString *day = [endTime substringWithRange:range_day];
    
    NSRange range_hour = [endTime rangeOfString:@"时"];
    range_hour.location =range_day.location+3;
    range_hour.length=2;
    NSString *hour = [endTime substringWithRange:range_hour];
    
    NSRange range_minute = [endTime rangeOfString:@"分"];
    range_minute.location =range_hour.location+3;
    range_minute.length=2;
    NSString *minute = [endTime substringWithRange:range_minute];
    
    NSRange range_second = [endTime rangeOfString:@"秒"];
    range_second.location =range_minute.location+3;
    range_second.length=2;
    NSString *second = [endTime substringWithRange:range_second];
    
    NSCalendar *cal = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    NSDateComponents *time = [[NSDateComponents alloc] init];    //初始化目标时间...奥运时间好了
    [time setYear:[year intValue]];
    [time setMonth:[month intValue]];
    [time setDay:[day intValue]];
    [time setHour:[hour intValue]];
    [time setMinute:[minute intValue]];
    [time setSecond:[second intValue]];
    NSDate *todate = [cal dateFromComponents:time]; //把目标时间装载入date
    NSDate *today = [NSDate date];    //得到当前时间
    //用来得到具体的时差
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:todate options:0];
    NSString *dateTime = [NSString stringWithFormat:@"%ld年%ld月%ld日%ld时%ld分%ld秒",(long)[d year],(long)[d month], (long)[d day], (long)[d hour], (long)[d minute], (long)[d second]];
    return dateTime;
}
+(int)getTheCountdown:(NSString *)time{
    NSRange range = [time rangeOfString:@"年"];
    range.location= 0;
    range.length = 4;
    //NSString *year = [time substringWithRange:range];
    
    NSRange range_month = [time rangeOfString:@"月"];
    range_month.location= range.length+1;
    range_month.length = 2;
   // NSString *month = [time substringWithRange:range_month];
    
    NSRange range_day = [time rangeOfString:@"日"];
    range_day.location=range_month.location+3;
    range_day.length=2;
    NSString *day = [time substringWithRange:range_day];
    
    NSRange range_hour = [time rangeOfString:@"时"];
    range_hour.location =range_day.location+3;
    range_hour.length=2;
    NSString *hour = [time substringWithRange:range_hour];
    
    NSRange range_minute = [time rangeOfString:@"分"];
    range_minute.location =range_hour.location+3;
    range_minute.length=2;
    NSString *minute = [time substringWithRange:range_minute];
    
    NSRange range_second = [time rangeOfString:@"秒"];
    range_second.location =range_minute.location+3;
    range_second.length=2;
    NSString *second = [time substringWithRange:range_second];
    int day_int = [day intValue];
    int hour_int = [hour intValue];
    int minute_int = [minute intValue];
    int second_int = [second intValue];
    
    return day_int*86400+hour_int*3600+minute_int*60+second_int;
}
@end
