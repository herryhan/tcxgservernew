//
//  sportManView.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/6.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderModel.h"

@interface sportManView : UIView

@property (weak, nonatomic) IBOutlet UILabel *driveNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *driveTelButton;

@property (nonatomic,strong) orderModel *model;

@end
