//
//  imagesLibraryViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/14.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "imagesLibraryViewController.h"
#import "HXSearchBar.h"
#import "imageLiaryCollectionViewCell.h"
#import "imagesLibraryModel.h"

@interface imagesLibraryViewController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) HXSearchBar *imageSearchBar;
@property (nonatomic,strong) UICollectionView *imagesCollectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) UIButton *submitBtn;
@property (nonatomic,strong) UIImage *selectedImage;
@property (nonatomic,strong) NSMutableArray *selectedImageArray;

@end

@implementation imagesLibraryViewController

- (NSMutableArray *)selectedImageArray{
    if (!_selectedImageArray) {
        _selectedImageArray = [[NSMutableArray alloc]init];
    }
    return _selectedImageArray;
}
-  (UIButton *)submitBtn{
    if (!_submitBtn) {
        
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.frame = CGRectMake(0, SCREEN_HEIGHT-SafeAreaBottomHeight, SCREEN_WIDTH, SafeAreaBottomHeight);
        [_submitBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitPress) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       
    }
    return _submitBtn;
}
- (void)submitPress{
    if (self.selectedImageArray.count!=0) {
        _selectedPics(self.selectedImageArray);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray= [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (UICollectionView *)imagesCollectionView{
    if (!_imagesCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        // 1.设置列间距
        layout.minimumInteritemSpacing = 0;
        // 2.设置行间距
        layout.minimumLineSpacing =0;
        // 3.设置每个item的大小
        layout.itemSize = CGSizeMake((SCREEN_WIDTH)/3, (SCREEN_WIDTH)/3);
        
        _imagesCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight-SafeAreaBottomHeight) collectionViewLayout:layout];
       
        
       _imagesCollectionView.collectionViewLayout = layout;
        
        _imagesCollectionView.backgroundColor = [UIColor whiteColor];
       _imagesCollectionView.dataSource = self;
        _imagesCollectionView.delegate = self;

        [_imagesCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([imageLiaryCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"imageLiaryCollectionViewCell"];
        
        [_imagesCollectionView setAccessibilityIdentifier:@"collectionView"];
        [_imagesCollectionView setIsAccessibilityElement:YES];
       
         _imagesCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        
        MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        //footer.refreshingTitleHidden = YES;
        // footer
        [footer setTitle:@"我可是有底线的哦" forState:MJRefreshStateNoMoreData];
        _imagesCollectionView.mj_footer = footer;
    }
    return _imagesCollectionView;
    
}
- (void)loadMoreData{
    self.index +=1;
    [self requestData:self.imageSearchBar.text];
}
- (void)refreshData{
    self.index = 1;
    [self requestData:self.imageSearchBar.text];
}
- (HXSearchBar *)imageSearchBar{
    
    if (!_imageSearchBar) {
        if (IPHONE_X) {
            _imageSearchBar = [[HXSearchBar alloc] initWithFrame:CGRectMake(60,(SafeAreaTopHeight-44-30)/2+44, SCREEN_WIDTH-80, 30)];
        }else{
            _imageSearchBar = [[HXSearchBar alloc] initWithFrame:CGRectMake(60,(SafeAreaTopHeight-20-30)/2+20, SCREEN_WIDTH-80, 30)];
        }
        _imageSearchBar.delegate = self;
        _imageSearchBar.text = self.searchName;
        //输入框提示
        _imageSearchBar.placeholder = @"请输入要查询的商品";
        //光标颜色
        _imageSearchBar.cursorColor = UIColorFromRGBA(68, 195, 34, 1);
        //TextField
        _imageSearchBar.searchBarTextField.layer.cornerRadius = 15;
        _imageSearchBar.searchBarTextField.layer.masksToBounds = YES;
        _imageSearchBar.searchBarTextField.layer.borderColor =  UIColorFromRGBA(68, 195, 34, 1).CGColor;
        _imageSearchBar.searchBarTextField.layer.borderWidth = 1.0;
        //去掉取消按钮灰色背景
        _imageSearchBar.hideSearchBarBackgroundImage = YES;
        
    }
    return _imageSearchBar;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self configBarItem];
    //[self requestData:@""];
    [self.navView addSubview:self.imageSearchBar];
     [self.view addSubview:self.imagesCollectionView];
     [self.view addSubview:self.submitBtn];
    if (self.imageSearchBar.text.length!=0) {
         [self.imagesCollectionView.mj_header beginRefreshing];
    }
    NSLog(@"%@",self.view.subviews);
}
- (void)configBarItem{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (IPHONE_X) {
        rightBtn.frame = CGRectMake(20, (SafeAreaTopHeight-44-30)/2+44, 30, 30);
    }else{
        rightBtn.frame = CGRectMake(20, (SafeAreaTopHeight-20-30)/2+20, 30, 30);
    }
    [rightBtn setImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:rightBtn];
}
- (void)backTo{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)requestData:(NSString *)keywords{
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"keywords"] = keywords;
    parmas[@"page"] = @(self.index);
    parmas[@"max"] = @(30);
    [URLRequest postWithImageURL:@"shop/pic/list" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"%@",[cityShoppingTool jsonConvertToArray:responseObject]);

        if (self.index == 1) {
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:[NSArray modelArrayWithClass:[imagesLibraryModel class] json:responseObject]];
            for (int i = 0; i<self.dataArray.count; i++) {
                imagesLibraryModel *model = self.dataArray[i];
                model.isSelected = NO;
                [self.dataArray replaceObjectAtIndex:i withObject:model];
            }
            
            [self.imagesCollectionView.mj_header endRefreshing];
            [self.imagesCollectionView.mj_footer resetNoMoreData];
        }else{
            
            NSMutableArray *Arr =[NSMutableArray arrayWithArray:[NSArray modelArrayWithClass:[imagesLibraryModel class] json:responseObject]];
            
            for (int i = 0; i<Arr.count; i++) {
                imagesLibraryModel *model = Arr[i];
                model.isSelected = NO;
                [Arr replaceObjectAtIndex:i withObject:model];
            }
            [self.dataArray addObjectsFromArray:Arr];
            if (Arr.count == 0) {
                [self.imagesCollectionView.mj_footer endRefreshing];
                [self.imagesCollectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.imagesCollectionView.mj_footer endRefreshing];
            }
            
        }
        
        [self.imagesCollectionView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"%@",error);
    }];
    
 
}

