//
//  homeViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/23.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "homeViewController.h"
#import "headerView.h"
#import "mangerView.h"
#import "goodsMangerViewController.h"
#import "qrCodeViewController.h"
#import "openTimeViewController.h"
#import "settingViewController.h"
#import "sortTyopeViewController.h"
#import "addNewViewController.h"
#import "typeEditedViewController.h"

#import "orderViewController.h"
#import "activityBaseViewController.h"
#import "addNewActivityViewController.h"
#import "commentBaseViewController.h"
#import "cashHistoryViewController.h"
#import "changePwdViewController.h"
#import "keepData.h"
#import "LoginViewController.h"
#import "SZKNetWorkUtils.h"
#import "advViewController.h"
#import "shopCopyViewController.h"

@interface homeViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *contentScroller;
@property (nonatomic,strong) headerView *headerView;
@property (nonatomic,strong) UIButton *isOpenBtn;
@property (nonatomic,strong) UIActivityIndicatorView *activityView;
@property (nonatomic,strong) mangerView *mangerView;
@property (nonatomic,assign) NSInteger netStateIndex;

@end

@implementation homeViewController

- (mangerView *)mangerView{
    declareWeakSelf;
    if (!_mangerView) {
     
        _mangerView = [[mangerView alloc]initWithFrame:CGRectMake(0, 185, SCREEN_WIDTH, (55+(SCREEN_WIDTH-30)/4)*7-55+40)];
        [_mangerView setBtnClick:^(NSInteger tag) {
            if (weakSelf.netStateIndex != 0) {
                switch (tag) {
                    case 1001:{
                        NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[SPAccountTool account].sellerTel];
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                    }
                        break;
                        
                    case 1002:
                    {
                        goodsMangerViewController *goods = [[goodsMangerViewController alloc]init];
                        goods.isCutDown = NO;
                        goods.titleString = @"商品管理";
                        [weakSelf.navigationController pushViewController:goods animated:YES];
                        
                    }
                        break;
                    case 1003:
                    {
                        sortTyopeViewController *sortVC = [[sortTyopeViewController alloc]init];
                        sortVC.isSingle = YES;
                        
                        [weakSelf.navigationController pushViewController:sortVC animated:YES];
                        
                    }
                        break;
                    case 1004:
                    {
                        addNewViewController *addNew = [[addNewViewController alloc]init];
                        addNew.vcTitle = @"添加商品";
                        [weakSelf.navigationController pushViewController:addNew animated:YES];
                        
                    }
                        break;
                    case 1005:
                    {
                        typeEditedViewController *typeEditingVc = [[typeEditedViewController alloc]init];
                        typeEditingVc.isSingle = YES;
                        typeEditingVc.isAdd = YES;
                        [weakSelf.navigationController pushViewController:typeEditingVc animated:YES];
                    }
                        break;
                    case 1006:
                    {
                        orderViewController *orderVc = [[orderViewController alloc]init];
                        orderVc.index = 1;
                        [weakSelf.navigationController pushViewController:orderVc animated:YES];
                    }
                        break;
                    case 1007:{
                        orderViewController *orderVc = [[orderViewController alloc]init];
                        orderVc.index = 2;
                        [weakSelf.navigationController pushViewController:orderVc animated:YES];
                    }
                        break;
                    case 1008:{
                        orderViewController *orderVc = [[orderViewController alloc]init];
                        orderVc.index = 4;
                        [weakSelf.navigationController pushViewController:orderVc animated:YES];
                    }
                        break;
                    case 1009:{
                        orderViewController *orderVc = [[orderViewController alloc]init];
                        orderVc.index = 5;
                        [weakSelf.navigationController pushViewController:orderVc animated:YES];
                    }
                        break;
                    case 1010:{
                        activityBaseViewController *actVc = [[activityBaseViewController alloc]init];
                        actVc.index = 2;
                        [weakSelf.navigationController pushViewController:actVc animated:YES];
                    }
                        break;
                    case 1011:{
                        activityBaseViewController *actVc = [[activityBaseViewController alloc]init];
                        actVc.index = 1;
                        [weakSelf.navigationController pushViewController:actVc animated:YES];
                    }
                        break;
                    case 1012:{
                        activityBaseViewController *actVc = [[activityBaseViewController alloc]init];
                        actVc.index = 3;
                        [weakSelf.navigationController pushViewController:actVc animated:YES];
                    }
                        break;
                    case 1013:{
                        addNewActivityViewController *addVC = [[addNewActivityViewController alloc]init];
                        [weakSelf.navigationController pushViewController:addVC animated:YES];
                    }
                        break;
                    case 1014:{
                        commentBaseViewController *commentVc = [[commentBaseViewController alloc]init];
                        commentVc.index =2;
                        [weakSelf.navigationController pushViewController:commentVc animated:YES];
                    }
                        break;
                    case 1015:{
                        commentBaseViewController *commentVc = [[commentBaseViewController alloc]init];
                        commentVc.index =1;
                        [weakSelf.navigationController pushViewController:commentVc animated:YES];
                    }
                        break;
                    case 1016:{
                        commentBaseViewController *commentVc = [[commentBaseViewController alloc]init];
                        commentVc.index =3;
                        [weakSelf.navigationController pushViewController:commentVc animated:YES];
                    }
                        break;
                    case 1017:
                    {
                        qrCodeViewController *qrVc = [[qrCodeViewController alloc]init];
                        [weakSelf.navigationController pushViewController:qrVc animated:YES];
                        
                    }
                        break;
                    case 1018:
                    {
                        openTimeViewController *openVc = [[openTimeViewController alloc]init];
                        [weakSelf.navigationController pushViewController:openVc animated:YES];
                    }
                        break;
                    case 1019:
                    {
                        settingViewController *shopVc = [[settingViewController alloc]init];
                        [weakSelf.navigationController pushViewController:shopVc animated:YES];
                    }
                        break;
                    case 1020:{
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定退出登陆？"
                                                                                                 message:@""
                                                                                          preferredStyle:UIAlertControllerStyleAlert ];
                        
                        //添加取消到UIAlertController中
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            //NSLog(@"ffff");
                        }];
                        
                        [alertController addAction:cancelAction];
                        
                        //添加确定到UIAlertController中
                        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                            [MBProgressHUD showMessage:@"" toView:weakSelf.view];
                            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
                            params[@"uuid"] = [keepData getUUID];
                            [URLRequest postWithURL:@"sp/logout" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
                                NSLog(@"%@",responseObject);
                                [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                                
                                if ([responseObject[@"state"] isEqualToString:@"success"]) {
                                    
                                    //删除所有的用户数据
                                    //[keepData removeUUID];
                                    [keepData removePwd];
                                    [keepData removeUser];
                                    [keepData keepLoginState:NO];
                                    del.isExitByUseer = YES;
                                    
                                    LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
                                    loginVC.LoginUUID = [keepData getUUID];
                                    [weakSelf presentViewController:loginVC animated:YES completion:^{
                                        
                                    }];
                                    [MBProgressHUD showSuccess:@"退出成功"];
                                }
                                
                            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                                [MBProgressHUD showError:@"退出失败" toView: weakSelf.view];
                            }];
                        }];
                        
                        [alertController addAction:OKAction];
                        
                        [weakSelf presentViewController:alertController animated:YES completion:nil];
                        
                    }
                        break;
                    case 1021:
                    {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://sport.tongchengxianggou.com/hetong/check/"]];

                    }
                        break;
                    case 1022:{
                        cashHistoryViewController *cashVC = [[cashHistoryViewController alloc]init];
                        [weakSelf.navigationController pushViewController:cashVC animated:YES];
                    }
                        break;
                    case 1023:{
                        
                        
                        changePwdViewController *pwdVc = [[changePwdViewController alloc]init];
                        [weakSelf.navigationController pushViewController:pwdVc animated:YES];
                    }
                        break;
                    case 1024:{
                        advViewController *advVc = [[advViewController alloc]init];
                        [weakSelf.navigationController pushViewController:advVc animated:YES];
                    }
                        break;
                    case 1025:{
                        
                        goodsMangerViewController *goods = [[goodsMangerViewController alloc]init];
                        goods.titleString = @"已下架";
                        goods.isCutDown = YES;
                        [weakSelf.navigationController pushViewController:goods animated:YES];
                        
                    }
                        break;
                    case 1027:{
                        shopCopyViewController *shopVC = [[shopCopyViewController alloc]init];
                        [weakSelf.navigationController pushViewController:shopVC animated:YES];
                    }
                        
                    default:
                        break;
                }
            }else{
                [MBProgressHUD showError:@"没有网络" toView:weakSelf.view];
            }
            
        }];
    }
    return _mangerView;
}

