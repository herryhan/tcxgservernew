//
//  waitingOrderViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/5.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "waitingOrderViewController.h"
#import "orderModel.h"
#import "sendTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "orderInfoDownView.h"

@interface waitingOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *orderTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger pageCount;
@property (nonatomic,assign) NSInteger jjj;


@end

@implementation waitingOrderViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (UITableView *)orderTableView{
    if (!_orderTableView) {
        _orderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight- 48*KWidth_ScaleW) style:UITableViewStyleGrouped];
        _orderTableView.delegate = self;
        _orderTableView.dataSource = self;
        _orderTableView.backgroundColor = [UIColor clearColor];

        [_orderTableView registerClass:[sendTableViewCell class] forCellReuseIdentifier:@"sendTableViewCell"];
        
        _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _orderTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        
        MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        //footer.refreshingTitleHidden = YES;
        // footer
        [footer setTitle:@"我可是有底线的哦" forState:MJRefreshStateNoMoreData];
        _orderTableView.mj_footer = footer;
        [self.view addSubview:_orderTableView];
    }
    return _orderTableView;
}

- (void)refresh{
    self.pageCount = 1;
    [self requestData];
}
- (void)loadMoreData{
    self.pageCount +=1;
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.orderTableView.mj_header beginRefreshing];
    self.jjj=0;
    
    //[self requestData];
}

- (void)requestData{

    NSMutableDictionary *paramas = [[NSMutableDictionary alloc]init];
    paramas[@"state"] = @(self.index);
    paramas[@"page"] = @(self.pageCount);
    paramas[@"max"] = @(5);
    paramas[@"uuid"] = [keepData getUUID];
    
    [URLRequest postWithURL:@"sp/order/list" params:paramas success:^(NSURLSessionDataTask *task, id responseObject) {
       
            if (self.pageCount == 1) {
                [self.dataArray removeAllObjects];
                self.jjj = 0;
                self.dataArray =[NSMutableArray arrayWithArray:[NSArray modelArrayWithClass:[orderModel class] json:responseObject[@"array"]]];
                [self.orderTableView.mj_header endRefreshing];
                [self.orderTableView.mj_footer resetNoMoreData];
            }else{
                NSArray *arr = [NSMutableArray arrayWithArray:[NSArray modelArrayWithClass:[orderModel class] json:responseObject[@"array"]]];;
                
                if (arr.count <5) {
                    [self.orderTableView.mj_footer endRefreshing];
                    [self.orderTableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.orderTableView.mj_footer endRefreshing];
                }
                [self.dataArray addObjectsFromArray:arr];
            }
            [self.orderTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        [self.orderTableView.mj_header endRefreshing];
        [self.orderTableView.mj_footer endRefreshing];
        [MBProgressHUD showError:@"网络错误,请检查网络"];
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
    
}
// 设置单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid=@"sendTableViewCell";
    sendTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"sendTableViewCell" owner:self options:nil].firstObject;
    }
    orderModel *model = self.dataArray[indexPath.section];
    cell.model = model;
    cell.index =self.index;
   // self.jjj +=1;
    NSLog(@"jjj");
    orderInfoDownView *downView = [cell viewWithTag:501];
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"uuid"] = [keepData getUUID];
    parmas[@"id"] = model.id;
    declareWeakSelf;
    [downView setOrderDeal:^(NSInteger btnTag) {
        [MBProgressHUD showMessage:@"" toView:self.view];
        switch (btnTag) {
            case 201:{
                [URLRequest postWithURL:@"sp/order/take/yes" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    NSLog(@"ff:%@",responseObject);
                  
                        if ([responseObject[@"state"] isEqualToString:@"success"]) {
                            [MBProgressHUD showSuccess:@"接单成功" toView:self.view];
                            [weakSelf.dataArray removeObjectAtIndex:indexPath.section];
                            [weakSelf.orderTableView reloadData];
                        }else{
                            [MBProgressHUD showError:@"接单失败" toView:self.view];
                        }
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [MBProgressHUD showError:@"网络问题，请检查网络" toView:self.view];
                }];
            }
                break;
        
            case 202:{
                [URLRequest postWithURL:@"sp/order/take/no" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                        if ([responseObject[@"state"] isEqualToString:@"success"]) {
                            [MBProgressHUD showSuccess:@"已拒单" toView:self.view];
                            [weakSelf.dataArray removeObjectAtIndex:indexPath.section];
                            [weakSelf.orderTableView reloadData];
                        }else{
                            [MBProgressHUD showError:@"拒单失败" toView:self.view];
                        }
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [MBProgressHUD showError:@"网络问题，请检查网络" toView:self.view];
                }];
            }
                break;
            case 203:{
                [URLRequest postWithURL:@"sp/order/refund/yes" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    NSLog(@"ff:%@",responseObject);
                   
                        if ([responseObject[@"state"] isEqualToString:@"success"]) {
                            [MBProgressHUD showSuccess:@"已同意退款" toView:self.view];
                            [weakSelf.dataArray removeObjectAtIndex:indexPath.section];
                            [weakSelf.orderTableView reloadData];
                        }else{
                            [MBProgressHUD showError:@"退款失败" toView:self.view];
                        }
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                     [MBProgressHUD showError:@"网络问题，请检查网络" toView:self.view];
                }];
            }
                break;
            default:
                break;
        }
    }];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return [tableView fd_heightForCellWithIdentifier:@"sendTableViewCell" cacheByIndexPath:indexPath configuration:^(sendTableViewCell * cell) {
        
        cell.model = self.dataArray[indexPath.section];
        
    }];

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
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

@end
