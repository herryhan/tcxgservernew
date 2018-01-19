//
//  addValsViewController.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/15.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "baseViewController.h"
#import "attrsValModel.h"

@interface addValsViewController : baseViewController
@property (weak, nonatomic) IBOutlet UIButton *typeNameBtn;
@property (weak, nonatomic) IBOutlet UITextField *attrsName;
@property (weak, nonatomic) IBOutlet UITextField *attrsPrice;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;


@property (nonatomic,strong) NSArray *attrsTypeArray;
@property (nonatomic,assign) NSInteger selectedIndex;

@property (nonatomic,strong) void(^refreshVals)(NSInteger index);

@property (nonatomic,assign) BOOL isEditing;
@property (nonatomic,strong) attrsValModel *selectedModel;

@end
