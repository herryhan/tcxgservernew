//
//  keyWordsViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/30.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "keyWordsViewController.h"
#import "goodsTypeTableViewCell.h"
#import "keepData.h"

#import "keywordsModel.h"

@interface keyWordsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *firstTab;
@property (nonatomic,strong) UITableView *secTab;
@property (nonatomic,strong) UITableView *thiTab;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *secDataArray;
@property (nonatomic,strong) NSMutableArray *secBranchArray;

@property (nonatomic,strong) NSMutableArray *thiDataArray;
@property (nonatomic,strong) NSMutableArray *thiBranchArray;
@property (nonatomic,strong) NSMutableArray *thiAllbranchArray;

@property NSInteger currentRow;

@end

@implementation keyWordsViewController

- (NSMutableArray *)thiAllbranchArray{

    if (!_thiAllbranchArray) {
        _thiAllbranchArray = [[NSMutableArray alloc]init];
    }
    return _thiAllbranchArray;

}
- (NSMutableArray *)thiBranchArray{
    if (!_thiBranchArray) {
        _thiBranchArray = [[NSMutableArray alloc]init];
    }
    return _thiBranchArray;
}
- (NSMutableArray *)secBranchArray{
    if (!_secBranchArray) {
        _secBranchArray = [[NSMutableArray alloc]init];
    }
    return _secBranchArray;
}
- (NSMutableArray *)thiDataArray{
    if (!_thiDataArray) {
        _thiDataArray = [[NSMutableArray alloc]init];
    }
    return _thiDataArray;
}

