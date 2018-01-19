//
//  addNewViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/28.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "addNewViewController.h"
#import "goodsView.h"
#import "scanViewController.h"
#import "DUX_UploadUserIcon.h"
#import "keyWordsViewController.h"
#import "ZSPickView.h"
#import "goodsTypeModel.h"
#import "KeyboardToolBar.h"
#import "CDZPicker.h"
#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZPhotoPreviewController.h"
#import "imagesLibraryViewController.h"


@interface addNewViewController ()<DUX_UploadUserIconDelegate,TZImagePickerControllerDelegate,UIActionSheetDelegate>

@property (nonatomic,strong)UIScrollView *goodsScrollerView;
@property (nonatomic,strong) goodsView *goodView;
@property (nonatomic,strong) UIButton *bottomBtn;
@property NSInteger currentIndex;
@property (nonatomic,strong) keyWordsViewController *keyWordVc;
@property (nonatomic,strong) NSMutableArray *newKeyWordsArray;
@property (nonatomic,strong) NSString *typeID;

@property (nonatomic,strong) NSMutableArray *addTypeArray;
@property (nonatomic,strong) NSMutableArray *addTypeIdArray;

@property (nonatomic,strong) NSMutableArray *isExitPicArray;
@property (nonatomic,assign) NSInteger imageTagSlected;

@property (nonatomic,strong) NSMutableArray *iconsArray;
@property (nonatomic,strong) NSMutableArray *picsArray;
@property (nonatomic,assign) NSInteger currentSelectedCollectionViewTag;

@end

@implementation addNewViewController

- (NSMutableArray *)picsArray{
    if (!_picsArray) {
        _picsArray = [[NSMutableArray alloc]init];
    }
    return _picsArray;
}
- (NSMutableArray *)iconsArray{
    if (!_iconsArray){
        _iconsArray = [[NSMutableArray alloc]init];
    }
    return _iconsArray;
}

- (NSMutableArray *)isExitPicArray{
    if (!_isExitPicArray) {
        _isExitPicArray = [[NSMutableArray alloc]init];
    }
    return _isExitPicArray;
}

- (NSMutableArray *)addTypeIdArray{
    if (!_addTypeIdArray) {
        _addTypeIdArray = [[NSMutableArray alloc]init];
    }
    return _addTypeIdArray;
    
}

- (NSMutableArray *)addTypeArray{
    if (!_addTypeArray) {
        _addTypeArray = [[NSMutableArray alloc]init];
    }
    return _addTypeArray;
}


- (NSMutableArray *)newKeyWordsArray{
    if (!_newKeyWordsArray) {
        _newKeyWordsArray = [[NSMutableArray alloc]init];
        if (self.isEdited) {
            if (self.pastKeyWordArray.count!= 0) {
                for (NSString *str in self.pastKeyWordArray) {
                    [_newKeyWordsArray addObject:str];
                }
            }
        }
        
    }
    return _newKeyWordsArray;
}
- (keyWordsViewController *)keyWordVc{
    declareWeakSelf;
    if (!_keyWordVc) {
        
        _keyWordVc = [[keyWordsViewController alloc]init];
        [_keyWordVc setKeyWordName:^(NSString *name) {
            [weakSelf.newKeyWordsArray addObject:name];
            weakSelf.goodView.keywordsArray = weakSelf.newKeyWordsArray;
            [weakSelf.goodView.keyWordCollectionView reloadData];
            [weakSelf updateContraint];
        }];
    }
    return _keyWordVc;
}

