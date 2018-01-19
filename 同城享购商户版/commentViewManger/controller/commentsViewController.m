//
//  commentsViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/9.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "commentsViewController.h"
#import "commentsModel.h"
#import "commentsTableViewCell.h"
#import "resViewController.h"

@interface commentsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *commentsTableView;
@property (nonatomic,assign) NSInteger pageCount;

@end

@implementation commentsViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (UITableView *)commentsTableView{
    if (!_commentsTableView) {
        _commentsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight-48*KWidth_ScaleW) style:UITableViewStyleGrouped];
        _commentsTableView.delegate = self;
        _commentsTableView.dataSource = self;
        _commentsTableView.backgroundColor = [UIColor clearColor];
        _commentsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _commentsTableView.estimatedRowHeight = 44.0f;//推测高度，必须有，可以随便写多少
        _commentsTableView.rowHeight =UITableViewAutomaticDimension;//iOS8之后默认就是这个值，可以省略
        _commentsTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        
        MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        //footer.refreshingTitleHidden = YES;
        // footer
        [footer setTitle:@"我可是有底线的哦" forState:MJRefreshStateNoMoreData];
        _commentsTableView.mj_footer = footer;
        [self.view addSubview:_commentsTableView];
    }
     return _commentsTableView;
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
    
    [self requestData];
    
}

- (void)requestData{
    
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"state"] = @(self.index);
    parmas[@"uuid"] = [keepData getUUID];
    parmas[@"page"] = @(self.pageCount);
    parmas[@"max"] = @(10);
    
    [URLRequest postWithURL:@"sp/comment/list" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
            if (self.pageCount == 1) {
                [self.dataArray removeAllObjects];
                self.dataArray =[NSMutableArray arrayWithArray:[NSArray modelArrayWithClass:[commentsModel class] json:responseObject[@"comments"]]];
                [self.commentsTableView.mj_header endRefreshing];
                [self.commentsTableView.mj_footer resetNoMoreData];
            }else{
                NSArray *arr = [NSMutableArray arrayWithArray:[NSArray modelArrayWithClass:[commentsModel class] json:responseObject[@"comments"]]];;
                [self.dataArray addObjectsFromArray:arr];
                if (arr.count == 0) {
                    [self.commentsTableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.commentsTableView.mj_footer endRefreshing];
                }
                
            }
            [self.commentsTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
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
    static NSString *cellid=@"commentsTableViewCell";
    commentsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"commentsTableViewCell" owner:self options:nil].firstObject;
    }
    cell.model = self.dataArray[indexPath.section];
    [cell setRes:^(BOOL isRes) {
        commentsModel *model = self.dataArray[indexPath.section];
        resViewController *resVc = [[resViewController alloc]init];
        resVc.commentID = model.id;
        [resVc setRefreshData:^(BOOL isNeed) {
            [weakSelf refresh];
        }];
        [weakSelf.navigationController pushViewController:resVc animated:YES];
    }];
    return cell;
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
