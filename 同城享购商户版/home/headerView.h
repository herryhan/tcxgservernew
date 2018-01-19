//
//  headerView.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/23.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface headerView : UIView
@property (weak, nonatomic) IBOutlet UILabel *cashTodayLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderToday;
@property (weak, nonatomic) IBOutlet UILabel *noGetMoneyLabel;
@property (weak, nonatomic) IBOutlet UIView *firstBgView;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;
//@property (nonatomic,strong) NSMutableDictionary *inf
- (void)setValuesWith:(SPAccount *)acc;
@end