- (UIButton *)bottomBtn{
    
    if (!_bottomBtn) {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomBtn.frame = CGRectMake(0,SCREEN_HEIGHT-SafeAreaBottomHeight, SCREEN_WIDTH, SafeAreaBottomHeight);
        _bottomBtn.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
        [_bottomBtn setTitle:@"提交" forState: UIControlStateNormal];
        [_bottomBtn addTarget:self action:@selector(bottomPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

- (void)bottomPress{
    
    if (self.goodView.iconImagesArray.count == 0) {
        [MBProgressHUD showError:@"商品图标至少传一张" toView:self.view];
    }else{
        [MBProgressHUD showMessage:@"提交中" toView:self.view];
        NSString *keywordString = @"";
        if (self.newKeyWordsArray.count !=0) {
            for (int i=0; i<self.newKeyWordsArray.count; i++) {
                if (i == 0) {
                    keywordString = [keywordString stringByAppendingString:[NSString stringWithFormat:@"%@",self.newKeyWordsArray[i]]];
                }else{
                    keywordString = [keywordString stringByAppendingString:[NSString stringWithFormat:@" %@",self.newKeyWordsArray[i]]];
                }
            }
        }
        NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
        
        parmas[@"typeId"] = self.typeID;
        parmas[@"code"] = self.goodView.barCodeText.text;
        parmas[@"name"] = self.goodView.goodsNameTest.text;
        parmas[@"keywords"] = keywordString;
        parmas[@"price"] = self.goodView.priceText.text;
        parmas[@"stock"] = self.goodView.stockText.text;
        parmas[@"weight"] = self.goodView.weightText.text;
        parmas[@"rank"] = self.goodView.rankText.text;
        parmas[@"text"] = self.goodView.subTextView.text;
        parmas[@"uuid"] = [keepData getUUID];
        parmas[@"os"] = @"ios";
        parmas[@"id"] = self.goodModel.id;
        
        NSLog(@"%@",keywordString);
        //icon
        NSMutableArray *logoNameArray =[[NSMutableArray alloc]init];
      
        for (int i = 1; i<self.iconsArray.count+1; i++) {
            [logoNameArray addObject:[NSString stringWithFormat:@"logo%d",i]];
        }
        
        //pic
        NSMutableArray *picNameArray = [[NSMutableArray alloc]init];
      
        for (int i = 1; i<self.picsArray.count+1; i++) {
            [picNameArray addObject:[NSString stringWithFormat:@"pic%d",i]];
        }
    
        NSArray *nameArray = @[logoNameArray,picNameArray];
        NSArray *allImageArray = @[self.goodView.iconImagesArray,self.goodView.picsImagesArray];
        NSString *urlString;
        
        if (self.isEdited) {
            urlString = @"sp/product/update/do";
        }else{
            urlString = @"sp/product/add";
        }
        
        [URLRequest postWithURL:urlString params:parmas formDataArray:allImageArray name:nameArray success:^(NSURLSessionDataTask *task, id responseObject) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([responseObject[@"state"] isEqualToString:@"success"]) {
                  //  [MBProgressHUD showSuccess:@"提交成功" toView:self.view];
                    if (self.isEdited || self.isAddGoodsInGoodsList) {
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:self.typeBeginIndex];
                        _goodsUpdate(indexPath);
                       
                    }
                     [self.navigationController popViewControllerAnimated:YES];
                }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:@"提交失败" toView:self.view];
        }];
    }
   
}

- (UIScrollView *)goodsScrollerView{
    if (!_goodsScrollerView) {
        _goodsScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight-SafeAreaTopHeight)];
        _goodsScrollerView.backgroundColor = [UIColor clearColor];
    }
    return _goodsScrollerView;
}