-(NSMutableArray *)secDataArray{
    if (!_secDataArray) {
        _secDataArray = [[NSMutableArray alloc]init];
    }
    return _secDataArray;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (UITableView *)firstTab{
    if (!_firstTab) {
        _firstTab = [[UITableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight, SCREEN_WIDTH/3, SCREEN_HEIGHT-SafeAreaTopHeight) style:UITableViewStyleGrouped];
        _firstTab.delegate = self;
        _firstTab.dataSource = self;
        _firstTab.tag = 1001;
        _firstTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _firstTab;
}

- (UITableView *)secTab{
    if (!_secTab) {
        _secTab = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, SafeAreaTopHeight, SCREEN_WIDTH/3, SCREEN_HEIGHT-SafeAreaTopHeight) style:UITableViewStylePlain];
        _secTab.delegate = self;
        _secTab.dataSource = self;
        _secTab.tag = 1002;
        _secTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _secTab;
}

- (UITableView *)thiTab{
    if (!_thiTab) {
        _thiTab = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, SafeAreaTopHeight, SCREEN_WIDTH/3, SCREEN_HEIGHT-SafeAreaTopHeight) style:UITableViewStylePlain];
        _thiTab.delegate = self;
        _thiTab.dataSource = self;
        _thiTab.tag = 1003;
        _thiTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _thiTab;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self uiconfig];
    [self requestKeyWord];
    
    NSLog(@"ceireicieicieei");
}
- (void)uiconfig{
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, 32, 100, 20)];
    titleLab.text = @"关键词选择";
    titleLab.textColor = [UIColor whiteColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self.navView addSubview:titleLab];
    
    [self.view addSubview:self.firstTab];
    [self.view addSubview:self.secTab];
    [self.view addSubview:self.thiTab];
    
    UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, SafeAreaTopHeight, 0.5, SCREEN_HEIGHT-SafeAreaTopHeight)];
    [lineImage setImage:[UIImage imageNamed:@"239色块"]];
    [self.view addSubview:lineImage];
    
    UIImageView *lineImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, SafeAreaTopHeight, 0.5, SCREEN_HEIGHT-SafeAreaTopHeight)];
    [lineImage2 setImage:[UIImage imageNamed:@"239色块"]];
    [self.view addSubview:lineImage2];
    
}
- (void)requestKeyWord{
    
    [MBProgressHUD showMessage:@"" toView:self.view];
    
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"uuid"] =[keepData getUUID];
    parmas[@"os"] = @"ios";
    parmas[@"channelId"] = [keepData getchannelid];

    
    [URLRequest postWithURL:@"sp/product/keywords" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
      
            for (NSDictionary *dic in responseObject[@"type"][@"type"]) {
                keywordsModel *model = [[keywordsModel alloc]init];
                model.typeName = dic[@"typeName"];
                
                [self.dataArray addObject:model];
                NSLog(@"%@",dic[@"typeName"]);
            }
            for (NSDictionary *dic in responseObject[@"type"][@"type"]) {
                NSMutableArray *keyWordsArray = [[NSMutableArray alloc]init];
                for (NSDictionary *typeDic in dic[@"types"]) {
                    
                    keywordsModel *model = [[keywordsModel alloc]init];
                    model.typeName = typeDic[@"typeName"];
                    NSLog(@"first:%@",typeDic);
                    
                    [keyWordsArray addObject:model];
                }
                [self.secDataArray addObject:keyWordsArray];
            }
            
            for (NSDictionary *dic in responseObject[@"type"][@"type"]) {
                NSMutableArray *nameArray = [[NSMutableArray alloc]init];
                
                for (NSDictionary *typeDic in dic[@"types"]) {
                    NSMutableArray *keyWordsArray = [[NSMutableArray alloc]init];
                    for (NSDictionary *nameDic in typeDic[@"types"]) {
                        keywordsModel *model = [[keywordsModel alloc]init];
                        model.typeName = nameDic[@"typeName"];
                        [keyWordsArray addObject:model];
                    }
                    [nameArray addObject:keyWordsArray];
                }
                [self.thiAllbranchArray addObject:nameArray];
            }
            
            [self.firstTab reloadData];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.firstTab selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
            if ([self.firstTab.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
                [self.firstTab.delegate tableView:self.firstTab didSelectRowAtIndexPath:indexPath];
            }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"keywords:%@",error);
    }];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 1001) {
        return self.dataArray.count;
    }else if (tableView.tag == 1002){
        return self.secBranchArray.count;
        
    }else{
        NSLog(@"thi:%ld",self.thiBranchArray.count);
        
        return self.thiBranchArray.count;
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (tableView.tag == 1001) {
        
        static NSString *cellid=@"goodsTypeTableViewCell";
        goodsTypeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"goodsTypeTableViewCell" owner:self options:nil].firstObject;
        }
        keywordsModel *model = [[keywordsModel alloc]init];
        model = self.dataArray[indexPath.row];
        [cell setKeyWordsModel:self.dataArray[indexPath.row]];
          return cell;
    }else if (tableView.tag == 1002){
        
        static NSString *cellid=@"goodsTypeTableViewCell";
        goodsTypeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"goodsTypeTableViewCell" owner:self options:nil].firstObject;
        }
        [cell setKeyWordsModel:self.secBranchArray[indexPath.row]];
        return cell;
    }
    else{
        static NSString *cellid=@"goodsTypeTableViewCell";
        goodsTypeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"goodsTypeTableViewCell" owner:self options:nil].firstObject;
        }
        [cell setKeyWordsModel:self.thiBranchArray[indexPath.row]];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 1001) {
        self.secBranchArray = self.secDataArray[indexPath.row];
        self.currentRow = indexPath.row;
        [self.secTab reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.secTab selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        if ([self.secTab.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            [self.secTab.delegate tableView:self.secTab didSelectRowAtIndexPath:indexPath];
        }
        
      
    }else if(tableView.tag == 1002){
        
        self.thiBranchArray = self.thiAllbranchArray[self.currentRow][indexPath.row];
        [self.thiTab reloadData];

    }else if (tableView.tag == 1003){
        NSLog(@"kjdhjhje");
       keywordsModel *model =  self.thiBranchArray[indexPath.row];
        NSLog(@"%@",model.typeName);
        
         [self dismissViewControllerAnimated:YES completion:^{
             _keyWordName(model.typeName);
          }];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    return 44;
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
- (void)add{
   // [self dismissViewControllerAnimated:YES completion:^{
        
  //  }];
    [self.firstTab reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
