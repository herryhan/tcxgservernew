//
//  orderInfoDownView.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/5.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderModel.h"

@interface orderInfoDownView : UIView
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceAndWeightLabel;
@property (weak, nonatomic) IBOutlet UILabel *sendFeeAndFeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;


@property (weak, nonatomic) IBOutlet UIButton *getOrderBtn;
@property (weak, nonatomic) IBOutlet UIButton *refuseBtn;
@property (weak, nonatomic) IBOutlet UIButton *moneyBackBtn;
@property (weak, nonatomic) IBOutlet UIButton *connectBuyerBtn;
@property (weak, nonatomic) IBOutlet UIButton *connectSenderBtn;

@property (nonatomic,strong) orderModel *model;
@property (nonatomic,assign) NSInteger currentIndex;


@property (nonatomic,strong) void(^connectBuyer)(NSString *buyerTel);

@property (nonatomic,strong) void(^connectDriver)(NSString *driverTel);

@property (nonatomic,strong) void(^orderDeal)(NSInteger btnTag);

@end


