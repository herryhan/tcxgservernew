//
//  LoginViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/22.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "LoginViewController.h"
#import "homeViewController.h"
#import "keepData.h"
#import "BPush.h"
#import <MediaPlayer/MediaPlayer.h>
#import "locateModel.h"
#import "CDZPicker.h"

@interface LoginViewController ()<UITextFieldDelegate,AVAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UIView *userNameBgView;
@property (weak, nonatomic) IBOutlet UIView *pwdBGview;
@property (weak, nonatomic) IBOutlet UIButton *logBtn;
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *pwdText;
@property (nonatomic , strong) AVAudioPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UIView *locateBgView;
@property (nonatomic, strong) NSMutableArray *locateArray;
@property (weak, nonatomic) IBOutlet UILabel *slectedLocateLabel;
@property (nonatomic,assign) int locateSelectedIndex;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    
    self.locateArray = [[NSMutableArray alloc]init];
    [URLRequest getWithURL:@"http://ha.tongchengxianggou.com/api/sp/locatelist" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        [self.locateArray addObjectsFromArray:[NSArray modelArrayWithClass:[locateModel class] json:[cityShoppingTool jsonConvertToDic:responseObject][@"locateInfo"]]];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self uiconfig];
    
}

- (void)uiconfig{
    self.userNameBgView.layer.cornerRadius = 20;
    self.pwdBGview.layer.cornerRadius = 20;
    self.userNameBgView.backgroundColor = UIColorFromRGBA(238, 238, 238, 1);
    self.pwdBGview.backgroundColor = UIColorFromRGBA(238, 238, 238, 1);
    self.locateBgView.backgroundColor = UIColorFromRGBA(238, 238, 238, 1);
    self.locateBgView.layer.cornerRadius = 20;
    self.logBtn.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
    self.logBtn.layer.cornerRadius = 20;
    self.userNameText.delegate = self;
    self.pwdText.delegate = self;
    [self.logBtn addTarget:self action:@selector(loginPress) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedLocate)];
    [self.slectedLocateLabel addGestureRecognizer:tapGes];
    self.slectedLocateLabel.userInteractionEnabled = YES;
    
 
    if ([keepData getLocateName].length!=0) {
        self.slectedLocateLabel.text = [keepData getLocateName];
        self.slectedLocateLabel.textColor = [UIColor blackColor];
    }
}

- (void)selectedLocate{
    declareWeakSelf;
    NSLog(@"%@",self.locateArray);
    NSMutableArray *nameArray = [[NSMutableArray alloc]init];
    
    if (self.locateArray.count !=0) {
        
        for (locateModel *model in self.locateArray) {
            [nameArray addObject:model.locateName];
        }
        CDZPickerBuilder *builder = [[CDZPickerBuilder alloc]init];
        builder.confirmTextColor = UIColorFromRGBA(68, 195, 34, 1);
        builder.cancelTextColor = UIColorFromRGBA(68, 195, 34, 1);
        
        [CDZPicker showMultiPickerInView:self.view withBuilder:builder stringArrays:@[nameArray] confirm:^(NSArray<NSString *> * _Nonnull strings, NSArray<NSNumber *> * _Nonnull indexs) {
            weakSelf.locateSelectedIndex = [indexs[0] intValue];
            weakSelf.slectedLocateLabel.text = strings[0];
            weakSelf.slectedLocateLabel.textColor = [UIColor blackColor];
            locateModel *model = weakSelf.locateArray[weakSelf.locateSelectedIndex];
            [keepData keepLocateId:model.locateId];
            [keepData keepLocateUrl:model.locateUrl];
            [keepData keepLocateName:model.locateName];
            
        } cancel:^{
            
        }];
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.userNameText resignFirstResponder];
    [self.pwdText resignFirstResponder];
    
}

- (void)loginPress{
    
    [MBProgressHUD showMessage:@"登陆中" toView:self.view];
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    
    if ([keepData getLoginState]) {
         parmas[@"uuid"] = [keepData getUUID];
    }else{
         parmas[@"uuid"] = self.LoginUUID;
    }
    parmas[@"channelId"] = [keepData getchannelid];
    parmas[@"os"] = @"ios";
    parmas[@"username"] = self.userNameText.text;
    parmas[@"pwd"] = self.pwdText.text;
    
    if ([keepData getLocateId]!=nil) {
        parmas[@"locateId"] = [keepData getLocateId];
    }
  
    
    [URLRequest postWithURL:@"sp/login"  params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {

        NSLog(@"res:%@",responseObject);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([responseObject[@"state"] isEqualToString:@"ok"]) {
            //保存相关用户数据
            [keepData keepChannelid:responseObject[@"channelId"]];
            [keepData keepUUID:responseObject[@"uuid"]];
            [keepData keepUser:self.userNameText.text];
            [keepData keepPwd:self.pwdText.text];
            
            [MBProgressHUD showSuccess:@"登陆成功" toView:self.view];
            [keepData keepLoginState:YES];
            
            JTBaseNavigationController * rootView = nil;
            homeViewController *firsttab = [[homeViewController alloc] init];

            JTNavigationController *firstNav = [[JTNavigationController alloc] initWithRootViewController:firsttab];
            rootView = [[JTBaseNavigationController alloc]initWithRootViewController:firstNav];
            if (del.isExitByUseer) {
                [self dismissViewControllerAnimated:YES completion:^{
                    del.isExitByUseer = NO;
                }];
            }else{
                del.window.rootViewController = rootView;
            }
        }else{
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         [MBProgressHUD showError:responseObject[@"msg"] toView:self.view];
        }
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"%@",error);
    }];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:2 animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
    
    return YES;
    
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

@end
