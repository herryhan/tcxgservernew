//
//  changePwdViewController.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/11.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "baseViewController.h"

@interface changePwdViewController : baseViewController
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UITextField *oldPwd;

@property (weak, nonatomic) IBOutlet UITextField *pwdNew;
@property (weak, nonatomic) IBOutlet UITextField *pwdNewAgain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pwdConstraint;

@end
