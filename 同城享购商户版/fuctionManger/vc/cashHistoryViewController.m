//
//  cashHistoryViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/11.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "cashHistoryViewController.h"
#import "cashHistoryTableViewCell.h"
#import "cashModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
@interface cashHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *cashOrderTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger pageCount;

@end

@implementation cashHistoryViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (UITableView *)cashOrderTableView{
    if (!_cashOrderTableView) {
        _cashOrderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH,SCREEN_HEIGHT-SafeAreaTopHeight) style:UITableViewStyleGrouped];
        _cashOrderTableView.delegate = self;
        _cashOrderTableView.dataSource = self;
        _cashOrderTableView.backgroundColor = [UIColor clearColor];
        [_cashOrderTableView registerClass:[cashHistoryTableViewCell class] forCellReuseIdentifier:@"cashHistoryTableViewCell"];
        _cashOrderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _cashOrderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _cashOrderTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        
        MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        //footer.refreshingTitleHidden = YES;
        // footer
        [footer setTitle:@"我可是有底线的哦" forState:MJRefreshStateNoMoreData];
        _cashOrderTableView.mj_footer = footer;
        [self.view addSubview:_cashOrderTableView];
    }
    return _cashOrderTableView;
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
    [self contitle:@"提现记录"];
    // Do any additional setup after loading the view.
    [super didReceiveMemoryWarning];
    [self.cashOrderTableView.mj_header beginRefreshing];
}
- (void)requestData{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"uuid"] = [keepData getUUID];
    params[@"page"] = @(self.pageCount);
    params[@"max"] = @(5);
    [URLRequest postWithURL:@"sp/draw/list" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
     
            if (self.pageCount == 1) {
                [self.dataArray removeAllObjects];
                self.dataArray =[NSMutableArray arrayWithArray:[NSArray modelArrayWithClass:[cashModel class] json:responseObject[@"draws"]]];
                [self.cashOrderTableView.mj_header endRefreshing];
                [self.cashOrderTableView.mj_footer resetNoMoreData];
            }else{
                NSArray *arr = [NSMutableArray arrayWithArray:[NSArray modelArrayWithClass:[cashModel class] json:responseObject[@"draws"]]];;
                [self.dataArray addObjectsFromArray:arr];
                if (arr.count == 0) {
                    [self.cashOrderTableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.cashOrderTableView.mj_footer endRefreshing];
                }
            }
            [self.cashOrderTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        [MBProgressHUD showError:@"网络错误,请检查网络" toView:self.view];
        [self.cashOrderTableView.mj_header endRefreshing];
        [self.cashOrderTableView.mj_footer endRefreshing];
        
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
    cashHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cashHistoryTableViewCell" forIndexPath:indexPath];
    cashModel *model =self.dataArray[indexPath.section];
    cell.count = model.orderList.count;
    cell.model = model;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [tableView fd_heightForCellWithIdentifier:@"cashHistoryTableViewCell" cacheByIndexPath:indexPath configuration:^(cashHistoryTableViewCell * cell) {
        
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
