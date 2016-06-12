//
//  CalendarView.m
//  KuaiYouJia
//
//  Created by guide_sun on 16/5/9.
//  Copyright © 2016年 KuaiYouJia. All rights reserved.
//
//当前设备的屏幕宽度
#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
//当前设备的屏幕高度
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
//当前系统的高度比例
#define SCALE_HEIGHT   SCREEN_HEIGHT / 568
//当前系统的宽度比例
#define SCALE_WIDTH    SCREEN_WIDTH / 320

#define kRedColor         [UIColor redColor]
#define kCyanColor        [UIColor cyanColor]
#define kPurpleColor      [UIColor purpleColor]
#define kWhiteColor       [UIColor whiteColor]
#define kBlackColor       [UIColor blackColor]
#define kClearColor       [UIColor clearColor]

//非空判断 宏
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

#import "CalendarView.h"
#import "CalendarNumCell.h"
#import "CalendarHeaderResuableView.h"
#import "NSDate+Help.h"
#import "Masonry.h"
static NSString * const reuseIdentifier = @"CalendarNumCell";
static NSString * const headerIdentifier = @"headerIdentifier";

@interface CalendarView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ,strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, strong) NSDateComponents *comps;
@property (nonatomic, strong) NSCalendar *calender;
@property (nonatomic, strong) NSArray * weekdays;
@property (nonatomic, strong) NSTimeZone *timeZone;

@property (nonatomic, strong) NSArray *liveInArray;
@property (nonatomic, strong) NSArray *leaveArray;


@property (nonatomic, strong) UIButton * confirmButton;
@property (nonatomic, strong) UIButton * cancleButton;
@property (nonatomic, strong) UIView * headTitleView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@end
@implementation CalendarView

@synthesize date = newDate;
- (instancetype )init{
    self = [super init];
    if (self) {
        self.isPublishHouse = NO;
        self.backgroundColor = [UIColor whiteColor];
        newDate = [NSDate date];
        [self addSubview:self.collectionView];
        [self addSubview:self.headTitleView];
    }
    return self;
}

