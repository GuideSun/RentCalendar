//
//  CalendarHeaderResuableView.m
//  KuaiYouJia
//
//  Created by guide_sun on 16/5/9.
//  Copyright © 2016年 KuaiYouJia. All rights reserved.
//

#import "CalendarHeaderResuableView.h"
#import "Masonry.h"
#define kMargin 32 * SCALE_WIDTH
//当前设备的屏幕宽度
#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
//当前设备的屏幕高度
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
//当前系统的高度比例
#define SCALE_HEIGHT   SCREEN_HEIGHT / 568
//当前系统的宽度比例
#define SCALE_WIDTH    SCREEN_WIDTH / 320
@implementation CalendarHeaderResuableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.dateLabel];
        [self addSubview:self.weekLabel];

    }
    return self;
}
- (void)updateDate:(NSArray*)dateArray{
    self.dateLabel.text = [NSString stringWithFormat:@"%@-%@",dateArray[0],dateArray[1]];
}
- (UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.frame = CGRectMake(0, 20*SCALE_HEIGHT,SCREEN_WIDTH,13);
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.font = [UIFont systemFontOfSize:13];
    }return _dateLabel;
}
- (UILabel *)weekLabel{
    if (!_weekLabel) {
        NSArray * weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        UILabel * lastLabel = nil;
        for (int i =0; i< weekArray.count; i++) {
            _weekLabel = [[UILabel alloc]init];
            _weekLabel.text = weekArray[i];
            _weekLabel.font = [UIFont systemFontOfSize:13];
            _weekLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:self.weekLabel];
            [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(58*SCALE_HEIGHT);
                make.height.mas_equalTo(13);
                make.width.equalTo(self).dividedBy(7);
                if (lastLabel) {
                    make.left.mas_equalTo(lastLabel.mas_right);
                } else {
                    make.left.equalTo(self);
                }
            }];
            
            lastLabel = _weekLabel;
        }
        
        
    }return _weekLabel;
}
@end
