//
//  activityTableViewCell.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/7.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "activityModel.h"

@interface activityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *typeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *appTakeFeeLabel;

@property (weak, nonatomic) IBOutlet UILabel *beginTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *delBtn;

@property (nonatomic,strong) activityModel *model;

@property (nonatomic,strong) void(^delActivity)(NSNumber *type_id);

@end
