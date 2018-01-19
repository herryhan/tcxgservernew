//
//  activityStateViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/7.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "activityStateViewController.h"
#import "activityModel.h"
#import "activityTableViewCell.h"


@interface activityStateViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *actTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger pageCount;

@end

@implementation activityStateViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(UITableView *)actTableView{
    if (!_actTableView) {
        _actTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight- 48*KWidth_ScaleW) style:UITableViewStyleGrouped];
        _actTableView.delegate = self;
        _actTableView.dataSource = self;
        _actTableView.backgroundColor = [UIColor clearColor];
        _actTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _actTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        [footer setTitle:@"我可是有底线的哦" forState:MJRefreshStateNoMoreData];
        _actTableView.mj_footer = footer;
        [self.view addSubview:_actTableView];
    }
    return _actTableView;
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
    //[self requestData];
    [self.actTableView.mj_header beginRefreshing];

}
- (void)requestData{
    
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"state"] = @(self.index);
    parmas[@"page"] = @(self.pageCount);
    parmas[@"max"] = @(5);
    parmas[@"uuid"] = [keepData getUUID];
    [URLRequest postWithURL:@"sp/active/list" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
            if (self.pageCount == 1) {
                [self.dataArray removeAllObjects];
                self.dataArray =[NSMutableArray arrayWithArray:[NSArray modelArrayWithClass:[activityModel class] json:responseObject[@"actives"]]];
                [self.actTableView reloadData];
                [self.actTableView.mj_footer resetNoMoreData];
                [self.actTableView.mj_header endRefreshing];
            }else{
                NSArray *arr = [NSMutableArray arrayWithArray:[NSArray modelArrayWithClass:[activityModel class] json:responseObject[@"actives"]]];
                [self.dataArray addObjectsFromArray:arr];
                [self.actTableView reloadData];
                if (arr.count == 0) {
                    
                    [self.actTableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.actTableView.mj_footer endRefreshing];
                }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        [self.actTableView.mj_header endRefreshing];
        [self.actTableView.mj_footer endRefreshing];
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
    declareWeakSelf;
    static NSString *cellid=@"activityTableViewCell";
    activityTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"activityTableViewCell" owner:self options:nil].firstObject;
    }
    cell.model = self.dataArray[indexPath.section];
    [cell setDelActivity:^(NSNumber *type_id) {
        NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
        parmas[@"uuid"] = [keepData getUUID];
        parmas[@"id"] = type_id;
        [URLRequest postWithURL:@"sp/active/del" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"fffff%@",responseObject);
                [weakSelf requestData];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
    
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
