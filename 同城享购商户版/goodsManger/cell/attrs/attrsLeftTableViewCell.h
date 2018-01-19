//
//  attrsLeftTableViewCell.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/12.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "attrsTypeModel.h"

@interface attrsLeftTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *attrsTypeName;
@property (weak, nonatomic) IBOutlet UIButton *subBtn;

@property (nonatomic,strong)attrsTypeModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *lineIamge;

@property (nonatomic,strong) void(^delAttrsType)(NSNumber * attrsTypeId);


@end
