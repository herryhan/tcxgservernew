//
//  cashHistroyView.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/11.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "cashHistroyView.h"

@implementation cashHistroyView

-(instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"cashHistroy" owner:self options:nil];
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
    self.timeLabel.textColor = UIColorFromRGBA(68, 195, 34, 1);
    self.shopNameLabel.textColor = UIColorFromRGBA(68, 195, 34, 1);
    self.moneyPerOrderLabel.textColor = UIColorFromRGBA(68, 195, 34, 1);
    self.pointPerOrder.textColor = UIColorFromRGBA(68, 195, 34, 1);
    self.bankNameLabel.textColor = UIColorFromRGBA(68, 195, 34, 1);
    self.bankAccountLabel.textColor = UIColorFromRGBA(68, 195, 34, 1);
    self.casherNameLabel.textColor = UIColorFromRGBA(68, 195, 34, 1);
    self.cashCountLabel.textColor = UIColorFromRGBA(68, 195, 34, 1);
    self.cashManger.textColor = UIColorFromRGBA(68, 195, 34, 1);
    
}
- (void)setModel:(cashModel *)model{
    _model = model;
    self.timeLabel.text =[NSString stringWithFormat:@"%@",model.creatTime] ;
    self.shopNameLabel.text =[NSString stringWithFormat:@"%@",model.name] ;
    self.moneyPerOrderLabel.text =[NSString stringWithFormat:@"¥%@",model.orderFee];
    self.pointPerOrder.text = [NSString stringWithFormat:@"%@",model.points];
    self.bankNameLabel.text =[NSString stringWithFormat:@"%@", model.bankName];
    self.bankAccountLabel.text = [NSString stringWithFormat:@"%@",model.bankNo];
    self.casherNameLabel.text =[NSString stringWithFormat:@"%@", model.bankRealname];
    self.cashCountLabel.text = [NSString stringWithFormat:@"%@",model.money];
    self.cashManger.text =[NSString stringWithFormat:@"%@",model.username] ;
}

@end
