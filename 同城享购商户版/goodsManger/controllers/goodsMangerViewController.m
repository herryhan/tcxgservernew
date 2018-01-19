//
//  goodsMangerViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/25.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "goodsMangerViewController.h"
#import "goodsTypeModel.h"
#import "goodsTypeTableViewCell.h"

#import "goodsModel.h"
#import "goodsTableViewCell.h"

#import "sortTyopeViewController.h"
#import "addNewViewController.h"

#import "attrsViewController.h"
#import "keepData.h"

@interface goodsMangerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *goodsTypeTableView;
@property (nonatomic,strong)UITableView *goodsTableView;
@property (nonatomic,strong)NSMutableArray *goodsTypeArray;
@property (nonatomic,strong)NSMutableArray *goodsArray;
@property (nonatomic,strong)UILabel *headerLabel;
@property (nonatomic,strong)UIButton *mangerButton;
@property (nonatomic,strong)UIButton *addNewProduct;

@property (nonatomic,strong)NSIndexPath *currentIndex;

@property (nonatomic,assign)NSInteger typeSelectedIndex;

@property (nonatomic,strong) NSString *currentTypeId;

@end

@implementation goodsMangerViewController
- (UIButton *)mangerButton{
    if (!_mangerButton) {
        _mangerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _mangerButton.backgroundColor = UIColorFromRGBA(226, 226, 226, 1);
        _mangerButton.frame = CGRectMake(0, SCREEN_HEIGHT-SafeAreaBottomHeight, 100, SafeAreaBottomHeight);
        _mangerButton.titleLabel.font = [UIFont systemFontOfSize:14];
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 15, 20, 20)];
        [image setImage:[UIImage imageNamed:@"types"]];
        [_mangerButton addSubview:image];
        UILabel *titileLabel = [[UILabel alloc]initWithFrame:CGRectMake(27,14.5,68,20)];
        titileLabel.font= [UIFont systemFontOfSize:15];
        titileLabel.textColor = UIColorFromRGBA(80, 80, 80, 1);
        titileLabel.text = @"管理分类";
        [_mangerButton addSubview:titileLabel];
        [_mangerButton addTarget:self action:@selector(mangerButtonPress) forControlEvents:UIControlEventTouchUpInside];
        if (self.isCutDown) {
            _mangerButton.hidden = YES;
        }
    }
    return _mangerButton;
}
- (void)mangerButtonPress{
    declareWeakSelf;
    
    sortTyopeViewController *sortVc = [[sortTyopeViewController alloc]init];
    sortVc.typeArray = self.goodsTypeArray;
    [sortVc setType:^(NSArray *typeNewArray) {
        NSLog(@"xinNew:%@",typeNewArray);
        [weakSelf.goodsTypeTableView reloadData];
        NSLog(@"gffg%@",weakSelf.goodsTypeArray);
    }];

    [self.navigationController pushViewController:sortVc animated:YES];
    
}

- (UIButton *)addNewProduct{
    if (!_addNewProduct) {
        _addNewProduct = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addNewProduct addTarget:self action:@selector(addNewProductPress) forControlEvents:UIControlEventTouchUpInside];
        _addNewProduct.backgroundColor = UIColorFromRGBA(246, 246, 246, 1);
        _addNewProduct.frame = CGRectMake(100, SCREEN_HEIGHT-SafeAreaBottomHeight, SCREEN_WIDTH-100, SafeAreaBottomHeight);
        _addNewProduct.titleLabel.font = [UIFont systemFontOfSize:14];
        _addNewProduct.imageView.contentMode = UIViewContentModeScaleAspectFit;
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-100-20-63)/2, 15, 20, 20)];
        [image setImage:[UIImage imageNamed:@"add2"]];
        [_addNewProduct addSubview:image];
        UILabel *titileLabel = [[UILabel alloc]initWithFrame:CGRectMake(image.frame.origin.x+2+image.frame.size.width,14.5,63, 20)];
        titileLabel.font= [UIFont systemFontOfSize:15];
        titileLabel.textColor = UIColorFromRGBA(80, 80, 80, 1);
        titileLabel.text = @"新增商品";
        [_addNewProduct addSubview:titileLabel];
        if (self.isCutDown) {
            _addNewProduct.hidden = YES;
        }
    }
    return _addNewProduct;
    
}
- (void)addNewProductPress{
    
    addNewViewController *addVc = [[addNewViewController alloc]init];
    addVc.vcTitle = @"新增商品";
    [addVc setGoodsUpdate:^(NSIndexPath *indexPath) {
        [self.goodsTypeTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        if ([self.goodsTypeTableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            [self.goodsTypeTableView.delegate tableView:self.goodsTypeTableView didSelectRowAtIndexPath:indexPath];
        }
    }];
    NSMutableArray *typeNameArray = [[NSMutableArray alloc]init];
    NSMutableArray *typeIdArray = [[NSMutableArray alloc]init];
    if (self.goodsTypeArray.count!=0) {
        for (goodsTypeModel *model in self.goodsTypeArray) {
            [typeNameArray addObject:model.typeName];
            [typeIdArray addObject:model.typeId];
        }
        addVc.changeTypesArray = typeNameArray;
        addVc.typeIDArray = typeIdArray;
        addVc.typeBeginIndex = self.typeSelectedIndex;
        addVc.isAddGoodsInGoodsList = YES;
    
        [self.navigationController pushViewController:addVc animated:YES];
    }else{
        [MBProgressHUD showError:@"暂无商品分类,请添加" toView:self.view];
    }
}
- (UILabel *)headerLabel{
    if (!_headerLabel) {
        
        _headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, 30)];
        _headerLabel.text = @"  新增或修改需要审核才可以上架";
        _headerLabel.font = [UIFont systemFontOfSize:14];
        _headerLabel.backgroundColor = UIColorFromRGBA(33, 193, 172, 1);
        _headerLabel.textColor = [UIColor whiteColor];
        
    }
    return _headerLabel;
    
}
- (NSMutableArray *)goodsTypeArray{
    if (!_goodsTypeArray) {
        _goodsTypeArray = [[NSMutableArray alloc]init];
    }
    return _goodsTypeArray;
}
- (NSMutableArray *)goodsArray{
    if (!_goodsArray) {
        _goodsArray = [[NSMutableArray alloc]init];
    }
    return _goodsArray;
}

