//
//  ViewController.m
//  RentCalendar
//
//  Created by guide_sun on 16/6/12.
//  Copyright © 2016年 Guide_sun. All rights reserved.
//

#import "ViewController.h"
#import "CalendarView.h"
//当前设备的屏幕宽度
#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
//当前设备的屏幕高度
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
@interface ViewController ()
@property (nonatomic, strong) CalendarView *calendarView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.calendarView];
    [_calendarView setSelectDate:^(NSArray *liveInDate,NSArray *leaveDate){
//        NSInteger monthApart = [leaveDate[1] integerValue] - [liveInDate[1] integerValue];
//        NSInteger dayApart = [leaveDate[2] integerValue] - [liveInDate[2] integerValue];
        NSLog(@"liveInDate== %@ ,leaveDate ==%@",liveInDate,leaveDate);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CalendarView *)calendarView{
    if (!_calendarView) {
        _calendarView = [[CalendarView alloc]init];
        _calendarView.frame = CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-40);
    }
    return _calendarView;
}
@end
