//
//  addNewActivityViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/7.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "addNewActivityViewController.h"
#import "activityView.h"
#import "ZSPickView.h"
#import "CCDatePickerView.h"
#import "goodsTypeModel.h"

@interface addNewActivityViewController ()

@property (nonatomic,strong) UIScrollView *scrView;
@property (nonatomic,strong) activityView *actView;
@property (nonatomic,strong) NSArray *manjianArray;
@property (nonatomic,strong) NSMutableArray *manjianCateArray;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger typeID;
@property (nonatomic,strong) NSNumber *discountNum;
@property (nonatomic,assign) NSInteger actCateNum;

@end

@implementation addNewActivityViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (NSArray *)manjianArray{
    
    if (!_manjianArray) {
        _manjianArray = @[@"满减活动",@"折扣活动",@"第二件半价活动"];
    }
    return _manjianArray;
}

- (UIScrollView *)scrView{
    if (!_scrView) {
        _scrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight)];
        _scrView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return _scrView;
}
- (activityView *)actView{
    declareWeakSelf;
    if (!_actView) {
        _actView = [[activityView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 385)];
        
        [_actView setSubmit:^(BOOL isTouchSubmit) {
           
            [MBProgressHUD showMessage:@"提交中" toView:weakSelf.view];
            
            ///api/sp/active/add
            //参数：beginTime（活动开始时间），endTime（活动结束时间），richMoney（交易需要达到的金额），
            //releaseMoney（达到活动要求的交易金额后抵扣的金额），discount（折扣，单位:百分比），cate（参数类型：整型。0:满减,1:折扣,2:半价），type_id（活动作用的商品类别的编号）
            NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
            parmas[@"beginTime"] =weakSelf.actView.beginTimeBtn.titleLabel.text;
            parmas[@"endTime"] = weakSelf.actView.endTimeBtn.titleLabel.text;
            parmas[@"richMoney"] = weakSelf.actView.fullText.text;
            parmas[@"releaseMoney"] = weakSelf.actView.subText.text;
            parmas[@"cate"] = @(weakSelf.actCateNum);
            parmas[@"type_id"] = @(weakSelf.typeID);
            parmas[@"uuid"] = [keepData getUUID];
            parmas[@"discount"] = weakSelf.actView.discontBtn.titleLabel.text;
            
            [URLRequest postWithURL:@"sp/active/add" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
                
                NSLog(@"fff%@",responseObject);
               
                    if ([responseObject[@"state"] isEqualToString:@"success"]) {
                        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                        [MBProgressHUD showSuccess:@"活动添加成功" toView:weakSelf.view];
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }else{
                        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                        [MBProgressHUD showSuccess:@"活动添加失败,检查添加内容" toView:weakSelf.view];
                    }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",error);
                [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                [MBProgressHUD showError:@"网络错误" toView:weakSelf.view];
            }];
            
        }];
        
        [_actView setDiscountSelected:^(BOOL isSelected) {
            
            ZSPickView *pick = [[ZSPickView alloc]initWithComponentArr:nil];
            NSMutableArray *discountArray = [[NSMutableArray alloc]init];
            for (int i = 10; i<99; i++) {
                [discountArray addObject:[NSNumber numberWithInt:i]];
            }
            pick.componentArr = @[discountArray];
            
            pick.sureBlock = ^(NSArray *arr){
                for (NSNumber *discountNum in arr) {
                    [weakSelf.actView.discontBtn setTitle:[NSString stringWithFormat:@"%@",discountNum] forState:UIControlStateNormal];
                    weakSelf.discountNum = discountNum;
                }
            };
            
            [weakSelf.view addSubview:pick];
            
        }];
        
        [_actView setSelectedGoodsType:^(BOOL isSelected) {
            
            ZSPickView *pick = [[ZSPickView alloc]initWithComponentArr:nil];
            NSMutableArray *titleArray = [[NSMutableArray alloc]init];
            [titleArray addObject:@"全品类"];
            
            for (goodsTypeModel *model in weakSelf.dataArray) {
                [titleArray addObject:model.typeName];
            }
            pick.componentArr = @[titleArray];
            pick.sureBlock = ^(NSArray *arr){
                for (NSString *typeString in arr) {
                     [weakSelf.actView.typeBtn setTitle:typeString forState:UIControlStateNormal];
                    for (int i = 1; i<titleArray.count; i++) {
                        if ([typeString isEqualToString:titleArray[i]]) {
                            goodsTypeModel *model = weakSelf.dataArray[i-1];
                            weakSelf.typeID =[model.typeId integerValue];
                        }
                    }
                }
               
            };
            [weakSelf.view addSubview:pick];
            
        }];
        
        [_actView setTimeSelected:^(BOOL isBeginTime) {
            if (isBeginTime) {
                
                CCDatePickerView *dateView=[[CCDatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
                [weakSelf.view addSubview:dateView];
            
                dateView.timeBlock = ^(NSString *timeString){
                    timeString = [timeString stringByAppendingString:@":00"];
                    
                    [weakSelf.actView.beginTimeBtn setTitle:timeString forState:UIControlStateNormal];
                    
                };
                
                dateView.chooseTimeLabel.text = @"选择时间";
                [dateView fadeIn];
                
            }else{
                
                CCDatePickerView *dateView=[[CCDatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
                [weakSelf.view addSubview:dateView];
                
                dateView.timeBlock = ^(NSString *timeString){
                    timeString = [timeString stringByAppendingString:@":59"];
                    
                    [weakSelf.actView.endTimeBtn setTitle:timeString forState:UIControlStateNormal];
                    
                };
                
                dateView.chooseTimeLabel.text = @"选择时间";
                [dateView fadeIn];
            }
        }];
        [_actView setFullAndSub:^(BOOL isShow) {
            
            ZSPickView *pick = [[ZSPickView alloc]initWithComponentArr:nil];
            
            pick.componentArr = @[weakSelf.manjianArray];
            pick.sureBlock = ^(NSArray *arr){
                for (NSString *str in arr) {
                    [weakSelf.actView.activityTypeBtn setTitle:str forState:UIControlStateNormal];
                    if ([str isEqualToString:@"折扣活动"]) {
                        weakSelf.actView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 335);
                        weakSelf.actView.fullWithsubView.hidden = YES;
                        weakSelf.actView.discontView.hidden = NO;
                        weakSelf.actCateNum = 1;
                    }
                    if ([str isEqualToString:@"满减活动"]) {
                        weakSelf.actView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 385);
                        weakSelf.actView.fullWithsubView.hidden = NO;
                        weakSelf.actView.discontView.hidden = YES;
                        weakSelf.actCateNum = 0;
                        
                    }
                    if ([str isEqualToString:@"第二件半价活动"]) {
                        weakSelf.actView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 285);
                        weakSelf.actView.fullWithsubView.hidden = YES;
                        weakSelf.actView.discontView.hidden = YES;
                        weakSelf.actCateNum = 2;
        
                    }
                }
            };
             [weakSelf.view addSubview:pick];
        }];
    }
    return _actView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self contitle:@"新增活动"];
    self.typeID = -1;
    
    [self.view addSubview:self.scrView];
    [self.scrView addSubview:self.actView];
    [self requestTypeData];
}
- (void)requestTypeData{
    declareWeakSelf;

    [MBProgressHUD showMessage:@"" toView:self.view];
    
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"uuid"] = [keepData getUUID];
    [URLRequest postWithURL:@"sp/shopList" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
    
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"%@",responseObject);
        [weakSelf.dataArray addObjectsFromArray:[NSArray modelArrayWithClass:[goodsTypeModel class] json:responseObject[@"shopTypes"]]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"error:%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:@"网络错误，请检查网络"];
        
    }];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

@end
