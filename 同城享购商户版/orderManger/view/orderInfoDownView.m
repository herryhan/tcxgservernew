//
//  orderInfoDownView.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/5.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "orderInfoDownView.h"

@implementation orderInfoDownView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"orderInfoDownView" owner:self options:nil];
        if (arrayObjectViews.count <1) {
            return nil;
        }else{
            
            for (id obj in arrayObjectViews) {
                self = obj;
                self.frame = frame;
                self.totalLabel.textColor = UIColorFromRGBA(68, 195, 34, 1);
                self.getOrderBtn.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
                self.refuseBtn.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
                self.moneyBackBtn.backgroundColor =  UIColorFromRGBA(68, 195, 34, 1);
                self.connectBuyerBtn.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
                self.connectSenderBtn.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
            }
        }
    }
    return self;
}
- (void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex =currentIndex;
    switch (currentIndex) {
        case 0:{
            self.moneyBackBtn.backgroundColor = [UIColor lightGrayColor];
            self.moneyBackBtn.userInteractionEnabled = NO;
            self.connectSenderBtn.backgroundColor = [UIColor lightGrayColor];
            self.connectSenderBtn.userInteractionEnabled = NO;
        }
            break;
        case 1:{
            self.getOrderBtn.backgroundColor = [UIColor lightGrayColor];
            self.getOrderBtn.userInteractionEnabled = NO;
            self.refuseBtn.backgroundColor = [UIColor lightGrayColor];
            self.refuseBtn.userInteractionEnabled = NO;
            self.moneyBackBtn.backgroundColor = [UIColor lightGrayColor];
            self.moneyBackBtn.userInteractionEnabled = NO;
        }
            break;
        case 2:{
            self.getOrderBtn.backgroundColor = [UIColor lightGrayColor];
            self.getOrderBtn.userInteractionEnabled = NO;
            self.refuseBtn.backgroundColor = [UIColor lightGrayColor];
            self.refuseBtn.userInteractionEnabled = NO;
        }
            break;
        case 3:{
            self.getOrderBtn.backgroundColor = [UIColor lightGrayColor];
            self.getOrderBtn.userInteractionEnabled = NO;
            
            self.refuseBtn.backgroundColor = [UIColor lightGrayColor];
            self.refuseBtn.userInteractionEnabled = NO;
            
            self.moneyBackBtn.backgroundColor = [UIColor lightGrayColor];
            self.moneyBackBtn.userInteractionEnabled = NO;
            
            self.connectBuyerBtn.backgroundColor = [UIColor lightGrayColor];
            self.connectBuyerBtn.userInteractionEnabled = NO;
            
            self.connectSenderBtn.backgroundColor = [UIColor lightGrayColor];
            self.connectSenderBtn.userInteractionEnabled = NO;
        }
            break;
        case 4:{
            self.getOrderBtn.backgroundColor = [UIColor lightGrayColor];
            self.getOrderBtn.userInteractionEnabled = NO;
            
            self.refuseBtn.backgroundColor = [UIColor lightGrayColor];
            self.refuseBtn.userInteractionEnabled = NO;
            
            self.moneyBackBtn.backgroundColor = [UIColor lightGrayColor];
            self.moneyBackBtn.userInteractionEnabled = NO;
      
            self.connectSenderBtn.backgroundColor = [UIColor lightGrayColor];
            self.connectSenderBtn.userInteractionEnabled = NO;
            
        }
            break;
        default:
            break;
    }
}
- (void)setModel:(orderModel *)model{
    _model = model;
    self.orderNoLabel.text = [NSString stringWithFormat:@"订单号:%@", model.no];
    self.distanceAndWeightLabel.text = [NSString stringWithFormat:@"距离:%@km | 重量:%@kg",model.distance,model.weight];
    self.sendFeeAndFeeLabel.text = [NSString stringWithFormat:@"配送费:%@元 | 优惠:%@元",model.fee,model.discountMoney];
    self.totalLabel.text = [NSString stringWithFormat:@"总价:%@元",model.payMoney];
}

- (IBAction)connectBuyerBtn:(UIButton *)sender {
    _connectBuyer(self.model.userTel);
}

- (IBAction)connectDriverBtn:(UIButton *)sender {
    _connectDriver(self.model.driverTel);
}

- (IBAction)takeOrder:(UIButton *)sender {
    _orderDeal(sender.tag);
}

@end