-(UITableView *)goodsTypeTableView{
    if (!_goodsTypeTableView) {
        if (!self.isCutDown) {
             _goodsTypeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, 100, SCREEN_HEIGHT-SafeAreaTopHeight-SafeAreaBottomHeight) style:UITableViewStyleGrouped];
        }else{
             _goodsTypeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, 100, SCREEN_HEIGHT-SafeAreaTopHeight) style:UITableViewStyleGrouped];
        }
        _goodsTypeTableView.delegate = self;
        _goodsTypeTableView.dataSource = self;
        _goodsTypeTableView.tag = 1001;
        _goodsTypeTableView.backgroundColor = UIColorFromRGBA(244, 245, 247, 1);
        _goodsTypeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _goodsTypeTableView;
}
-(UITableView *)goodsTableView{
    if (!_goodsTableView) {
        if (!self.isCutDown) {
             _goodsTableView = [[UITableView alloc]initWithFrame:CGRectMake(100, SafeAreaTopHeight, SCREEN_WIDTH-100, SCREEN_HEIGHT-SafeAreaTopHeight-SafeAreaBottomHeight) style:UITableViewStylePlain];
        }else{
             _goodsTableView = [[UITableView alloc]initWithFrame:CGRectMake(100, SafeAreaTopHeight, SCREEN_WIDTH-100, SCREEN_HEIGHT-SafeAreaTopHeight) style:UITableViewStylePlain];
            
        }
        _goodsTableView.delegate = self;
        _goodsTableView.dataSource = self;
        _goodsTableView.tag = 1002;
        _goodsTableView.backgroundColor = UIColorFromRGBA(244, 245, 247, 1);
        _goodsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    }
    return _goodsTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self contitle:self.titleString];
    [self.view addSubview:self.goodsTypeTableView];
    [self.view addSubview:self.goodsTableView];
    [self.view addSubview:self.mangerButton];
    [self.view addSubview:self.addNewProduct];
    self.goodsTableView.tableHeaderView = self.headerLabel;
    
    [self requestLeftData];
}
- (void)requestLeftData{
    
    declareWeakSelf;
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"uuid"] = [keepData getUUID];
    [MBProgressHUD showMessage:@"" toView:self.view];
    [URLRequest postWithURL:@"sp/shopList" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"%@",responseObject);
            [weakSelf.goodsTypeArray addObjectsFromArray:[NSArray modelArrayWithClass:[goodsTypeModel class] json:responseObject[@"shopTypes"]]];
            
            //如果店铺的商品分类的表为空 则提示用户需要添加分类
            if (weakSelf.goodsTypeArray.count == 0) {
                
                [MBProgressHUD showError:@"暂无商品分类,请添加" toView:self.view];
                
            }
            
            [weakSelf.goodsTypeTableView reloadData];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.goodsTypeTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
            if ([self.goodsTypeTableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
                [self.goodsTypeTableView.delegate tableView:self.goodsTypeTableView didSelectRowAtIndexPath:indexPath];
            }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        NSLog(@"error:%@",error);
        [MBProgressHUD showError:@"网络错误，请检查网络"];
        
    }];
}

