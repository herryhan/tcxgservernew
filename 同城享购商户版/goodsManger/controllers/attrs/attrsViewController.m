//
//  attrsViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/12.
//  Copyright © 2017年 韩先炜. All rights reserved.

#import "attrsViewController.h"
#import "addAttrsTypeViewController.h"
#import "addValsViewController.h"
#import "attrsLeftTableViewCell.h"
#import "attrsTypeModel.h"
#import "attrsValModel.h"
#import "attrsRightTableViewCell.h"

@interface attrsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *attrsTypeArray;
@property (nonatomic,strong) NSMutableArray *attrsValuesArray;
@property (nonatomic,strong) UITableView *leftTableView;
@property (nonatomic,strong) UITableView *rightTableView;
@property (nonatomic,strong) UIButton *addNewAttrsBtn;
@property (nonatomic,strong) UIButton *addNewAttrsValsBtn;
@property (nonatomic,assign) NSInteger leftSelectedIndex;

@end

@implementation attrsViewController

- (UIButton *)addNewAttrsBtn{
    if (!_addNewAttrsBtn) {
        _addNewAttrsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addNewAttrsBtn.backgroundColor = UIColorFromRGBA(226, 226, 226, 1);
        _addNewAttrsBtn.frame = CGRectMake(0, SCREEN_HEIGHT-SafeAreaBottomHeight, 100, SafeAreaBottomHeight);
        _addNewAttrsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 15, 20, 20)];
        [image setImage:[UIImage imageNamed:@"add2"]];
        [_addNewAttrsBtn addSubview:image];
        UILabel *titileLabel = [[UILabel alloc]initWithFrame:CGRectMake(27,14.5,68,20)];
        titileLabel.font= [UIFont systemFontOfSize:15];
        titileLabel.textColor = UIColorFromRGBA(80, 80, 80, 1);
        titileLabel.text = @"新增属性";
        [_addNewAttrsBtn addSubview:titileLabel];
        [_addNewAttrsBtn addTarget:self action:@selector(addNewAttrsPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addNewAttrsBtn;
}

- (void)addNewAttrsPress{
    declareWeakSelf;
    addAttrsTypeViewController *addTypeVC = [[addAttrsTypeViewController alloc]init];
    addTypeVC.goodsId = self.goodsID;
    addTypeVC.typeSelectdIndex = self.leftSelectedIndex;
    [addTypeVC setRefreshAttrsVals:^(NSInteger index) {
        [weakSelf requestData:index];
    }];
    [self.navigationController pushViewController:addTypeVC animated:YES];

}

- (UIButton *)addNewAttrsValsBtn{
    if (!_addNewAttrsValsBtn) {
        _addNewAttrsValsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addNewAttrsValsBtn addTarget:self action:@selector(addNewAttrsValsBtnPress) forControlEvents:UIControlEventTouchUpInside];
        _addNewAttrsValsBtn.backgroundColor = UIColorFromRGBA(246, 246, 246, 1);
        _addNewAttrsValsBtn.frame = CGRectMake(100, SCREEN_HEIGHT-SafeAreaBottomHeight, SCREEN_WIDTH-100, SafeAreaBottomHeight);
        _addNewAttrsValsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _addNewAttrsValsBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-100-20-77)/2, 15, 20, 20)];
        [image setImage:[UIImage imageNamed:@"add2"]];
        [_addNewAttrsValsBtn addSubview:image];
        UILabel *titileLabel = [[UILabel alloc]initWithFrame:CGRectMake(image.frame.origin.x+2+image.frame.size.width,14.5,77, 20)];
        titileLabel.font= [UIFont systemFontOfSize:15];
        titileLabel.textColor = UIColorFromRGBA(80, 80, 80, 1);
        titileLabel.text = @"新增属性值";
        [_addNewAttrsValsBtn addSubview:titileLabel];
    }
    return _addNewAttrsValsBtn;
}

- (void)addNewAttrsValsBtnPress{
    declareWeakSelf;
    if (self.attrsTypeArray.count!= 0 ) {
        addValsViewController *addValVc =[[addValsViewController alloc]init];
        addValVc.attrsTypeArray = self.attrsTypeArray;
        addValVc.selectedIndex = self.leftSelectedIndex;
        [addValVc setRefreshVals:^(NSInteger index) {
            [weakSelf requestData:index];
        }];
        [self.navigationController pushViewController:addValVc animated:YES];
    }else{
        [MBProgressHUD showError:@"暂无属性,请添加属性" toView:self.view];
    }
}

-(UITableView *)leftTableView{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, 100, SCREEN_HEIGHT-SafeAreaTopHeight-SafeAreaBottomHeight) style:UITableViewStyleGrouped];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.tag = 1001;
        _leftTableView.backgroundColor = UIColorFromRGBA(244, 245, 247, 1);
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_leftTableView];
    }
    return _leftTableView;
}

- (UITableView *)rightTableView{
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(100, SafeAreaTopHeight, SCREEN_WIDTH-100, SCREEN_HEIGHT-SafeAreaTopHeight-SafeAreaBottomHeight) style:UITableViewStyleGrouped];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.tag = 1002;
        _rightTableView.backgroundColor = [UIColor whiteColor];
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_rightTableView];
    }
    return _rightTableView;
}

- (NSMutableArray *)attrsTypeArray{
    if (!_attrsTypeArray) {
        _attrsTypeArray = [[NSMutableArray alloc]init];
    }
    return _attrsTypeArray;
}

- (NSMutableArray *)attrsValuesArray{
    if (!_attrsValuesArray) {
        _attrsValuesArray = [[NSMutableArray alloc]init];
    }
    return _attrsValuesArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self contitle:@"商品属性"];
    [self requestData:0];
    [self.view addSubview:self.addNewAttrsBtn];
    [self.view addSubview:self.addNewAttrsValsBtn];
}

