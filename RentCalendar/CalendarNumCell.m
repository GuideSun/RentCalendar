//
//  CalendarNumCell.m
//  KuaiYouJia
//
//  Created by guide_sun on 16/5/9.
//  Copyright © 2016年 KuaiYouJia. All rights reserved.
//
#import "CalendarNumCell.h"
#import "Masonry.h"
#define kLineColor        [UIColor blackColor]
#define kRedColor         [UIColor redColor]
@implementation CalendarNumCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    {
//        self.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.numLabel];
        [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(8, 5, 8, 5));
        }];
    }
    return self;
}

- (UILabel *)numLabel{
    if (!_numLabel) {
        _numLabel = [[UILabel alloc]init];
        _numLabel.font = [UIFont systemFontOfSize:12];
//        _numLabel.frame = CGRectMake(5, 5, 35 * SCALE_WIDTH, 35 * SCALE_HEIGHT);
        _numLabel.textAlignment = NSTextAlignmentCenter;
    }return _numLabel;
}

- (void)updateNum:(NSArray *)numbers liveInDate:(NSArray *)liveInDates leaveNum:(NSInteger )leaveNum currentDate:(NSArray *)currentDates{
    NSInteger everyDateNum = [numbers componentsJoinedByString:@""].intValue;
    
    NSInteger currentNum = [currentDates componentsJoinedByString:@""].intValue;
    
    NSInteger day = [numbers[2] integerValue];
    
    if (day >0) {
        if (currentNum > everyDateNum) {
            _numLabel.backgroundColor = [UIColor whiteColor];
            _numLabel.textColor = [UIColor lightGrayColor];
            self.userInteractionEnabled = NO;
        }else{
            _numLabel.backgroundColor = [UIColor whiteColor];
            _numLabel.textColor = [UIColor blackColor];
            self.userInteractionEnabled = YES;
        }
    }else{
        _numLabel.backgroundColor = [UIColor whiteColor];
        _numLabel.textColor = [UIColor whiteColor];
        self.userInteractionEnabled = NO;
    }
    if (day >=10) {
        _numLabel.text = [NSString stringWithFormat:@"%@",numbers[2]];
    }else{
        NSString * str = [NSString stringWithFormat:@"%@",numbers[2]];
        _numLabel.text = [str stringByReplacingOccurrencesOfString:@"0" withString:@""];
    }
    if (everyDateNum == currentNum) {
        _numLabel.text = @"今天";
    }
    NSInteger liveInNum = [liveInDates componentsJoinedByString:@""].integerValue;
    if (liveInDates.count>0) {
        if (liveInNum >= currentNum) {
            if (liveInNum == everyDateNum) {
                _numLabel.text = @"入住";
                _numLabel.backgroundColor = kRedColor;
                _numLabel.textColor = [UIColor whiteColor];
            }else if (everyDateNum >= currentNum && everyDateNum <liveInNum){
              _numLabel.backgroundColor = [UIColor lightGrayColor];
              self.userInteractionEnabled = NO;
            }
        }
    }
    if (leaveNum >0) {
        if (leaveNum > liveInNum) {
            if (leaveNum == everyDateNum) {
                _numLabel.text = @"离开";
                _numLabel.backgroundColor = kRedColor;
                _numLabel.textColor = [UIColor whiteColor];
            }
            if (liveInNum < everyDateNum &&  everyDateNum < leaveNum){
                _numLabel.backgroundColor = kRedColor;
                _numLabel.textColor = [UIColor whiteColor];
            }
        }
    }
    
    self.currentArray = numbers;
}
- (void)awakeFromNib {
    // Initialization code
    
}
@end
