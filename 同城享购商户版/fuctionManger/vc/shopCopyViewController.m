//
//  shopCopyViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/20.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "shopCopyViewController.h"

@interface shopCopyViewController ()<UITextFieldDelegate>

@end

@implementation shopCopyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self contitle:@"复制店铺"];
    [self uiconfig];
}
- (void)uiconfig{
    NSLog(@"ddddd");
    self.shopCopyBtn.layer.cornerRadius = 5;
    self.shopCopyBtn.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
    self.userText.delegate = self;
    self.pwdText.delegate = self;
    self.shopTopConstraint.constant = SafeAreaTopHeight;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.userText resignFirstResponder];
    [self.pwdText resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


- (IBAction)shopCopyPress:(UIButton *)sender {
    
    [self.userText resignFirstResponder];
    [self.pwdText resignFirstResponder];
    if (self.userText.text.length!=0 && self.pwdText.text.length !=0) {
        NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
        parmas[@"uuid"] = [keepData getUUID];
        parmas[@"username"] = self.userText.text;
        parmas[@"pwd"] = self.pwdText.text;
        
        [MBProgressHUD showMessage:@"复制中" toView:self.view];
        [URLRequest postWithURL:@"sp/product/copy/do" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSLog(@"%@",responseObject);
                if ([responseObject[@"state"] isEqualToString:@"success"]) {
                    [MBProgressHUD showSuccess:@"复制成功" toView:self.view];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [MBProgressHUD showError:@"复制失败" toView:self.view];
                }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSLog(@"%@",error);
        }];
    }else{
        [MBProgressHUD showError:@"用户名或密码不能为空" toView:self.view];
    }
}

@end












