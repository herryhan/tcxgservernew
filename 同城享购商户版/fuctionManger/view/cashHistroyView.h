//
//  cashHistroyView.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/11.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cashModel.h"

@interface cashHistroyView : UIView
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyPerOrderLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointPerOrder;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankAccountLabel;
@property (weak, nonatomic) IBOutlet UILabel *casherNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cashCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *cashManger;

@property (nonatomic,strong) cashModel *model;

@end
