//
//  CalendarHeaderResuableView.h
//  KuaiYouJia
//
//  Created by guide_sun on 16/5/9.
//  Copyright © 2016年 KuaiYouJia. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface CalendarHeaderResuableView : UICollectionReusableView
@property (nonatomic ,strong)UILabel * dateLabel;
@property (nonatomic,strong)UILabel * weekLabel;

- (void)updateDate:(NSArray*)dateArray;
@end
