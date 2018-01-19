//
//  typeEditedViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/27.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "typeEditedViewController.h"
#import "CDZPicker.h"

@interface typeEditedViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) NSMutableArray *specialNameArray;
@property (nonatomic,strong) NSMutableArray *specuialIdArray;

@end

@implementation typeEditedViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self contitle:@"分类编辑"];
    [self uiconfig];
   
}


- (void)uiconfig{
    
    self.submitBtn.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
    self.submitBtn.layer.cornerRadius = 5;
    self.submitBtn.layer.masksToBounds = YES;
    if (!self.isAdd) {
        
        self.nameText.text = self.model.typeName;
        self.weightText.text =[NSString stringWithFormat:@"%@",self.model.rank];
        
    }
    self.lineView1.backgroundColor = UIColorFromRGBA(239, 239, 239, 1);
    self.lineView2.backgroundColor = UIColorFromRGBA(239, 239, 239, 1);

    
    self.nameText.delegate  =self;
    self.weightText.delegate = self;
    self.topConstraint.constant = SafeAreaTopHeight;
}


- (IBAction)submitPress:(UIButton *)sender {

    declareWeakSelf;
    [self.nameText resignFirstResponder];
    [self.weightText resignFirstResponder];
    
    if (self.nameText.text.length!=0&&self.weightText.text.length!=0) {
        [MBProgressHUD showMessage:@""];
        NSString *urlstring;
        if (self.isAdd) {
            urlstring = @"sp/type/add";
        }else{
            urlstring = @"sp/type/update";
        }
        NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
        
        parmas[@"name"] = self.nameText.text;
        parmas[@"rank"] = self.weightText.text;
        parmas[@"uuid"] = [keepData getUUID];
        if (self.isAdd) {
            parmas[@"id"] = @([SPAccountTool account].shopId);
        }else{
            parmas[@"id"] = self.model.typeId;

        }
        [URLRequest postWithURL:urlstring params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
              [MBProgressHUD hideHUD];
                if ([responseObject[@"state"] isEqualToString:@"success"]) {
                    goodsTypeModel *newModel = [[goodsTypeModel alloc]init];
                    newModel.typeName = weakSelf.nameText.text;
                    newModel.rank =[NSNumber numberWithString:weakSelf.weightText.text];
                    if (self.isAdd) {
                        newModel.typeId = responseObject[@"typeId"];
                        if (!weakSelf.isSingle) {
                            _addType(newModel);
                        }
                    }else{
                        
                        newModel.typeId = weakSelf.model.typeId;
                        
                        _updateType(newModel);
                        
                    }
                  
                    [self.navigationController popViewControllerAnimated:YES];
                }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@",error);
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"网络错误" toView:self.view];
        }];
    }else{
        [MBProgressHUD showError:@"请完善信息" toView:self.view];
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nameText resignFirstResponder];
    [self.weightText resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
