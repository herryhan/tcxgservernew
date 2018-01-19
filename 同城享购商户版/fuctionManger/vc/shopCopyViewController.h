//
//  shopCopyViewController.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/20.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "baseViewController.h"

@interface shopCopyViewController : baseViewController
@property (weak, nonatomic) IBOutlet UITextField *userText;
@property (weak, nonatomic) IBOutlet UITextField *pwdText;

@property (weak, nonatomic) IBOutlet UIButton *shopCopyBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shopTopConstraint;

@end
