//
//  advViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/19.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "advViewController.h"

@interface advViewController ()<UITextViewDelegate>

@end

@implementation advViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self contitle:@"修改公告"];
    self.automaticallyAdjustsScrollViewInsets= NO;
    [self uiconfig];
}

- (void)uiconfig{
    
    self.submitBtn.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
    self.submitBtn.layer.cornerRadius = 5;
    self.advText.layer.cornerRadius = 5;
    self.advText.layer.masksToBounds = YES;
    self.submitBtn.layer.masksToBounds = YES;
    if ([SPAccountTool account].notice.length!=0) {
        self.advText.text = [SPAccountTool account].notice;
    }
    self.advText.delegate = self;
    
    self.topConstraint.constant = SafeAreaTopHeight +20;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.advText resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (IBAction)advPress:(UIButton *)sender {
    [self.advText resignFirstResponder];
    [MBProgressHUD showSuccess:@"提交中" toView:self.view];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"id"] = @([SPAccountTool account].shopId);
    params[@"notice"] = self.advText.text;
    params[@"uuid"] = [keepData getUUID];
    
    [URLRequest postWithURL:@"sp/notice/update/do" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
   
            if ([responseObject[@"state"] isEqualToString:@"success"]) {
                [MBProgressHUD showSuccess:@"提交成功"toView:self.view];
                NSNotification *notification =[NSNotification notificationWithName:@"InfoNotification" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [MBProgressHUD showError:@"系统原因" toView:self.view];
            }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:@"提交失败" toView:self.view];
    }];
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