- (goodsView *)goodView{
    declareWeakSelf;
    
    if (!_goodView) {
        _goodView = [[goodsView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 205+(SCREEN_WIDTH-20)/4+50+355+SCREEN_WIDTH/5*2+20)];
        
        [KeyboardToolBar registerKeyboardToolBar:_goodView.barCodeText];
        
        [KeyboardToolBar registerKeyboardToolBar:_goodView.goodsNameTest];
        [KeyboardToolBar registerKeyboardToolBar:_goodView.priceText];
        [KeyboardToolBar registerKeyboardToolBar:_goodView.stockText];
        [KeyboardToolBar registerKeyboardToolBar:_goodView.weightText];
        [KeyboardToolBar registerKeyboardToolBar:_goodView.rankText];
        
        if (weakSelf.isEdited) {
            [_goodView setModel:weakSelf.goodModel];
            //获取哪个图片不是空
            [weakSelf getExitPic];
            if ([weakSelf configWithPicUrl:weakSelf.goodModel.logo1]) {
                [weakSelf.iconsArray addObject:weakSelf.goodModel.logo1];
            }
            if ([weakSelf configWithPicUrl:weakSelf.goodModel.logo2]) {
               [weakSelf.iconsArray addObject:weakSelf.goodModel.logo2];
            }
            if ([weakSelf configWithPicUrl:weakSelf.goodModel.logo3]) {
                [weakSelf.iconsArray addObject:weakSelf.goodModel.logo3];
            }
            if ([weakSelf configWithPicUrl:weakSelf.goodModel.logo4]) {
                [weakSelf.iconsArray addObject:weakSelf.goodModel.logo4];
            }
            if ([weakSelf configWithPicUrl:weakSelf.goodModel.pic1]) {
                [weakSelf.picsArray addObject:weakSelf.goodModel.pic1];
            }
            if ([weakSelf configWithPicUrl:weakSelf.goodModel.pic2]) {
                [weakSelf.picsArray addObject:weakSelf.goodModel.pic2];
            }
            if ([weakSelf configWithPicUrl:weakSelf.goodModel.pic3]) {
                [weakSelf.picsArray addObject:weakSelf.goodModel.pic3];
            }
            if ([weakSelf configWithPicUrl:weakSelf.goodModel.pic4]) {
                [weakSelf.picsArray addObject:weakSelf.goodModel.pic4];
            }
            if ([weakSelf configWithPicUrl:weakSelf.goodModel.pic5]) {
                [weakSelf.picsArray addObject:weakSelf.goodModel.pic5];
            }
            if ([weakSelf configWithPicUrl:weakSelf.goodModel.pic6]) {
                [weakSelf.picsArray addObject:weakSelf.goodModel.pic6];
            }
            if ([weakSelf configWithPicUrl:weakSelf.goodModel.pic7]) {
                [weakSelf.picsArray addObject:weakSelf.goodModel.pic7];
            }
            if ([weakSelf configWithPicUrl:weakSelf.goodModel.pic8]) {
                [weakSelf.picsArray addObject:weakSelf.goodModel.pic8];
            }
            if ([weakSelf configWithPicUrl:weakSelf.goodModel.pic9]) {
                [weakSelf.picsArray addObject:weakSelf.goodModel.pic9];
            }
            if ([weakSelf configWithPicUrl:weakSelf.goodModel.pic10]) {
                [weakSelf.picsArray addObject:weakSelf.goodModel.pic10];
            }
            _goodView.iconImagesArray = weakSelf.iconsArray;
            _goodView.picsImagesArray = weakSelf.picsArray;
            [_goodView.iconsCollectionView reloadData];
            [_goodView.picsCollection reloadData];
            
        }
        
        _goodView.sectionOneStraint.constant = 205+(SCREEN_WIDTH-20)/4;
       
        _goodView.iconsConstraint.constant = (SCREEN_WIDTH-20)/4;
        
        [_goodView setSubKeyWords:^(NSInteger index) {
            [weakSelf.newKeyWordsArray removeObjectAtIndex:index];
            [weakSelf.goodView.keyWordCollectionView reloadData];
            [weakSelf updateContraint];
        }];
        
        [_goodView setShowPick:^(BOOL isShow) {
            for (int i = 1; i<8; i++) {
                UITextField *field = [weakSelf.goodView viewWithTag:4000+i];
                [field resignFirstResponder];
            }
           
            if (weakSelf.changeTypesArray.count!=0 || weakSelf.addTypeArray.count!=0){
            ZSPickView *pick = [[ZSPickView alloc]initWithComponentArr:nil];
            if (weakSelf.isEdited || weakSelf.isAddGoodsInGoodsList) {
                 pick.componentArr = @[weakSelf.changeTypesArray];
                pick.sureBlock = ^(NSArray *arr){
                    for (NSString *str in arr) {
                        
                        [weakSelf.goodView.typeBtn setTitle:str forState:UIControlStateNormal];
                        for (int i=0; i<self.changeTypesArray.count; i++) {
                            if ([str isEqualToString:weakSelf.changeTypesArray[i]]) {
                                weakSelf.typeID = weakSelf.typeIDArray[i];
                            }
                        }
                    }
                };
            }else{
                pick.componentArr = @[weakSelf.addTypeArray];
                pick.sureBlock = ^(NSArray *arr){
                    for (NSString *str in arr) {
                        
                        [weakSelf.goodView.typeBtn setTitle:str forState:UIControlStateNormal];
                        for (int i=0; i<self.addTypeArray.count; i++) {
                            if ([str isEqualToString:weakSelf.addTypeArray[i]]) {
                                weakSelf.typeID = weakSelf.addTypeIdArray[i];
                            }
                        }
                    }
                };
            }
            [weakSelf.view addSubview:pick];
            }
        }];
        
        [_goodView setScan:^(BOOL isScan) {
            scanViewController *scanVc = [[scanViewController alloc]init];
            [scanVc setScanResult:^(id result) {
                weakSelf.goodView.goodsNameTest.text = result[@"name"];
                weakSelf.goodView.barCodeText.text = result[@"code"];
                [weakSelf.goodView setPicArray:result[@"pic"]];
                [weakSelf.goodView setDesArray:result[@"des"]];
            }];
            [weakSelf.navigationController pushViewController:scanVc animated:YES];
        }];
        
        [_goodView setIcon:^(NSInteger index) {
        
            for (int i = 1; i<8; i++) {
                UITextField *field = [weakSelf.goodView viewWithTag:4000+i];
                [field resignFirstResponder];
            }
             UIImageView *imageview = [weakSelf.goodView viewWithTag:index -100];
            if (imageview.image !=nil) {
                [UPLOAD_IMAGE showActionSheetInFatherViewController:weakSelf WithShowDel:NO AndtagIndex:index WithTitle:weakSelf.goodView.goodsNameTest.text delegate:weakSelf];
            }else{
                 [UPLOAD_IMAGE showActionSheetInFatherViewController:weakSelf WithShowDel:YES AndtagIndex:index WithTitle:weakSelf.goodView.goodsNameTest.text delegate:weakSelf];
            }
            
            weakSelf.currentIndex = index;
            
        }];
        
        
        [_goodView setPic:^(NSInteger index) {
        
            for (int i = 1; i<8; i++) {
                UITextField *field = [weakSelf.goodView viewWithTag:4000+i];
                [field resignFirstResponder];
            }
            UIImageView *imageview = [weakSelf.goodView viewWithTag:index -100];
            if (imageview.image !=nil) {
                 [UPLOAD_IMAGE showActionSheetInFatherViewController:weakSelf WithShowDel:NO AndtagIndex:index WithTitle:weakSelf.goodView.goodsNameTest.text delegate:weakSelf];
            }else{
                [UPLOAD_IMAGE showActionSheetInFatherViewController:weakSelf WithShowDel:YES AndtagIndex:index WithTitle:weakSelf.goodView.goodsNameTest.text delegate:weakSelf];
            }
            weakSelf.currentIndex = index;
            
        }];
        
        /***添加图片***/
        [_goodView setAddImages:^(NSInteger collectionTag) {
            weakSelf.currentSelectedCollectionViewTag = collectionTag;
            
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:weakSelf cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照/相册",@"在线图库", nil];
            [sheet showInView:weakSelf.view];
            
        }];
        
        /***删除图片***/
        [_goodView setDeleteIconImages:^(NSInteger collection, NSIndexPath *iconIndex) {
            if (collection == 501) {
                [weakSelf.iconsArray removeObjectAtIndex:iconIndex.row];
                [weakSelf.goodView setIconImagesArray:weakSelf.iconsArray];
            }else if (collection == 503){
                [weakSelf.picsArray removeObjectAtIndex:iconIndex.row];
                [weakSelf.goodView setPicsImagesArray:weakSelf.picsArray];
                [weakSelf updateContraint];
            }
        }];
        
        /***设置关键词***/
        [_goodView setAddKeyWordsPress:^(BOOL isAdd) {
            NSLog(@"dd");
            [weakSelf presentViewController:weakSelf.keyWordVc animated:YES completion:^{

            }];
        }];
 
    }
    return _goodView;
}

