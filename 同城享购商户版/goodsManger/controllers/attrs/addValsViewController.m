//
//  addValsViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/15.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "addValsViewController.h"
#import "attrsTypeModel.h"
#import "CDZPicker.h"

@interface addValsViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) NSMutableArray *NameArray;
@property (nonatomic,strong) NSMutableArray *typeIDarray;
@property (nonatomic,strong) NSNumber *selectedID;

@end

@implementation addValsViewController

- (NSMutableArray *)typeIDarray{
    if (!_typeIDarray) {
        _typeIDarray = [[NSMutableArray alloc]init];
        for (attrsTypeModel *model in self.attrsTypeArray) {
            [_typeIDarray addObject:model.attrId];
        }
    }
    return _typeIDarray;
}
- (NSMutableArray *)NameArray{
    if (!_NameArray) {
        _NameArray = [[NSMutableArray alloc]init];
        for (attrsTypeModel *model in self.attrsTypeArray) {
            [_NameArray addObject:model.attrName];
        }
    }
    return _NameArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self uiconfig];
}
- (void)uiconfig{
    [self contitle:@"属性值"];
    self.submitBtn.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
    self.submitBtn.layer.cornerRadius = 5;
    self.attrsName.delegate = self;
    self.attrsPrice.delegate = self;
    
    attrsTypeModel *model = self.attrsTypeArray[self.selectedIndex];
    [self.typeNameBtn setTitle:model.attrName forState:UIControlStateNormal];
    self.selectedID = model.attrId;
    if (self.isEditing) {
        self.attrsName.text = self.selectedModel.valName;
        self.attrsPrice.text = [NSString stringWithFormat:@"%@",self.selectedModel.valprice];
    }
    
    NSLog(@"%@",self.selectedID);
}
- (IBAction)submitPress:(UIButton *)sender {
    if (self.attrsName.text.length!=0 && self.attrsPrice.text.length!=0) {
        [MBProgressHUD showMessage:@"" toView:self.view];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        if (self.isEditing) {
            params[@"valId"] = self.selectedModel.valId;
            params[@"attrId"] = self.selectedID;
        }else{
            params[@"id"] = self.selectedID;
        }
    
        params[@"price"] = self.attrsPrice.text;
        params[@"name"] = self.attrsName.text;
        params[@"uuid"] = [keepData getUUID];
        NSString *urlstr;
        if (self.isEditing) {
            urlstr = @"sp/product/val/update/do";
        }else{
            urlstr = @"sp/product/val/add/do";
        }
        [URLRequest postWithURL:urlstr params:params success:^(NSURLSessionDataTask *task, id responseObject) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([responseObject[@"state"] isEqualToString:@"success"]) {
                    [MBProgressHUD showSuccess:@"提交成功" toView:self.view];
                    _refreshVals(self.selectedIndex);
                    [self.navigationController popViewControllerAnimated:YES];
                }
            NSLog(@"%@",responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showMessage:@"网络问题,请检查网络设置" toView:self.view];
            NSLog(@"%@",error);
        }];
        
    }else{
        [MBProgressHUD showError:@"内容不能为空" toView:self.view];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.attrsName resignFirstResponder];
    [self.attrsPrice resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)selectedTypePress:(UIButton *)sender {
    declareWeakSelf;
    NSLog(@"fff");
    CDZPickerBuilder *builder = [[CDZPickerBuilder alloc]init];
    builder.confirmTextColor = UIColorFromRGBA(68, 195, 34, 1);
    builder.cancelTextColor = UIColorFromRGBA(68, 195, 34, 1);
    
    
    [CDZPicker showSinglePickerInView:self.view withBuilder:builder strings:weakSelf.NameArray confirm:^(NSArray<NSString *> * _Nonnull strings, NSArray<NSNumber *> * _Nonnull indexs) {
        NSLog(@"%@ \n%@",strings,indexs);
        [weakSelf.typeNameBtn setTitle:strings[0] forState:UIControlStateNormal];
        weakSelf.selectedID = weakSelf.typeIDarray[[indexs[0] intValue]];
        NSLog(@"%@\n%@",weakSelf.selectedID,weakSelf.typeIDarray);
    } cancel:^{
        
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