#pragma mark --- <UICollectionViewDataSource ,UICollectionViewDelegate>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    CGSize size={SCREEN_WIDTH,90};
    return size;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSDate * dateList = [self getPriousorLaterDateFromDate:newDate withMonth:section];
    NSString * timeNSString = [self getMonthBeginAndEndWith:dateList];
    
    NSInteger weekNumOfFirstDay = [timeNSString integerValue];
    
    NSInteger daysNumOfCurrentMonth = [self getNumberOfDays:dateList] + weekNumOfFirstDay;
    
    return daysNumOfCurrentMonth;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CalendarNumCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (cell) {
        NSDate * dateList = [self getPriousorLaterDateFromDate:newDate withMonth:indexPath.section];
        NSArray * currentDates = [self timeString:newDate many:indexPath.section];
        
        NSInteger everyNum = indexPath.row -[self getMonthBeginAndEndWith:dateList].intValue+1;
        NSString * numStr ;
        if (everyNum <10) {
            numStr = everyNum > 0 ? [NSString stringWithFormat:@"0%ld",(long)everyNum]:[NSString stringWithFormat:@"-0%ld",(long)- everyNum];
        }else{
            numStr = [NSString stringWithFormat:@"%ld",(long)everyNum];
        }
        
        NSArray * list = @[currentDates[0],currentDates[1],numStr];
        [cell updateNum:list liveInDate:_liveInArray leaveNum:[_leaveArray componentsJoinedByString:@""].integerValue currentDate:[self timeString:newDate many:0]];
        //lilang 0608-add
        if (self.selectDateArr.count > 0) {
            for (NSString *date in self.selectDateArr) {
                NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
                fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
                fmt.dateFormat = @"yyyy-MM-dd";
                NSDate *selectDate = [fmt dateFromString:date];
                NSString *month = [NSString stringWithFormat:@"%zd",selectDate.getMonth];
                NSString *day = [NSString stringWithFormat:@"%zd",selectDate.getDay];
                NSString *viewMonth = [NSString stringWithFormat:@"%zd",dateList.getMonth];
                if ([cell.numLabel.text isEqualToString:day] &&
                    [viewMonth isEqualToString:month]) {
                    cell.isSelect = YES;
                    cell.numLabel.backgroundColor = [UIColor redColor];
                    cell.numLabel.textColor = [UIColor whiteColor];
                }
            }
        }
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //lilang 0608-add
    //判断是否是发布保真房页面
    if (self.isPublishHouse) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *now = [NSDate date];
        //获取到当前时间的NSDate
        NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
        NSDate *currentDate = [calendar dateFromComponents:dateComponent];
        
        
        //当前选择的年月
        NSDate * dateList = [self getPriousorLaterDateFromDate:newDate withMonth:indexPath.section];
        NSInteger day = indexPath.row -[self getMonthBeginAndEndWith:dateList].intValue+1;
        NSArray * dateStringArray = [self timeString:newDate many:indexPath.section];
        //当前选中的天
        NSString *dayStr = day < 10 ? [NSString stringWithFormat:@"0%ld",(long)day]:[NSString stringWithFormat:@"%ld",(long)day];
        //当前选中的年月日
        NSString * selectDateStr = [NSString stringWithFormat:@"%@,%@,%@",dateStringArray[0],dateStringArray[1],dayStr];
        //将当前选择的年月日转换成date
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        fmt.dateFormat = @"yyyy-MM-dd";
        NSDate *selectDate = [fmt dateFromString:selectDateStr];
        //判断选择的天数是否大于60天
        NSTimeInterval currentTimeInterval  = [currentDate timeIntervalSince1970]*1;
        NSTimeInterval leaveTimeInterval  = [selectDate timeIntervalSince1970]*1;
        int dayInterval =( leaveTimeInterval - currentTimeInterval )/86400;
        if (dayInterval > 60) {
            _leaveArray = nil;
//            [MBProgressHUD showTipMessage:@"不能大于60天" toView:nil];
            return;
        }else{
            [_confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _confirmButton.userInteractionEnabled = YES;
            
            NSString *temp = [fmt stringFromDate:selectDate];
            
            CalendarNumCell * cell = (CalendarNumCell *)[collectionView cellForItemAtIndexPath:indexPath];
            
            if (cell.isSelect) {
                cell.isSelect = NO;
                cell.numLabel.backgroundColor = kWhiteColor;
                cell.numLabel.textColor = kBlackColor;
                [self.selectDateArr removeObject:temp];
            }else{
                cell.isSelect = YES;
                cell.numLabel.backgroundColor = kRedColor;
                cell.numLabel.textColor = [UIColor whiteColor];
                [self.selectDateArr addObject:temp];
            }
        }
        return;
    }
    
    

    NSDate * dateList = [self getPriousorLaterDateFromDate:newDate withMonth:indexPath.section];
    NSInteger day = indexPath.row -[self getMonthBeginAndEndWith:dateList].intValue+1;
    NSArray * dateStringArray = [self timeString:newDate many:indexPath.section];
    
    NSString *dayStr = day < 10 ? [NSString stringWithFormat:@"0%ld",(long)day]:[NSString stringWithFormat:@"%ld",(long)day];
    if (!IsNilOrNull(_liveInArray) && !IsNilOrNull(_leaveArray)) {
         _leaveArray = nil;
        /**
         *  重新选择入住时间
         */
        _liveInArray = @[dateStringArray[0],dateStringArray[1],dayStr];
        [_cancleButton setTitle:@"清除" forState:UIControlStateNormal];
        [self.collectionView reloadData];
        
        [_confirmButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _confirmButton.userInteractionEnabled = NO;
    }else{
        if (_liveInArray.count == 0) {
            /**
             *  选择入住时间
             */
            _liveInArray =@[dateStringArray[0],dateStringArray[1],dayStr];
            [_cancleButton setTitle:@"清除" forState:UIControlStateNormal];
            [self.collectionView reloadData];
        }
        else
        {
            /**
             *  选择离开时间
             */
            _leaveArray = @[ dateStringArray[0], dateStringArray[1], dayStr];
            NSInteger leaveTime = [_leaveArray componentsJoinedByString:@""].intValue;
            NSInteger liveInTime = [_liveInArray componentsJoinedByString:@""].intValue;
            
            NSString * liveInStr = [NSString stringWithFormat:@"%@,%@,%@",_liveInArray[0],_liveInArray[1],_liveInArray[2]];
            NSString * leaveStr = [NSString stringWithFormat:@"%@,%@,%@",_leaveArray[0],_leaveArray[1],_leaveArray[2]];
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
            fmt.dateFormat = @"yyyy-MM-dd";
            NSDate *liveInDate = [fmt dateFromString:liveInStr];
            NSTimeInterval liveInTimeInterval  = [liveInDate timeIntervalSince1970]*1;
            
            NSDate *leaveDate = [fmt dateFromString:leaveStr];
            NSTimeInterval leaveTimeInterval  = [leaveDate timeIntervalSince1970]*1;
            int dayInterval =( leaveTimeInterval - liveInTimeInterval )/86400;
            if (dayInterval >60) {
                _leaveArray = nil;
//                [MBProgressHUD showTipMessage:@"入住时间不能超过60天" toView:nil];
                return;
            }else{
                if (leaveTime < liveInTime || leaveTime == liveInTime){
                    return;
                }
                else{
                    [self.collectionView reloadData];
                }
                
            }
            [_confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _confirmButton.userInteractionEnabled = YES;
        }
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        CalendarHeaderResuableView * headerCell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        
        [headerCell updateDate:[self timeString:newDate many:indexPath.section]];
        return headerCell;
    }
    return nil;
}

#pragma mark --- method
- (void)confirmClick{
    //lilang 0608-add
    if(self.isPublishHouse){
        if (self.selectDateArr.count == 0) {
//            [MBProgressHUD showTipMessage:@"至少选择一天" toView:self];
        }else{
//            [self sendObject:self.selectDateArr];
            [self removeFromSuperview];
        }
        return;
    }
    
    if (_liveInArray.count > 0 && _leaveArray.count > 0) {
        if (self.selectDate) {
            self.selectDate(_liveInArray,_leaveArray);
        [_cancleButton setTitle:@"返回" forState:UIControlStateNormal];
        [_collectionView reloadData];
        }
    }else if (_liveInArray.count == 0){
//        [MBProgressHUD showTipMessage:@"请选择入住日期" toView:nil];
    }else{
//        [MBProgressHUD showTipMessage:@"请选择离开日期" toView:nil];
    }
}
- (void)cancleClick{
    if (self.isPublishHouse) {
        [self removeFromSuperview];
        return;
    }
    if ([_cancleButton.titleLabel.text isEqualToString:@"清除"]) {
        _leaveArray = nil;
        _liveInArray = nil;
        [_collectionView reloadData];
        [_cancleButton setTitle:@"返回" forState:UIControlStateNormal];
    }else{
//        [self sendObject:@"cancle"];
    }
    [_confirmButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _confirmButton.userInteractionEnabled = NO;
}

- (void)confirmDate:(chooseDate)rentDate{
    self.selectDate = rentDate;
}

/**
 *  根据当前月获取有多少天
 *
 *  @param  dayDate 当前时间
 *
 *  @return 天数
 */
- (NSInteger)getNumberOfDays:(NSDate *)dayDate{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:dayDate];
    return range.length;
}
/**
 *  根据前几月获取时间
 *
 *  @param date  当前时间
 *  @param month 第几个月 正数为前  负数为后
 *
 *  @return 获得时间
 */
- (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(NSInteger)month{
    [self.comps setMonth:month];
    
    NSDate *mDate = [self.calender dateByAddingComponents:self.comps toDate:date options:0];
    return mDate;
    
}
/**
 *  根据时间获取周几
 *
 *  @param inputDate 输入参数是NSDate，
 *
 *  @return 输出结果是星期几的字符串。
 */
- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    [self.calender setTimeZone: self.timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [self.calender components:calendarUnit fromDate:inputDate];
    
    return [self.weekdays objectAtIndex:theComponents.weekday];
    
}
/**
 *  获取第N个月的时间
 *
 *  @param currentDate 当前时间
 *  @param index 第几个月 正数为前  负数为后
 *
 *  @return @“2016年5月”
 */
- (NSArray*)timeString:(NSDate*)currentDate many:(NSInteger)index;
{
    
    NSDate *getDate =[self getPriousorLaterDateFromDate:currentDate withMonth:index];
    
    NSString  *str =  [self.formatter stringFromDate:getDate];
    
    return [str componentsSeparatedByString:@"-"];
}
/**
 *  根据时间获取第一天周几
 *
 *  @param dateStr 时间
 *
 *  @return 周几
 */
- (NSString *)getMonthBeginAndEndWith:(NSDate *)dateStr{
    double interval = 0;
    NSDate * beginDate = nil;
    NSDate * endDate = nil;
    NSCalendar * calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];// 周一为首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:dateStr];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    return   [self weekdayStringFromDate:beginDate];
}

#pragma -mark getter and setter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 35*SCALE_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT- (64 + 75)*SCALE_HEIGHT) collectionViewLayout:self.flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        //          注册cell
        [_collectionView registerClass:[CalendarNumCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [_collectionView registerClass:[CalendarHeaderResuableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
        
    }return _collectionView;
}
- (UICollectionViewFlowLayout *)flowLayout{
    NSInteger width = 45 * SCALE_WIDTH;
    NSInteger height = 50 * SCALE_HEIGHT;
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.itemSize = CGSizeMake(width, height);
        [_flowLayout setHeaderReferenceSize:CGSizeMake(SCREEN_WIDTH, 71)];
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }return _flowLayout;
}

- (NSDateFormatter *)formatter{
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc]init];
        [_formatter setDateFormat:@"yyyy-MM-dd"];
    }return _formatter;
}
- (NSDateComponents *)comps{
    if (!_comps) {
        _comps = [[NSDateComponents alloc]init];
    }return _comps;
}
- (NSCalendar *)calender{
    if (!_calender) {
        _calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }return _calender;
}
- (NSTimeZone *)timeZone{
    if (!_timeZone) {
        _timeZone = [[NSTimeZone alloc]initWithName:@"Asia/Beijing"];
    }return _timeZone;
}
- (NSArray *)weekdays{
    if (!_weekdays) {
        _weekdays = @[[NSNull null],@"0", @"1", @"2", @"3", @"4", @"5", @"6"];
    }return _weekdays;
}
- (UIView *)headTitleView{
    if (!_headTitleView) {
        _headTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35*SCALE_HEIGHT)];
        _headTitleView.backgroundColor = [UIColor lightTextColor];
        UILabel * title = [[UILabel alloc]init];
        title.text = @"选择日期";
        title.font = [UIFont systemFontOfSize:14];
        title.textColor= [UIColor lightGrayColor];
        [_headTitleView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(_headTitleView);
            make.height.mas_equalTo(14);
        }];
        [_headTitleView addSubview:self.cancleButton];
        [_cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headTitleView.mas_left).offset(13);
            make.centerY.equalTo(_headTitleView.mas_centerY);
            make.height.mas_equalTo(13);
        }];
        [_headTitleView addSubview:self.confirmButton];
        [_confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_headTitleView.mas_right).offset(-13);
            make.centerY.equalTo(_headTitleView.mas_centerY);
            make.height.mas_equalTo(13);
        }];
    }return _headTitleView;
}
- (UIButton *)cancleButton{
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleButton setTitle:@"返回" forState:UIControlStateNormal];
        [_cancleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
       
        [_cancleButton addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
        _cancleButton.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    }return _cancleButton;
}
- (UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
         _confirmButton.userInteractionEnabled = NO;
        [_confirmButton addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    }return _confirmButton;
}

- (NSMutableArray *)selectDateArr{
    if (!_selectDateArr) {
        _selectDateArr = [[NSMutableArray alloc]init];
    }
    return _selectDateArr;
}

@end
