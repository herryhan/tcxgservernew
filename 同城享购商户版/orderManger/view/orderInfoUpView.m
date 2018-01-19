//
//  orderInfoUpView.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/5.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "orderInfoUpView.h"

@implementation orderInfoUpView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"orderInfoUpView" owner:self options:nil];
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
    self.orderStateLabel.textColor = UIColorFromRGBA(68, 195, 34, 1);
    self.orderTimeLabel.textColor =  UIColorFromRGBA(68, 195, 34, 1);
    self.orderExpTimeLLabel.textColor = UIColorFromRGBA(68, 195, 34, 1);
    self.orderStartLabel.textColor = UIColorFromRGBA(68, 195, 34, 1);
}
- (void)setModel:(orderModel *)model{
    _model = model;
    self.orderTimeLabel.text = model.creatTime;
    self.orderStateLabel.text = model.stateDes;
    self.orderStartLabel.text = model.beginTime;
    self.orderExpTimeLLabel.text = model.expectTime;
    self.receiveNameLabel.text = model.userName;
    self.addressLabel.text = model.userAddress;
}

@end
