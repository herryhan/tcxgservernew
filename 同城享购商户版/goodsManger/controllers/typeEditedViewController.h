//
//  typeEditedViewController.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/27.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "baseViewController.h"
#import "goodsTypeModel.h"

@interface typeEditedViewController : baseViewController
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *weightText;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (nonatomic,strong) goodsTypeModel *model;
@property (weak, nonatomic) IBOutlet UIView *lineView1;
@property (weak, nonatomic) IBOutlet UIView *lineView2;



@property (nonatomic,strong) void(^updateType)(goodsTypeModel *model);
@property (nonatomic,strong) void(^addType)(goodsTypeModel *model);

@property BOOL isAdd;
@property BOOL isSingle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@end
