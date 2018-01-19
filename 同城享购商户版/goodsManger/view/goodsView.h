//
//  goodsView.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/28.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "goodsModel.h"

@interface goodsView : UIView <UITextFieldDelegate,UITextViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *scanBtn;
@property (weak, nonatomic) IBOutlet UIView *sepLineView;
@property (weak, nonatomic) IBOutlet UIView *sepLineView1;
@property (weak, nonatomic) IBOutlet UIView *sepLineView2;
@property (weak, nonatomic) IBOutlet UIView *sepLineView3;

@property (weak, nonatomic) IBOutlet UITextField *barCodeText;
@property (weak, nonatomic) IBOutlet UITextField *goodsNameTest;


@property (weak, nonatomic) IBOutlet UIButton *addKeyWordsButton;
@property (weak, nonatomic) IBOutlet UIButton *goodsIcon2;

@property (weak, nonatomic) IBOutlet UIButton *goodsIcon4;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;

@property (weak, nonatomic) IBOutlet UITextField *priceText;
@property (weak, nonatomic) IBOutlet UITextField *stockText;

@property (weak, nonatomic) IBOutlet UITextField *weightText;
@property (weak, nonatomic) IBOutlet UITextField *rankText;
@property (weak, nonatomic) IBOutlet UITextView *subTextView;

@property (weak, nonatomic) IBOutlet UIImageView *icon1;
@property (weak, nonatomic) IBOutlet UIImageView *icon2;
@property (weak, nonatomic) IBOutlet UIImageView *icon3;
@property (weak, nonatomic) IBOutlet UIImageView *icon4;
@property (weak, nonatomic) IBOutlet UIImageView *pic1;
@property (weak, nonatomic) IBOutlet UIImageView *pic2;
@property (weak, nonatomic) IBOutlet UIImageView *pic3;
@property (weak, nonatomic) IBOutlet UIImageView *pic4;
@property (weak, nonatomic) IBOutlet UIImageView *pic5;
@property (weak, nonatomic) IBOutlet UIImageView *pic6;
@property (weak, nonatomic) IBOutlet UIImageView *pic7;
@property (weak, nonatomic) IBOutlet UIImageView *pic8;
@property (weak, nonatomic) IBOutlet UIImageView *pic9;
@property (weak, nonatomic) IBOutlet UIImageView *pic10;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keywordsAllConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sectionOneStraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sectionTwoStraint;
@property (weak, nonatomic) IBOutlet UICollectionView *keyWordCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyword;

@property (nonatomic,strong) void(^scan)(BOOL isScan);
@property (nonatomic,strong) void(^icon)(NSInteger index);
@property (nonatomic,strong) void(^pic)(NSInteger index);
@property (nonatomic,strong) void(^showPick)(BOOL isShow);
@property (nonatomic,strong) void(^addKeyWordsPress)(BOOL isAdd);

@property (nonatomic,strong) NSArray *picArray;
@property (nonatomic,strong) NSArray *desArray;

@property (nonatomic,strong) NSArray *keywordsArray;

@property (nonatomic,strong) void(^subKeyWords)(NSInteger index);

@property (nonatomic,strong) goodsModel *model;

@property (nonatomic,strong) void(^limitCountSelected)(NSInteger btnTag);

/*icons*/
@property (weak, nonatomic) IBOutlet UICollectionView *iconsCollectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconsConstraint;

@property (nonatomic,strong) NSMutableArray *iconImagesArray;

@property (nonatomic,strong) void(^deleteIconImages)(NSInteger collection,NSIndexPath *iconIndex);

@property (nonatomic,strong) void(^addImages)(NSInteger collectionTag);

/*pics*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picsCollectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UICollectionView *picsCollection;
@property (nonatomic,strong) NSMutableArray *picsImagesArray;


@end