- (void)getExitPic{
    
    for (int i = 1; i<5; i++) {
        UIImageView *imageview = [self.goodView viewWithTag:800+i];
        if (imageview.image !=nil) {
            [self.isExitPicArray addObject:[NSString stringWithFormat:@"%d",800+i]];
        }
    }
    for (int i = 1; i<11; i++) {
          UIImageView *imageview = [self.goodView viewWithTag:600+i];
        if (imageview.image !=nil) {
             [self.isExitPicArray addObject:[NSString stringWithFormat:@"%d",600+i]];
        }
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self contitle:self.vcTitle];
    self.view.backgroundColor = [UIColor whiteColor];
    self.currentIndex = 0;
    if (self.isEdited) {
        [self.goodView.typeBtn setTitle:self.changeTypesArray[self.typeBeginIndex] forState:UIControlStateNormal];
        self.typeID = self.typeIDArray[self.typeBeginIndex];
      
        self.goodView.keywordsArray = self.newKeyWordsArray;
        [self.goodView.keyWordCollectionView reloadData];
        [self updateContraint];
        
    }else if(self.isAddGoodsInGoodsList){
     
        [self.goodView.typeBtn setTitle:self.changeTypesArray[self.typeBeginIndex] forState:UIControlStateNormal];
        self.typeID = self.typeIDArray[self.typeBeginIndex];
        [self updateContraint];
    }else{
        [self requestTypeData];
    }
    
    [self.goodsScrollerView addSubview:self.goodView];
    if (!self.isEdited) {
        self.goodsScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH,  205+(SCREEN_WIDTH-20)/4+50+355+(SCREEN_WIDTH-20)/4+20);
    }
    [self.view addSubview:self.goodsScrollerView];
    [self.view addSubview:self.bottomBtn];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 代理方法
