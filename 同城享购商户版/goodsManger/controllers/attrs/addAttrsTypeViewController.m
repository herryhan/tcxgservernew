//
//  addAttrsTypeViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/15.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "addAttrsTypeViewController.h"

@interface addAttrsTypeViewController ()<UITextFieldDelegate>

@end

@implementation addAttrsTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self uiconfig];
}

- (void)uiconfig{
    self.submitBtn.layer.cornerRadius = 5;
    self.submitBtn.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
 
    self.nameText.delegate = self;
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nameText resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.nameText resignFirstResponder];
    return YES;
}

- (IBAction)submitPress:(UIButton *)sender {
    declareWeakSelf;
    [self.nameText resignFirstResponder];
    if (self.nameText.text.length!=0) {
        [MBProgressHUD showMessage:@"提交中" toView:self.view];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        params[@"uuid"] = [keepData getUUID];
        params[@"id"] = self.goodsId;
        params[@"name"] = self.nameText.text;
        
        [URLRequest postWithURL:@"sp/product/attr/add" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
              [MBProgressHUD hideHUDForView:self.view];
                if ([responseObject[@"state"] isEqualToString:@"success"]) {
                    [MBProgressHUD showSuccess:@"提交成功" toView:self.view];
                    _refreshAttrsVals(self.typeSelectdIndex);
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    
                }else{
                    
                    [MBProgressHUD showError:@"提交失败" toView:self.view];
                }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"网络错误,请检查网络" toView:self.view];
        }];
    }else{
        [MBProgressHUD showError:@"名称不能为空" toView:self.view];
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
