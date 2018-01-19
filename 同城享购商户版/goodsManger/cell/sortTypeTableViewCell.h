//
//  sortTypeTableViewCell.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/27.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "goodsTypeModel.h"

@interface sortTypeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *typeNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (nonatomic,strong) goodsTypeModel *model;

@property (nonatomic,strong) void(^eidting)(BOOL isEditing);

@end
