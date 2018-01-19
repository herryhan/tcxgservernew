//
//  changePwdViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/11.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "changePwdViewController.h"

@interface changePwdViewController ()<UITextFieldDelegate>

@end

@implementation changePwdViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self contitle:@"修改密码"];
    [self uiconfig];
    
}

- (void)uiconfig{
    self.submitBtn.layer.cornerRadius = 5;
    self.submitBtn.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
    self.oldPwd.delegate  = self;
    self.pwdNew.delegate = self;
    self.pwdNewAgain.delegate = self;
    self.pwdConstraint.constant = SafeAreaTopHeight;
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.oldPwd resignFirstResponder];
    [self.pwdNewAgain resignFirstResponder];
    [self.pwdNew resignFirstResponder];
    
}
- (IBAction)submit:(UIButton *)sender {
    
    [self.oldPwd resignFirstResponder];
    [self.pwdNewAgain resignFirstResponder];
    [self.pwdNew resignFirstResponder];
    if (self.oldPwd.text.length!=0 && self.pwdNewAgain.text.length!=0 && self.pwdNew.text.length!=0) {
        if (![self.pwdNew.text isEqualToString:self.pwdNewAgain.text]) {
            [MBProgressHUD showError:@"新密码输入不一致" toView:self.view];
        }else{
            [MBProgressHUD showMessage:@"提交中" toView:self.view];
    
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            params[@"oldPwd"] = self.oldPwd.text;
            params[@"newPwd"] = self.pwdNew.text;
            params[@"uuid"] = [keepData getUUID];
            
            [URLRequest postWithURL:@"sp/changPwd/do" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                    if ([responseObject[@"state"] isEqualToString:@"success"]) {
                        [MBProgressHUD showSuccess:@"修改成功" toView:self.view];
                    }else{
                        [MBProgressHUD showSuccess:responseObject[@"msg"] toView:self.view];
                    }
                    NSLog(@"%@",responseObject);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:@"网络错误,请检查网络连接" toView:self.view];
            }];
        }
    }else{
        [MBProgressHUD showError:@"输入内容不能为空" toView:self.view];
    }
   
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.oldPwd resignFirstResponder];
    [self.pwdNewAgain resignFirstResponder];
    [self.pwdNew resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
