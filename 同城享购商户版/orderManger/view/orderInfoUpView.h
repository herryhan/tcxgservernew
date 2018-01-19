//
//  orderInfoUpView.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/5.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderModel.h"

@interface orderInfoUpView : UIView

@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStartLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderExpTimeLLabel;
@property (weak, nonatomic) IBOutlet UILabel *receiveNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (nonatomic,strong) orderModel *model;


@end