- (void)uploadImageToServerWithImage:(UIImage *)image {
    
    UIImageView *imageview = [self.goodView viewWithTag:self.currentIndex -100];
    if (imageview.image == nil) {
        NSLog(@"ffff");
    }else{
        NSLog(@"ddddd");
    }
    imageview.image = image;
}
- (void)uploadFromLibrary:(UIImage *)image{
    
    UIImageView *imageview = [self.goodView viewWithTag:self.currentIndex -100];
    if (imageview.image == nil) {
        NSLog(@"ffff");
    }else{
        NSLog(@"ddddd");
    }
    imageview.image = image;
    
}

- (void)deleteImage:(NSInteger)imageTag{

    self.imageTagSlected = imageTag;
    
    UIImageView *imageview = [self.goodView viewWithTag:self.currentIndex -100];
    imageview.image = nil;
    NSInteger currentIndex = self.currentIndex -100;

    if (self.isEdited) {
        int placeIdIndex = 0;
        int picId = 0;
        
        if (currentIndex/100 == 6) {
            placeIdIndex = 1;
            picId = imageTag%100;
        }
        if(currentIndex/100 == 8){
            placeIdIndex = 0;
            picId = imageTag%100;
        }
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        params[@"uuid"] = [keepData getUUID];
        params[@"placeId"] = @(placeIdIndex);
        params[@"picId"] = @(picId);
        params[@"id"] = self.goodModel.id;
    
        NSString *clcikPicStr;
        
        if (placeIdIndex == 0) {
            clcikPicStr = [NSString stringWithFormat:@"logo%d",picId];
        }
        
        if (placeIdIndex == 1) {
            clcikPicStr = [NSString stringWithFormat:@"pic%d",picId];
        }
        [URLRequest postWithURL:@"sp/delete/pic" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
                if ([responseObject[@"state"] isEqualToString:@"success"]) {
                    if (self.isEdited || self.isAddGoodsInGoodsList) {
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:self.typeBeginIndex];
                        _goodsUpdate(indexPath);
                    }
                }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"dddd");
            NSLog(@"%@",error);
        }];
    
    }
}
//#如果是新增商品需要获取该店的所有商品分类

