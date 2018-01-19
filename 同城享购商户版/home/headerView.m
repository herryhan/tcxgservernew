//
//  headerView.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/23.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "headerView.h"

@implementation headerView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"headerView" owner:self options:nil];
        if (arrayObjectViews.count <1) {
            return nil;
        }else{
            
            for (id obj in arrayObjectViews) {
                self = obj;
                self.frame = frame;
                [self uiconfig];
            }
        }
    }
    
    return self;
}
- (void)uiconfig{
     self.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
    self.firstBgView.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
    self.secondBgView.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
    
}
- (void)setValuesWith:(SPAccount *)acc{
    
    self.cashTodayLabel.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithInt:acc.money]];
    self.orderToday.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithFloat:acc.count]];
    self.noGetMoneyLabel.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithFloat:acc.unTakeCash]];
    
}
@end
