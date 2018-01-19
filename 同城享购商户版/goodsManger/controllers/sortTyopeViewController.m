//
//  sortTyopeViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/27.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "sortTyopeViewController.h"
#import "sortTypeTableViewCell.h"
#import "typeEditedViewController.h"

@interface sortTyopeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *sortTableView;
@property (nonatomic,strong) UIButton *addNewType;

@end

@implementation sortTyopeViewController

- (UITableView *)sortTableView{
    
    if (!_sortTableView) {
        _sortTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight-SafeAreaBottomHeight) style:UITableViewStyleGrouped];
        _sortTableView.delegate = self;
        _sortTableView.dataSource= self;

    }
    return _sortTableView;
}

- (UIButton *)addNewType{
    if (!_addNewType) {
    
        _addNewType = [UIButton buttonWithType:UIButtonTypeCustom];
        _addNewType.frame = CGRectMake(0, SCREEN_HEIGHT-SafeAreaBottomHeight, SCREEN_WIDTH, SafeAreaBottomHeight);
        [_addNewType setTitle:@"新增分类" forState:UIControlStateNormal];
        _addNewType.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
        [_addNewType addTarget:self action:@selector(addNewTypePress) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _addNewType;
}
- (void)addNewTypePress{
    declareWeakSelf;
    NSLog(@"ffff");
    typeEditedViewController *typevc = [[typeEditedViewController alloc]init];
    typevc.isAdd = YES;
    
    [typevc setAddType:^(goodsTypeModel *model) {
        [weakSelf.typeArray addObject:model];
        [weakSelf.sortTableView reloadData];
        //_type(weakSelf.typeArray);
        if (!weakSelf.isSingle) {
            _type(weakSelf.typeArray);
        }
    }];
    
    [self.navigationController pushViewController:typevc animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self contitle:@"分类管理"];
    [self.view addSubview:self.sortTableView];
    [self.view addSubview:self.addNewType];
    
    NSLog(@"%@",self.typeArray);
    if (self.isSingle) {
        self.typeArray = [[NSMutableArray alloc]init];
        
        [self requestTypeArray];
    }else{
        
        [self.sortTableView reloadData];
    }
}

- (void)requestTypeArray{
    
    declareWeakSelf;
    
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"uuid"] = [keepData getUUID];
    [URLRequest postWithURL:@"sp/shopList" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
            [weakSelf.typeArray addObjectsFromArray:[NSArray modelArrayWithClass:[goodsTypeModel class] json:responseObject[@"shopTypes"]]];
            [weakSelf.sortTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"error:%@",error);
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.typeArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    declareWeakSelf;
    static NSString *cellid=@"sortTypeTableViewCell";
    sortTypeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"sortTypeTableViewCell" owner:self options:nil].firstObject;
    }
    cell.model = self.typeArray[indexPath.row];
    
    [cell setEidting:^(BOOL isEditing) {
        if (isEditing) {
            NSLog(@"edit");
            NSLog(@"%@",indexPath);
            typeEditedViewController *typyEditVc = [[typeEditedViewController alloc]init];
            typyEditVc.model = self.typeArray[indexPath.row];
            [typyEditVc setUpdateType:^(goodsTypeModel *model) {
                
                [weakSelf.typeArray replaceObjectAtIndex:indexPath.row withObject:model];
                [weakSelf.sortTableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
                NSLog(@"new:%@",weakSelf.typeArray);
                _type(weakSelf.typeArray);
                
            }];
            
            [weakSelf.navigationController pushViewController:typyEditVc animated:YES];
        }else{
            NSLog(@"del");
            
            goodsTypeModel *gmodel = weakSelf.typeArray[indexPath.row];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                                     message:@"确定删除此分类"
                                                                              preferredStyle:UIAlertControllerStyleAlert ];
            
            //添加取消到UIAlertController中
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:cancelAction];
            
            //添加确定到UIAlertController中
            UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                declareWeakSelf;
                [MBProgressHUD showMessage:@"删除中" toView:self.view];
                
                NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
                parmas[@"uuid"] = [keepData getUUID];
                parmas[@"id"]= gmodel.typeId;
                [URLRequest postWithURL:@"sp/type/del" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    NSLog(@"%@",responseObject);
                    if ([responseObject[@"state"] isEqualToString:@"success"]) {
                         [MBProgressHUD showSuccess:@"删除成功" toView:self.view];
                        [weakSelf.typeArray removeObjectAtIndex:indexPath.row];
                        if (!weakSelf.isSingle) {
                             _type(weakSelf.typeArray);
                        }
                        [weakSelf.sortTableView reloadData];
                    }else{
                        if ([responseObject[@"msg"] length]!=0) {
                            [MBProgressHUD showSuccess:responseObject[@"msg"] toView:self.view];
                        }
                    }
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    
                    NSLog(@"error:%@",error);
                    
                }];
                
                typeEditedViewController *typyEditVc = [[typeEditedViewController alloc]init];
                [typyEditVc setUpdateType:^(goodsTypeModel *model) {
                    
                    [weakSelf.typeArray replaceObjectAtIndex:indexPath.row withObject:model];
                    [weakSelf.sortTableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
                    NSLog(@"new:%@",weakSelf.typeArray);
                    _type(weakSelf.typeArray);
                    
                }];
               
                NSLog(@"fffffff");
            }];
            
            [alertController addAction:OKAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    }];
    
    return cell;
}
- (void)OKAction{
  
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v =[[UIView alloc] init];
    v.alpha=0;
    return v;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v =[[UIView alloc] init];
    v.alpha=0;
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}


@end