#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    imageLiaryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageLiaryCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.selectedImageArray.count==self.maxSelectedCount) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"您最多可选择%ld张图片",(long)self.maxSelectedCount] message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        imageLiaryCollectionViewCell *cell =  (imageLiaryCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        imagesLibraryModel * model = self.dataArray[indexPath.row];
        if (model.isSelected) {
            model.isSelected = NO;
            [self.selectedImageArray removeObject:cell.goodsImage.image];
        }else{
            model.isSelected = YES;
            [self.selectedImageArray addObject:cell.goodsImage.image];
        }
        
        [self.imagesCollectionView reloadData];
    }
}


#pragma mark - UISearchBar Delegate

//已经开始编辑时的回调
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    HXSearchBar *sear = (HXSearchBar *)searchBar;
    //取消按钮
    sear.cancleButton.backgroundColor = [UIColor clearColor];
    [sear.cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [sear.cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sear.cancleButton.titleLabel.font = [UIFont systemFontOfSize:14];
}

//编辑文字改变的回调
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"searchText:%@",searchText);
}

//搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton = NO;
   // searchBar.text = nil;
    [self.view endEditing:YES];
    [self refreshData];
    
}

//取消按钮点击的回调
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    searchBar.text = nil;
    [self.view endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.imageSearchBar resignFirstResponder];
    self.imageSearchBar.showsCancelButton = NO;
    // searchBar.text = nil;
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
