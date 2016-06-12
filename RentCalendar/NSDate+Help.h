//
//  NSDate+Help.h
//  iKanReader
//
//  Created by liutian liutian on 12-4-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(Help)

- (NSUInteger)getDay;

- (NSUInteger)getMonth;

- (NSUInteger)getYear;

- (int )getHour;

- (int)getMinute;
+(NSString *)strToDate:(NSDate*)date;

+(NSDate*)dateToStr:(NSString*)string ;

+(NSDate *)strToShortDate:(NSString *)string;

+(NSString*)dateToShortStr:(NSDate*)date;

//json 毫秒返回 格式化的时间点
+(NSString *)timeIntervalToString:(NSString *)timeInterval;

+(NSString *)stringToDate:(NSDate*)date;
+(NSString *)timestampConversionWithLong:(long)timeInterval;
+(NSString *)timestampConversionWithInt:(long)timeInterval;
+(NSString *)getCurrentTime;
+(int)getTheCountdown:(NSString *)time;
//时间戳转化时间
+(NSString *)timestampConversion:(NSString *)timeInterval;
+(NSString *)timeConversion:(NSString *)timeInterval;
+(NSString *)conversationTimeStamp:(NSString *)timeInterval;
//时间差
+(NSString *)timeDifference:(NSString *)endTime;
/**
 *  判断某个时间是否为今天
 */
+ (BOOL)isToday:(NSDate *)date;
/**
 *  比较两个时间
 *
 *  @param oldTime
 *
 *  @return
 */
+ (BOOL)compareTime:(NSString *)oldTime;
@end
