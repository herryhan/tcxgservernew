//
//  resViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/11.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "resViewController.h"

@interface resViewController ()<UITextFieldDelegate>

@end

@implementation resViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self contitle:@"回复"];
    [self uiconfig];
}
- (void)uiconfig{
    self.submitBtn.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
    self.resText.delegate =self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.resText resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self.resText resignFirstResponder];
    return YES;
    
}
- (IBAction)submitPress:(UIButton *)sender {
 
    [self.resText resignFirstResponder];
    [MBProgressHUD showMessage:@"" toView:self.view];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"uuid"] = [keepData getUUID];
    params[@"txt"] = self.resText.text;
    params[@"id"] = self.commentID;
    [URLRequest postWithURL:@"sp/comment/res" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"state"] isEqualToString:@"success"]) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showSuccess:@"回复成功" toView:self.view];
            _refreshData(YES);
            [self.navigationController popViewControllerAnimated:YES];
        }else if([responseObject[@"state"] isEqualToString:@"login"]){
            [self submitPress:self.submitBtn];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:@"网络问题，请检查网络" toView:self.view];
        
    }];
    
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