- (UIButton *)isOpenBtn{
    if (!_isOpenBtn) {
        _isOpenBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _isOpenBtn.frame = CGRectMake(0, SCREEN_HEIGHT-SafeAreaBottomHeight, SCREEN_WIDTH, SafeAreaBottomHeight);
        _isOpenBtn.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
        
        [_isOpenBtn setTitle:@"开始接单" forState:UIControlStateNormal];
        [_isOpenBtn addTarget:self action:@selector(openPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _isOpenBtn;
}
- (void)openPress{
    NSLog(@"%@  %@   %@",[SPAccountTool account].beginTime,[SPAccountTool account].endTime,[SPAccountTool account].stop);
    if ([[SPAccountTool account].beginTime isEqualToString:[SPAccountTool account].endTime]) {
        
        if ([[SPAccountTool account].stop isEqualToString:@"暂停营业"]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"未设置营业时间"
                                                                                     message:@"设置营业时间"
                                                                              preferredStyle:UIAlertControllerStyleAlert ];
            
            UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                openTimeViewController *openVc = [[openTimeViewController alloc]init];
                [self.navigationController pushViewController:openVc animated:YES];
                
            }];
            [alertController addAction:OKAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }

    }else{
        [MBProgressHUD showMessage:@"" toView:self.view];
        NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
        parmas[@"uuid"] = [keepData getUUID];
        if ([[SPAccountTool account].stop isEqualToString:@"营业"]) {
            parmas[@"stop"] = @(1);
        }else{
            parmas[@"stop"] = @(0);
        }
        NSLog(@"account %@",[SPAccountTool account].stop);
        [URLRequest postWithURL:@"sp/update/stop" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([responseObject[@"state"] isEqualToString:@"success"]) {
                [MBProgressHUD showSuccess:@"操作成功" toView:self.view];
                [self getNewUserInfo:NO];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@",error);
            
        }];
    }
}

-(headerView *)headerView{
    if (!_headerView) {
        _headerView = [[headerView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 185)];
       
    }
    return _headerView;
}

- (UIScrollView *)contentScroller{
    if (!_contentScroller) {
        _contentScroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight-SafeAreaBottomHeight)];
        _contentScroller.contentSize = CGSizeMake(SCREEN_WIDTH, (55+(SCREEN_WIDTH-30)/4)*7-55+185+40);
        _contentScroller.delegate = self;
    }
    return _contentScroller;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [SZKNetWorkUtils netWorkState:^(NSInteger netState) {
        self.netStateIndex = netState;
        
        switch (netState) {
            case 1:{
                NSLog(@"手机流量上网");
                [self getNewUserInfo:YES];
            }
                break;
            case 2:{
                NSLog(@"WIFI上网");
                [self getNewUserInfo:YES];
            }
                break;
            default:{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"网络连接失败"
                                                                                         message:@""
                                                                                  preferredStyle:UIAlertControllerStyleAlert ];
                
                //添加取消到UIAlertController中
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //NSLog(@"ffff");
                }];
                
                [alertController addAction:cancelAction];
                
                //添加确定到UIAlertController中
                UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"重新加载" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                    [self getNewUserInfo:NO];
                }];
                [alertController addAction:OKAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
                break;
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"InfoNotification" object:nil];
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
    [self contitle:@"同城享购商家版"];
    [self.view addSubview:self.contentScroller];
    [self.contentScroller addSubview:self.headerView];
    [self.view addSubview:self.isOpenBtn];
    [self uiconfig];
    [self getNewUserInfo:YES];
    
}

