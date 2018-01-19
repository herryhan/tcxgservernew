//
//  advViewController.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/19.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "baseViewController.h"

@interface advViewController : baseViewController

@property (weak, nonatomic) IBOutlet UITextView *advText;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@end
