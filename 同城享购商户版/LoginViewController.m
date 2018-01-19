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

@interface LoginViewController ()<UITextFieldDelegate,AVAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UIView *userNameBgView;
@property (weak, nonatomic) IBOutlet UIView *pwdBGview;
@property (weak, nonatomic) IBOutlet UIButton *logBtn;
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *pwdText;
@property (nonatomic , strong) AVAudioPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UIView *locateBgView;


@property (nonatomic, strong) NSMutableArray *locateArray;
@property (weak, nonatomic) IBOutlet UILabel *selectedText;

@end


@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    self.locateArray = [[NSMutableArray alloc]init];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self uiconfig];
    // Do any additional setup after loading the view from its nib.
}
- (void)uiconfig{
    self.userNameBgView.layer.cornerRadius = 20;
    self.pwdBGview.layer.cornerRadius = 20;
    self.userNameBgView.backgroundColor = UIColorFromRGBA(238, 238, 238, 1);
    self.pwdBGview.backgroundColor = UIColorFromRGBA(238, 238, 238, 1);
    self.locateBgView.backgroundColor = UIColorFromRGBA(238, 238, 238, 1);
    self.locateBgView.layer.cornerRadius = 20;
    self.logBtn.backgroundColor = UIColorFromRGBA(52, 176, 53, 1);
    self.logBtn.layer.cornerRadius = 20;
    self.userNameText.delegate = self;
    self.pwdText.delegate = self;
    self.locateText.delegate = self;
    [self.logBtn addTarget:self action:@selector(loginPress) forControlEvents:UIControlEventTouchUpInside];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.userNameText resignFirstResponder];
    [self.pwdText resignFirstResponder];
    [self.locateText resignFirstResponder];
    
}
- (void)loginPress{
    
    [MBProgressHUD showMessage:@"登陆中" toView:self.view];
    NSString *channelidStr = [BPush getChannelId];
    
    if ([keepData getUUID].length == 0) {
        
        del.udid = [self gen_uuid];

    }
  
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"uuid"] = del.udid;
    if ([keepData getchannelid].length == 0) {
        parmas[@"channelId"] = channelidStr;
    }else{
        parmas[@"channelId"] = [keepData getchannelid];
    }
    
    parmas[@"os"] = @"ios";
    parmas[@"username"] = self.userNameText.text;
    parmas[@"pwd"] = self.pwdText.text;
    parmas[@"locateId"] = @(1);
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
            
            JTBaseNavigationController * rootView = nil;
            homeViewController *firsttab = [[homeViewController alloc] init];

            JTNavigationController *firstNav = [[JTNavigationController alloc] initWithRootViewController:firsttab];
            rootView = [[JTBaseNavigationController alloc]initWithRootViewController:firstNav];
            if (del.isExitByUseer) {
                [self dismissViewControllerAnimated:YES completion:^{
                    
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

- (NSString *) gen_uuid
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return uuid;
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