- (void)InfoNotificationAction:(NSNotification *)notification{
    [self getNewUserInfo:NO];
}

- (void)getNewUserInfo:(BOOL)isFirstLoad{
    declareWeakSelf;
   // [self.activityView startAnimating];
    if (isFirstLoad) {
         [MBProgressHUD showMessage:@"加载中" toView:self.view];
    }
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];

    parmas[@"uuid"] = [keepData getUUID];
    parmas[@"os"] = @"ios";
    parmas[@"channelId"] = [keepData getchannelid];
 
    [URLRequest postWithURL:@"sp/index" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([responseObject[@"state"] isEqualToString:@"success"]) {
            NSLog(@"%@",responseObject);
            SPAccount *acc= [SPAccount accountWithDict:responseObject];
            [SPAccountTool saveAccount:acc];
            [weakSelf.headerView setValuesWith:acc];
            if (acc.sellerTel.length!=0) {
                weakSelf.mangerView.sellersInfoString = [NSString stringWithFormat:@"客户经理:%@ %@",acc.seller,acc.sellerTel];
            }else{
                weakSelf.mangerView.sellersInfoString = @"您暂无客户经理";
            }
            
            NSLog(@"%@   resppppp:%@",acc.stop,responseObject[@"stop"]);
            if ([acc.stop isEqualToString:@"营业"] ) {
                
                [self.isOpenBtn setTitle:@"暂停营业" forState:UIControlStateNormal];
            }else{
                [self.isOpenBtn setTitle:@"开始接单" forState:UIControlStateNormal];
            }
            
        }else if ([responseObject[@"state"] isEqualToString:@"failed"]){
            [MBProgressHUD showError:@"未知错误" toView:self.view];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:@"网络错误,请检查网络设置"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)uiconfig{

    [self.contentScroller addSubview:self.mangerView];
  //  [self.activityView startAnimating];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y<0) {
        
        CGRect rect = self.headerView.frame;
        rect.origin.y = scrollView.contentOffset.y;
        rect.size.height = 185;
        self.headerView.frame = rect;
    }
    
}

-(UIImage*)createImageWithColor:(UIColor*)color andSize:(CGSize)size
{
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end
