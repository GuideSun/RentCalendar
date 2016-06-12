//
//  ChooseTimeCell.h
//  KuaiYouJia
//
//  Created by guide_sun on 16/5/9.
//  Copyright © 2016年 KuaiYouJia. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface CalendarNumCell : UICollectionViewCell
@property (nonatomic ,strong)UILabel * numLabel;
@property (nonatomic ,strong)NSArray * currentArray;
@property (nonatomic ,assign)BOOL isSelect;

- (void)updateNum:(NSArray *)numbers liveInDate:(NSArray *)liveInDates leaveNum:(NSInteger )leaveNum currentDate:(NSArray *)currentDates;
@end