- (void)requestRight:(NSString *)typeid{
    [MBProgressHUD showMessage:@"" toView:self.goodsTableView];
    declareWeakSelf;
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"uuid"] = [keepData getUUID];
    parmas[@"typeId"] = typeid;
    NSString *urlString;
    if (self.isCutDown) {
        urlString = @"sp/product/list/off";
    }else{
        urlString = @"sp/product/list";
    }
    [URLRequest postWithURL:urlString params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
        
         [MBProgressHUD hideHUDForView:self.goodsTableView animated:YES];
        
        NSLog(@"ssss %@",responseObject);
            [weakSelf.goodsArray removeAllObjects];
            [weakSelf.goodsArray addObjectsFromArray:[NSArray modelArrayWithClass:[goodsModel class] json:responseObject[@"products"]]];
            [weakSelf.goodsTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD showError:@"网络错误，请检查网络"];
        [MBProgressHUD hideHUDForView:self.goodsTableView animated:YES];
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView.tag == 1001) {
        
        return self.goodsTypeArray.count;
      
        
    }else{
        
        return self.goodsArray.count;
        
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    declareWeakSelf;
    if (tableView.tag == 1001) {
        static NSString *cellid=@"goodsTypeTableViewCell";
        goodsTypeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"goodsTypeTableViewCell" owner:self options:nil].firstObject;
        }
        cell.goodsTypeModel = self.goodsTypeArray[indexPath.section];
       // cell.backgroundColor = [UIColor redColor];
        return cell;
        
    }else{
        
        static NSString *cellid=@"goodsTableViewCell";
        goodsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"goodsTableViewCell" owner:self options:nil].firstObject;
        }
        goodsModel *infoModel = self.goodsArray[indexPath.section];
        cell.goodsInfoModel = infoModel;
        [cell setIsEditing:^(goodsModel *model) {
            addNewViewController *addvc = [[addNewViewController alloc]init];
            addvc.vcTitle = @"商品编辑";
            addvc.isEdited = YES;
            addvc.goodModel = model;
           
            addvc.pastKeyWordArray =  [model.keywords componentsSeparatedByString:@" "];
            
            [addvc setGoodsUpdate:^(NSIndexPath *indexPath) {
                [weakSelf.goodsTypeTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                if ([weakSelf.goodsTypeTableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
                    [weakSelf.goodsTypeTableView.delegate tableView:weakSelf.goodsTypeTableView didSelectRowAtIndexPath:indexPath];
                }
            }];
            NSMutableArray *typeNameArray = [[NSMutableArray alloc]init];
            NSMutableArray *typeIdArray = [[NSMutableArray alloc]init];
            
            for (goodsTypeModel *model in weakSelf.goodsTypeArray) {
                [typeNameArray addObject:model.typeName];
                [typeIdArray addObject:model.typeId];
            }
            
            addvc.changeTypesArray = typeNameArray;
            addvc.typeIDArray = typeIdArray;
            addvc.typeBeginIndex = self.typeSelectedIndex;
            
            [weakSelf.navigationController pushViewController:addvc animated:YES];
        }];
        [cell setUpDown:^(BOOL needUp) {
            if (needUp) {
                 [MBProgressHUD showMessage:@"下架中" toView:weakSelf.goodsTableView];
            }else{
                [MBProgressHUD showMessage:@"上架中" toView:weakSelf.goodsTableView];
            }
            
        
            //id（商品编号），state(商品状态，0:上架，1：下架)
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            params[@"id"] = infoModel.id;
            params[@"state"] = [NSNumber numberWithBool:![infoModel.state boolValue]];
            params[@"uuid"] = [keepData getUUID];
            params[@"typeId"] = weakSelf.currentTypeId;
            
            [URLRequest postWithURL:@"sp/product/update/state" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"%@",responseObject);
                [MBProgressHUD hideHUDForView:weakSelf.goodsTableView animated:YES];
               
                    if ([responseObject[@"state"] isEqualToString:@"success"]) {
                       // [MBProgressHUD showSuccess:@"操作成功" toView:weakSelf.goodsTableView];
                        [weakSelf.goodsTypeTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:weakSelf.typeSelectedIndex] animated:YES scrollPosition:UITableViewScrollPositionNone];
                        if ([weakSelf.goodsTypeTableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
                            [weakSelf.goodsTypeTableView.delegate tableView:weakSelf.goodsTypeTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:weakSelf.typeSelectedIndex]];
                        }
                        
                    }else{
                        [MBProgressHUD showSuccess:@"操作失败 " toView:weakSelf.goodsTableView];
                    }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
                NSLog(@"%@",error);
                
            }];
            
        }];
        [cell setEditedAttrs:^(NSNumber *goodsId) {
            attrsViewController *attrVc = [[attrsViewController alloc]init];
            attrVc.goodsID = infoModel.id;
            [weakSelf.navigationController pushViewController:attrVc animated:YES];
            
        }];
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (tableView.tag == 1001) {
        return 50;
    }else{
        return 121; 
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1001) {
        if (self.goodsTypeArray.count !=0) {
            goodsTypeModel *typeModel = [[goodsTypeModel alloc]init];
            typeModel = self.goodsTypeArray[indexPath.section];
            self.typeSelectedIndex = indexPath.section;
            self.currentTypeId = typeModel.typeId;
            [self requestRight:typeModel.typeId];
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

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end