- (void)requestData:(NSInteger)selectindex{
    declareWeakSelf;
    
    [MBProgressHUD showMessage:@"" toView:self.view];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"uuid"] = [keepData getUUID];
    params[@"id"] = self.goodsID;
    [URLRequest postWithURL:@"sp/product/attr/list" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([responseObject[@"state"] isEqualToString:@"error_addAttr"]) {
                [MBProgressHUD showError:@"无属性类别，请添加"];
                [weakSelf.attrsTypeArray removeAllObjects];
                [weakSelf.leftTableView reloadData];
                addAttrsTypeViewController *typeVC = [[addAttrsTypeViewController alloc]init];
                typeVC.goodsId = self.goodsID;
                typeVC.typeSelectdIndex = 0;
                
                [typeVC setRefreshAttrsVals:^(NSInteger index) {
                    [weakSelf requestData:index];
                }];
                [self.navigationController pushViewController:typeVC animated:YES];
            }else{
                [self.attrsTypeArray removeAllObjects];
                [self.attrsTypeArray addObjectsFromArray:[NSArray modelArrayWithClass:[attrsTypeModel class] json:responseObject[@"attrs"]]];
                [self.leftTableView reloadData];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:selectindex];
                [self.leftTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                if ([self.leftTableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
                    [self.leftTableView.delegate tableView:self.leftTableView didSelectRowAtIndexPath:indexPath];
                }
                
            }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:@"网络异常,请检查网络" toView:self.view];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView.tag == 1001) {
        
        return self.attrsTypeArray.count;
        
    }else{
        return self.attrsValuesArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    declareWeakSelf;
    if (tableView.tag == 1001) {
        static NSString *cellid=@"attrsLeftTableViewCell";
        attrsLeftTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"attrsLeftTableViewCell" owner:self options:nil].firstObject;
        }
        cell.model = self.attrsTypeArray[indexPath.section];
    [cell  setDelAttrsType:^(NSNumber *attrsTypeId) {
        [MBProgressHUD showMessage:@"" toView:self.view];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        params[@"attrId"] = attrsTypeId;
        params[@"id"] =self.goodsID;
        params[@"uuid"] =[keepData getUUID];
        
        [URLRequest postWithURL:@"sp/product/attr/del" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
            [MBProgressHUD hideHUDForView:self.view];
            NSLog(@"%@",responseObject);
            if ([responseObject[@"state"] isEqualToString:@"success"]) {
                
                if (weakSelf.leftSelectedIndex<=indexPath.section) {
                    if (indexPath.section == weakSelf.attrsTypeArray.count-1) {
                        if (weakSelf.leftSelectedIndex == 0) {
                              [weakSelf requestData:weakSelf.leftSelectedIndex];
                        }else if(weakSelf.leftSelectedIndex == weakSelf.attrsTypeArray.count-1){
                              [weakSelf requestData:weakSelf.leftSelectedIndex-1];
                        }else{
                            [weakSelf requestData:weakSelf.leftSelectedIndex];
                        }
                       
                    }else{
                        if (weakSelf.leftSelectedIndex == 0) {
                            [weakSelf requestData:weakSelf.leftSelectedIndex];
                        }else{
                             [weakSelf requestData:weakSelf.leftSelectedIndex - 1];
                        }
                        
                    }
                   
                }else{
                    [weakSelf requestData:weakSelf.leftSelectedIndex-1];
                }
            }else{
                
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    }];
        return cell;
    }else{
        static NSString *cellid=@"attrsRightTableViewCell";
        attrsRightTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"attrsRightTableViewCell" owner:self options:nil].firstObject;
        }
        cell.model = self.attrsValuesArray[indexPath.section];
        [cell setDelAttrsVals:^(attrsValModel *attrModel) {
            [MBProgressHUD showMessage:@"" toView:self.rightTableView];
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            params[@"uuid"] = [keepData getUUID];
            params[@"valId"] = attrModel.valId;
            
            [URLRequest postWithURL:@"sp/product/val/del" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
                [MBProgressHUD hideHUDForView:self.rightTableView animated:YES];
               
                    if ([responseObject[@"state"] isEqualToString:@"success"]) {
                        
                        [self requestData:self.leftSelectedIndex];
                        
                    }else{
                        [MBProgressHUD showError:@"系统原因,删除失败" toView:self.view];
                    }
                    NSLog(@"%@",responseObject);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",error);
            }];
            
        }];
        
        [cell setEditAttrsVals:^(attrsValModel *attrModel) {
            addValsViewController *addValVc =[[addValsViewController alloc]init];
            addValVc.attrsTypeArray = self.attrsTypeArray;
            addValVc.selectedIndex = self.leftSelectedIndex;
            addValVc.isEditing = YES;
            addValVc.selectedModel = attrModel;
            [addValVc setRefreshVals:^(NSInteger index) {
                NSLog(@"%ld",index);
                [weakSelf requestData:index];
            }];
             [weakSelf.navigationController pushViewController:addValVc animated:YES];
        }];
        
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (tableView.tag == 1001) {
        return 44;
    }else{
        return 128;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1001) {
        if (self.attrsTypeArray.count!=0) {
            self.leftSelectedIndex = indexPath.section;
            NSLog(@"%ld",self.leftSelectedIndex);
            attrsTypeModel *model = self.attrsTypeArray[indexPath.section];
            [self.attrsValuesArray removeAllObjects];
            [self.attrsValuesArray addObjectsFromArray:[NSArray modelArrayWithClass:[attrsValModel class] json:model.vals]];
            [self.rightTableView reloadData];
        }
    }
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
