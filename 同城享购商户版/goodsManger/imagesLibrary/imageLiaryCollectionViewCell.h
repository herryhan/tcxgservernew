//
//  imageLiaryCollectionViewCell.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/14.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "imagesLibraryModel.h"

@interface imageLiaryCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;

@property (weak, nonatomic) IBOutlet UIImageView *isSelectedImage;

@property (nonatomic,strong) imagesLibraryModel *model;

@property (nonatomic,assign)BOOL isSelected;

-(void)UpdateCellWithState:(BOOL)select;

@end
