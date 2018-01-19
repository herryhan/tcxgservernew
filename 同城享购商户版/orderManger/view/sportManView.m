//
//  sportManView.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/6.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "sportManView.h"

@implementation sportManView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"sportManView" owner:self options:nil];
        if (arrayObjectViews.count <1) {
            return nil;
        }else{
            
            for (id obj in arrayObjectViews) {
                self = obj;
                self.frame = frame;
            }
        }
    }
    return self;
}

- (void)setModel:(orderModel *)model{
    self.driveNameLabel.text = model.driverName;
    [self.driveTelButton setTitle:model.driverTel forState:UIControlStateNormal];
    
}

@end
