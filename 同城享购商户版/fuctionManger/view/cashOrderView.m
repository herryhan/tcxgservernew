//
//  cashOrderView.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/11.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "cashOrderView.h"

@implementation cashOrderView
-(instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"cashOrderView" owner:self options:nil];
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

- (void)setValueWithDic:(NSMutableDictionary *)dic{
    self.orderNum.text = [NSString stringWithFormat:@"%@",dic[@"no"]];
    self.payMoneyLabel.text =[NSString stringWithFormat:@"¥%@",dic[@"payMoney"]];
    self.shopGetLabel.text =[NSString stringWithFormat:@"¥%@",dic[@"shopGet"]];
}

@end