- (void)requestTypeData{
    declareWeakSelf;
    
    [MBProgressHUD showMessage:@"" toView:self.view];
    
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"uuid"] = [keepData getUUID];
    [URLRequest postWithURL:@"sp/shopList" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"%@",responseObject);
            NSMutableArray *Arr = [[NSMutableArray alloc]init];
            
            [Arr addObjectsFromArray:[NSArray modelArrayWithClass:[goodsTypeModel class] json:responseObject[@"shopTypes"]]];
            if (Arr.count !=0) {
                for (goodsTypeModel *model in Arr) {
                    [weakSelf.addTypeArray addObject:model.typeName];
                    [weakSelf.addTypeIdArray addObject:model.typeId];
                }
                
                [self.goodView.typeBtn setTitle:weakSelf.addTypeArray[0] forState:UIControlStateNormal];
                self.typeID = weakSelf.addTypeIdArray[0];
            }else{
                [MBProgressHUD showError:@"暂无商品分类,请添加" toView:self.view];
                [self.navigationController popViewControllerAnimated:YES];
            }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"error:%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:@"网络错误，请检查网络"];
        
    }];
    
}

#pragma mark update views constraint

- (void)updateContraint{
    /*keywords*/
    NSInteger count = self.newKeyWordsArray.count/4+1;
    if (self.newKeyWordsArray.count%4 == 0) {
        count = self.newKeyWordsArray.count/4;
    }
    self.goodView.keywordsAllConstraint.constant = 50+ count*35;
    self.goodView.keyword.constant = count*35;
    /*pics*/
    NSInteger picCount = self.picsArray.count/4+1;
    if (self.picsArray.count%4 == 0) {
        picCount = self.picsArray.count/4+1;
    }
    self.goodView.picsCollectionViewHeightConstraint.constant =(SCREEN_WIDTH-20)/4*picCount;
    self.goodView.sectionTwoStraint.constant = 355+(SCREEN_WIDTH-20)/4*picCount+10;
    self.goodsScrollerView.contentSize =CGSizeMake(SCREEN_WIDTH,  205+(SCREEN_WIDTH-20)/4+50+355+(SCREEN_WIDTH-20)/4*picCount+20+ count*35);
    self.goodView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.goodsScrollerView.contentSize.height);
}
/***判断图片是否为空***/
- (BOOL)configWithPicUrl:(NSString *)url{
    if ([url isEqualToString:@"http://ha.tongchengxianggou.com:80/"]) {
        return NO;
    }else{
        return YES;
    }
}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { // take photo / 去拍照
        [self pushTZImagePickerController];
    } else if (buttonIndex == 1) {
        [self getPhotosByImageLibrary];
    }
}
- (void)getPhotosByImageLibrary{
    declareWeakSelf;
    imagesLibraryViewController *imageVC = [[imagesLibraryViewController alloc]init];
    imageVC.searchName = self.goodView.goodsNameTest.text;
    if (self.currentSelectedCollectionViewTag == 501) {
        imageVC.maxSelectedCount = 4 - self.iconsArray.count;
    }else if (self.currentSelectedCollectionViewTag == 503){
        imageVC.maxSelectedCount = 10 - self.picsArray.count;
    }
    [imageVC setSelectedPics:^(NSArray<UIImage *> *selectedImageArray) {
        if (weakSelf.currentSelectedCollectionViewTag == 501) {
            [weakSelf.iconsArray addObjectsFromArray:selectedImageArray];
            [weakSelf.goodView setIconImagesArray:self.iconsArray];
        }else if (weakSelf.currentSelectedCollectionViewTag == 503){
            [weakSelf.picsArray addObjectsFromArray:selectedImageArray];
            [weakSelf.goodView setPicsImagesArray:self.picsArray];
            [weakSelf updateContraint];
        }
    }];
    [self presentViewController:imageVC animated:YES completion:nil];
}
- (void)pushTZImagePickerController{
    NSInteger maxSelectedImageCount;
    if (self.currentSelectedCollectionViewTag == 501) {
        maxSelectedImageCount = 4 - self.iconsArray.count;
    }else {
        maxSelectedImageCount  = 10 - self.picsArray.count;
    }
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxSelectedImageCount delegate:self];
    imagePickerVc.allowPickingVideo = NO;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (self.currentSelectedCollectionViewTag == 501) {
            [self.iconsArray addObjectsFromArray:photos];
            [self.goodView setIconImagesArray:self.iconsArray];
        }else{
            [self.picsArray addObjectsFromArray:photos];
            [self.goodView setPicsImagesArray:self.picsArray];
            [self updateContraint];
        }
       
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
@end
