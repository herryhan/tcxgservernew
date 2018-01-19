//
//  settingViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/2.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "settingViewController.h"
#import "shopSettingsView.h"
#import "KeyboardToolBar.h"
#import "DUX_UploadUserIcon.h"
@interface settingViewController ()<DUX_UploadUserIconDelegate>

@property (nonatomic,strong)shopSettingsView *settingView;
@property (nonatomic,strong) UIScrollView *settingScroller;
@property (nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,strong) NSArray *nameArray;
@property (nonatomic,assign) NSInteger indexTag;

@end

@implementation settingViewController

- (NSMutableArray *)imageArray{
    
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc]init];

    }
    return _imageArray;
}

- (NSArray *)nameArray{
    
    if (!_nameArray) {
        _nameArray = [[NSArray alloc]init];
        _nameArray = @[@"logo",@"pic1",@"pic2",@"pic3",@"pic4",@"pic5",@"pic6",@"pic7",@"pic8",@"pic9"];
    }
    return _nameArray;
}

- (UIScrollView *)settingScroller{
    
    if (!_settingScroller) {
        _settingScroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH,SCREEN_HEIGHT-SafeAreaTopHeight)];
        _settingScroller.contentSize = CGSizeMake(SCREEN_WIDTH, 1470);
        
    }
    
    return _settingScroller;
    
}

- (void)configRightBar{
    
    UIButton *rightBar = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBar.frame =CGRectMake(0, 0, 50, 30);
    
    [rightBar setTitle:@"提交" forState:UIControlStateNormal];
    [rightBar addTarget:self action:@selector(submitPress) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBar];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)submitPress{
    
    [MBProgressHUD showMessage:@"提交中" toView:self.view];
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    
    parmas[@"name"] = self.settingView.shopNameText.text;
    parmas[@"tel"] = self.settingView.connectPhoneText.text;
    parmas[@"qq"] = self.settingView.qqText.text;
    parmas[@"address"] = self.settingView.addressText.text;
    parmas[@"address2"] = self.settingView.getAddressText.text;
    parmas[@"contactTel"] = self.settingView.mangerPhoneText.text;
    parmas[@"contactName"] = self.settingView.mangerNameText.text;
    parmas[@"bankName"] = self.settingView.bankNameText.text;
    parmas[@"bankNo"] = self.settingView.bankCardNum.text;
    parmas[@"bankRealname"] = self.settingView.creditCardUserNameText.text;
    parmas[@"uuid"] = [keepData getUUID];
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    NSMutableArray *imageNameArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<10; i++) {
        UIImageView *imageV = [self.settingView viewWithTag:501+i];
        if (imageV.image !=nil) {
            [imageArray addObject:imageV.image];
            if (i == 0) {
                [imageNameArray addObject:@"logo"];
            }else{
                [imageNameArray addObject:[NSString stringWithFormat:@"pic%d",i]];
            }
        }
    }
    [URLRequest postWithURL:@"sp/update/do" params:parmas formDataArray:imageArray name:imageNameArray success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([responseObject[@"state"] isEqualToString:@"success"]) {
                [MBProgressHUD showSuccess:@"提交成功" toView:self.view];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [MBProgressHUD showError:responseObject[@"msg"] toView:self.view];
            }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         [MBProgressHUD showError:@"网络问题,请检查网络" toView:self.view];
    }];

}

- (shopSettingsView *)settingView{
    declareWeakSelf;
    
    if (!_settingView) {
        _settingView = [[shopSettingsView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1470)];
        for (int i = 1; i<11; i++) {
            UITextField *tex = [_settingView viewWithTag:700+i];
            [KeyboardToolBar registerKeyboardToolBar:tex];
        }
        [_settingView setUploadImage:^(NSInteger tag) {
          
    
            [UPLOAD_IMAGE showActionSheetInFatherViewController:weakSelf WithShowDel:NO AndtagIndex:tag WithTitle:@"" delegate:weakSelf];
            weakSelf.indexTag = tag;
            
        }];
        
    }
    return _settingView;
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self contitle:@"店铺设置"];
    [self configRightBar];
    
    [self.view addSubview:self.settingScroller];
    [self.settingScroller addSubview:self.settingView];
    [self getInfo];
    
}

- (void)getInfo{
    [MBProgressHUD showMessage:@"" toView:self.view];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"uuid"] = [keepData getUUID];

    [URLRequest postWithURL:@"sp/update" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([responseObject[@"state"] isEqualToString:@"failed"]) {
                [MBProgressHUD showError:responseObject[@"msg"] toView:self.view];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self.settingView setDataDic:responseObject];
                
            }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
         [MBProgressHUD showError:@"网络问题,请检查网络" toView:self.view];
    }];
}

- (void)uploadImageToServerWithImage:(UIImage *)image {

    UIImageView *imageView = [self.settingView viewWithTag:self.indexTag-100];
    imageView.image = image;
//    [self.imageArray addObject:image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
