//
//  openTimeViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/2.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "openTimeViewController.h"
#import "ZSPickView.h"
#import "CDZPicker.h"

@interface openTimeViewController ()
@property (nonatomic,strong)NSMutableArray *appointmentArray;
@property (nonatomic,assign)NSInteger dayIndex;

@end

@implementation openTimeViewController
- (NSMutableArray *)appointmentArray{
    if (!_appointmentArray) {
        _appointmentArray = [[NSMutableArray alloc]init];
        for (int i = 0; i<5; i++) {
            [_appointmentArray addObject:[NSString stringWithFormat:@"可预约%d天后订单",i+1]];
        }
        [_appointmentArray insertObject:@"只接受当天订单" atIndex:0];
    }
    return _appointmentArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self contitle:@"营业时间"];
    [self request];
    [self uiconfig];
}

- (void)request{
    
    [MBProgressHUD showMessage:@"" toView:self.view];
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"uuid"] = [keepData getUUID];
    [URLRequest postWithURL:@"sp/update/time" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"%@",responseObject);
        if ([responseObject[@"state"] isEqualToString:@"login"]) {
            [self request];
        }else{
            [self updateView:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:@"网络错误,请检查网络" toView:self.view];
    }];
}
- (void)updateView:(NSDictionary *)dic{
    [self.openBtn setTitle:dic[@"beginTime"] forState:UIControlStateNormal];
    [self.endBtn setTitle:dic[@"endTime"] forState:UIControlStateNormal];
    if ([dic[@"preOpenDay"] intValue]!=0) {
        [self.appointmentBtn setTitle:self.appointmentArray[[dic[@"preOpenDay"] intValue]-1] forState:UIControlStateNormal];
    }else{
        [self.appointmentBtn setTitle:@"只接受当天订单" forState:UIControlStateNormal];
    }
    
}
- (void)uiconfig{
    
    self.submitBtn.layer.cornerRadius = 5;
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
    
    [self.openBtn setTitle:[SPAccountTool account].beginTime forState:UIControlStateNormal];
    [self.endBtn setTitle:[SPAccountTool account].endTime forState:UIControlStateNormal];
    
    self.firstConstraint.constant = SafeAreaTopHeight + 15;
    self.secondConstraint.constant = SafeAreaTopHeight+ 10;
    
}
- (IBAction)openTimeBtn:(UIButton *)sender {
    declareWeakSelf;
    NSMutableArray *leftArray = [[NSMutableArray alloc]init];
    for (int i = 9; i<21; i++) {
        if (i==9) {
            [leftArray addObject:[NSString stringWithFormat:@"0%d",i]];
        }else{
            [leftArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
    }
    NSMutableArray *rightArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<60; i++) {
        NSString *str;
        if (i<10) {
            str = [NSString stringWithFormat:@"0%d",i];
        }else{
            str = [NSString stringWithFormat:@"%d",i];
        }
        [rightArray addObject:str];
    }
    switch (sender.tag) {
        case 601:{
            
            
            CDZPickerBuilder *builder = [[CDZPickerBuilder alloc]init];
            builder.confirmTextColor = UIColorFromRGBA(68, 195, 34, 1);
            builder.cancelTextColor = UIColorFromRGBA(68, 195, 34, 1);
            // builder.pickerTextColor = UIColorFromRGBA(68, 195, 34, 1);
            [CDZPicker showMultiPickerInView:self.view withBuilder:builder stringArrays:@[leftArray,rightArray] confirm:^(NSArray<NSString *> * _Nonnull strings, NSArray<NSNumber *> * _Nonnull indexs) {
                NSString *openTimeStr = [NSString stringWithFormat:@"%@:%@",strings[0],strings[1]];
                [weakSelf.openBtn setTitle:openTimeStr forState:UIControlStateNormal];
                
            } cancel:^{
                
            }];
        }
            break;
        case 602:{
            CDZPickerBuilder *builder = [[CDZPickerBuilder alloc]init];
            builder.confirmTextColor = UIColorFromRGBA(68, 195, 34, 1);
            builder.cancelTextColor = UIColorFromRGBA(68, 195, 34, 1);
            // builder.pickerTextColor = UIColorFromRGBA(68, 195, 34, 1);
            [CDZPicker showMultiPickerInView:self.view withBuilder:builder stringArrays:@[leftArray,rightArray] confirm:^(NSArray<NSString *> * _Nonnull strings, NSArray<NSNumber *> * _Nonnull indexs) {
                NSString *openTimeStr = [NSString stringWithFormat:@"%@:%@",strings[0],strings[1]];
                [weakSelf.endBtn setTitle:openTimeStr forState:UIControlStateNormal];
                
            } cancel:^{
                
            }];
        }
            break;
        case 603:{
            CDZPickerBuilder *builder = [[CDZPickerBuilder alloc]init];
            builder.confirmTextColor = UIColorFromRGBA(68, 195, 34, 1);
            builder.cancelTextColor = UIColorFromRGBA(68, 195, 34, 1);
            
            [CDZPicker showSinglePickerInView:self.view withBuilder:builder strings:weakSelf.appointmentArray confirm:^(NSArray<NSString *> * _Nonnull strings, NSArray<NSNumber *> * _Nonnull indexs) {
                NSLog(@"%@",strings);
                [weakSelf.appointmentBtn setTitle:strings[0] forState:UIControlStateNormal];
                weakSelf.dayIndex = [indexs[0] integerValue]+1;
                
            } cancel:^{
                
            }];
        }
            break;
        default:
            break;
    }
}

- (IBAction)submitPress:(UIButton *)sender {
    if ([self isSettingCorrectable:self.openBtn.titleLabel.text With:self.endBtn.titleLabel.text]) {
        [MBProgressHUD showMessage:@"更改中" toView:self.view];
        NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
        parmas[@"uuid"] = [keepData getUUID];
        parmas[@"endTime"] = self.endBtn.titleLabel.text;
        parmas[@"beginTime"] = self.openBtn.titleLabel.text;
        parmas[@"preOpenDay"] = @(self.dayIndex);
        [URLRequest postWithURL:@"sp/update/time/do" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
            if ([responseObject[@"state"] isEqualToString:@"success"]) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showSuccess:@"提交成功" toView:self.view];
                NSNotification *notification =[NSNotification notificationWithName:@"InfoNotification" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@",error);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:@"网络错误" toView:self.view];
        }];
    }else{
        [MBProgressHUD showError:@"请正确设置营业时间" toView:self.view];
    }
}
- (BOOL)isSettingCorrectable:(NSString *)timeBegin With:(NSString *)timeEnd{
    
    NSString *timeBeginStr = [timeBegin stringByReplacingOccurrencesOfString:@":" withString:@""];
    NSString *timeEndString = [timeEnd stringByReplacingOccurrencesOfString:@":" withString:@""];
    
    if ([[timeBeginStr substringToIndex:1] isEqualToString:@"0"]) {
        timeBeginStr  = [timeBeginStr stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:@""];
    }
    if ([[timeEndString substringToIndex:1] isEqualToString:@"0"]) {
        timeEndString = [timeEndString stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:@""];
    }
    NSLog(@"%@   %@",timeBeginStr,timeEndString);
    if ([timeEndString intValue]>[timeBeginStr intValue]) {
        return YES;
    }else{
        return NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

