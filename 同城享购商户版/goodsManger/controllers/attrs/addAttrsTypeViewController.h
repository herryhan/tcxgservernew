//
//  addAttrsTypeViewController.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/15.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "baseViewController.h"
#import "attrsTypeModel.h"

@interface addAttrsTypeViewController : baseViewController

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameText;

@property (nonatomic,strong) NSNumber *goodsId;
@property (nonatomic,assign) NSInteger typeSelectdIndex;

@property (nonatomic,strong) void(^refreshAttrsVals)(NSInteger index);


@end
