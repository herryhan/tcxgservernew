//
//  goodsView.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/28.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "goodsView.h"
#import "keywordsModel.h"
#import "keywordCollectionViewCell.h"
#import "KeyboardToolBar.h"
#import "iconCollectionViewCell.h"
#import "LxGridViewFlowLayout.h"
#import "UIView+Layout.h"

@implementation goodsView

-(instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"goodsView" owner:self options:nil];
        if (arrayObjectViews.count <1) {
            return nil;
        }else{
            
            for (id obj in arrayObjectViews) {
                self = obj;
                self.frame = frame;
                [self uiconfig];
            }
        }
    }
    return self;
}
- (void)uiconfig{
    
    self.scanBtn.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
    self.sepLineView.backgroundColor = UIColorFromRGBA(239, 239, 239, 1);
    self.sepLineView1.backgroundColor = UIColorFromRGBA(239, 239, 239, 1);
    self.sepLineView2.backgroundColor = UIColorFromRGBA(239, 239, 239, 1);
    self.sepLineView3.backgroundColor = UIColorFromRGBA(239, 239, 239, 1);
    self.addKeyWordsButton.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
    self.addKeyWordsButton.layer.cornerRadius  = 15;
    self.addKeyWordsButton.layer.masksToBounds = YES;

    self.barCodeText.delegate = self;
    [KeyboardToolBar registerKeyboardToolBar:self.barCodeText];
    
    self.goodsNameTest.delegate = self;
     [KeyboardToolBar registerKeyboardToolBar:self.goodsNameTest];
    self.priceText.delegate = self;
     [KeyboardToolBar registerKeyboardToolBar:self.priceText];
    self.stockText.delegate = self;
     [KeyboardToolBar registerKeyboardToolBar:self.stockText];
    self.weightText.delegate = self;
     [KeyboardToolBar registerKeyboardToolBar:self.weightText];
    self.rankText.delegate = self;
     [KeyboardToolBar registerKeyboardToolBar:self.rankText];
    self.subTextView.delegate =self;
    
    /*关键词的设置*/
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    // 1.设置列间距
    layout.minimumInteritemSpacing = 1;
    // 2.设置行间距
    layout.minimumLineSpacing = 5;
    // 3.设置每个item的大小
    layout.itemSize = CGSizeMake((SCREEN_WIDTH-10*5)/4, 30);
    self.keyWordCollectionView.collectionViewLayout = layout;
    self.keyWordCollectionView.backgroundColor = [UIColor whiteColor];
    self.keyWordCollectionView.dataSource = self;
    self.keyWordCollectionView.delegate = self;
    self.keyWordCollectionView.pagingEnabled = YES;
    self.keyWordCollectionView.showsVerticalScrollIndicator = NO;
    [self.keyWordCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([keywordCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"keywords"];
    [self.keyWordCollectionView setAccessibilityIdentifier:@"collectionView"];
    [self.keyWordCollectionView setIsAccessibilityElement:YES];
    
    /*icons的设置*/
    UICollectionViewFlowLayout *iconLayout = [[UICollectionViewFlowLayout alloc]init];
    // 1.设置列间距
    iconLayout.minimumInteritemSpacing = 0;
    // 2.设置行间距
    iconLayout.minimumLineSpacing = 5;
    // 3.设置每个item的大小
    iconLayout.itemSize = CGSizeMake((SCREEN_WIDTH-20)/4,(SCREEN_WIDTH-20)/4);
    self.iconsCollectionView.collectionViewLayout = iconLayout;
    self.iconsCollectionView.dataSource = self;
    self.iconsCollectionView.delegate = self;
    self.iconsCollectionView.pagingEnabled = YES;
    [self.iconsCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([iconCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"icons"];
    self.iconsCollectionView.scrollEnabled = NO;
    [self.iconsCollectionView setAccessibilityIdentifier:@"iconCollection"];
    [self.iconsCollectionView setIsAccessibilityElement:YES];
    /*pics的设置*/
    UICollectionViewFlowLayout *picsLayout = [[UICollectionViewFlowLayout alloc]init];
    // 1.设置列间距
    picsLayout.minimumInteritemSpacing = 0;
    // 2.设置行间距
    picsLayout.minimumLineSpacing = 0;
    // 3.设置每个item的大小
    picsLayout.itemSize = CGSizeMake((SCREEN_WIDTH-20)/4,(SCREEN_WIDTH-20)/4);
    self.picsCollection.collectionViewLayout = picsLayout;
    self.picsCollection.dataSource = self;
    self.picsCollection.delegate = self;
    self.picsCollection.pagingEnabled = YES;
    [self.picsCollection registerNib:[UINib nibWithNibName:NSStringFromClass([iconCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"pics"];
    self.picsCollection.scrollEnabled = NO;
    [self.picsCollection setAccessibilityIdentifier:@"picCollection"];
    [self.picsCollection setIsAccessibilityElement:YES];
    
    self.picsCollectionViewHeightConstraint.constant = (SCREEN_WIDTH-20)/4*3;
    
}

- (IBAction)showPickView:(UIButton *)sender {
    _showPick(YES);
}
- (IBAction)addKeyWords:(UIButton *)sender {
    NSLog(@"ffff");
    _addKeyWordsPress(YES);
}

- (void)setModel:(goodsModel *)model{
    
    _model = model;
    self.barCodeText.text = [NSString stringWithFormat:@"%@",model.id];
    self.goodsNameTest.text  = model.name;
    self.priceText.text = [NSString stringWithFormat:@"%@",model.price];
    self.stockText.text = [NSString stringWithFormat:@"%@",model.stock];
    self.weightText.text = [NSString stringWithFormat:@"%@",model.weight];
    self.rankText.text = [NSString stringWithFormat:@"%@",model.rank];
    self.subTextView.text = model.txt;

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)scanPress:(UIButton *)sender {
    _scan(YES);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.barCodeText resignFirstResponder];
    [self.goodsNameTest resignFirstResponder];
    [self.priceText resignFirstResponder];
    [self.stockText resignFirstResponder];
    [self.weightText resignFirstResponder];
    [self.rankText resignFirstResponder];
    [self.subTextView resignFirstResponder];
}

- (void)setPicArray:(NSArray *)picArray{
    _picArray = picArray;
    if (picArray.count>4) {
        [self.icon1 sd_setImageWithURL:[NSURL URLWithString:picArray[0][@"url"]]];
        [self.icon2 sd_setImageWithURL:[NSURL URLWithString:picArray[1][@"url"]]];
        [self.icon3 sd_setImageWithURL:[NSURL URLWithString:picArray[2][@"url"]]];
        [self.icon4 sd_setImageWithURL:[NSURL URLWithString:picArray[3][@"url"]]];
    }else{

        for (int i = 0; i<picArray.count; i++) {
            UIImageView *imagev = [self viewWithTag:801+i];
            [imagev sd_setImageWithURL:[NSURL URLWithString:picArray[i][@"url"]]];
        }
    }
}
- (IBAction)limitBtnPress:(UIButton *)sender {
    NSLog(@"ddffasdwd");
    _limitCountSelected(sender.tag);
}

- (void)setDesArray:(NSArray *)desArray{
    _desArray = desArray;
    for (int i = 0; i<desArray.count; i++) {
        UIImageView *imagev = [self viewWithTag:601+i];
        [imagev sd_setImageWithURL:[NSURL URLWithString:desArray[i][@"url"]]];
    }
}

#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag == 502) {
        return self.keywordsArray.count;
    }else if(collectionView.tag == 501){
        return self.iconImagesArray.count+1;
    }else{
        if (self.picsImagesArray.count ==10) {
            return self.picsImagesArray.count;
        }else{
            return self.picsImagesArray.count+1;
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 502) {
        keywordCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"keywords" forIndexPath:indexPath];
        cell.keywordsName.text =[NSString stringWithFormat:@"  %@",self.keywordsArray[indexPath.item]];
        [cell setSubPress:^(BOOL isSub) {
            _subKeyWords(indexPath.item);
        }];
        return cell;
    }else{
        iconCollectionViewCell *cell;
        
        if (collectionView.tag == 501) {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"icons" forIndexPath:indexPath];
            if (indexPath.row == self.iconImagesArray.count) {
                
                [cell.iconImageView setImage:[UIImage imageNamed:@"AlbumAddBtn"]];
                cell.delBtn.hidden = YES;
                
            }else{
                if (![_iconImagesArray[indexPath.row] isKindOfClass:[UIImage class]]){
                    [cell.iconImageView sd_setImageWithURL:self.iconImagesArray[indexPath.row] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        [_iconImagesArray replaceObjectAtIndex:indexPath.row withObject:image];
                    }];
                }else{
                    [cell.iconImageView setImage:_iconImagesArray[indexPath.row]];
                }
                cell.delBtn.hidden = NO;
                [cell setDelBtnPress:^(NSInteger tag) {
                    _deleteIconImages(collectionView.tag,indexPath);
                }];
            }
        }else if(collectionView.tag == 503){
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pics" forIndexPath:indexPath];
            if (indexPath.row == self.picsImagesArray.count) {
             
                [cell.iconImageView setImage:[UIImage imageNamed:@"AlbumAddBtn"]];
                cell.userInteractionEnabled = YES;
                cell.delBtn.hidden = YES;
                
            }else{
                if (![self.picsImagesArray[indexPath.row] isKindOfClass:[UIImage class]]) {
                    [cell.iconImageView sd_setImageWithURL:self.picsImagesArray[indexPath.row] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        [_picsImagesArray replaceObjectAtIndex:indexPath.row withObject:image];
                    }];
                }else{
                    [cell.iconImageView setImage:self.picsImagesArray[indexPath.row]];
                }
               
                cell.delBtn.hidden = NO;
                [cell setDelBtnPress:^(NSInteger tag) {
                    _deleteIconImages(collectionView.tag,indexPath);
                }];
            }
        }
    
        return cell;
    }
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"------%zd", indexPath.row);
    if (collectionView.tag == 501) {
        if (indexPath.row == self.iconImagesArray.count) {
            _addImages(501);
        }
    }else if(collectionView.tag == 503){
        if (indexPath.row == self.picsImagesArray.count) {
            _addImages(503);
        }
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)setIconImagesArray:(NSMutableArray *)iconImagesArray{
     _iconImagesArray = iconImagesArray;
   
    [_iconsCollectionView reloadData];
}

- (void)setPicsImagesArray:(NSMutableArray *)picsImagesArray{
    _picsImagesArray = picsImagesArray;
  
    [_picsCollection reloadData];
}

@end



