//
//  CalendarView.h
//  KuaiYouJia
//
//  Created by guide_sun on 16/5/9.
//  Copyright © 2016年 KuaiYouJia. All rights reserved.
//
///日历
#import <UIKit/UIKit.h>
typedef void (^chooseDate)(NSArray *liveInDate , NSArray * leaveDate);
@interface CalendarView : UIView
@property (nonatomic, copy) chooseDate selectDate;

@property (nonatomic, strong) NSMutableArray *selectDateArr;
@property (nonatomic, assign) BOOL isPublishHouse;
/**
 *  确定
 *
 *  @param rentDate 租住日期
 */
- (void)confirmDate:(chooseDate)rentDate;

@end

