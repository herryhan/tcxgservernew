//
//  goodsTypeTableViewCell.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/27.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "goodsTypeModel.h"
#import "keywordsModel.h"

@interface goodsTypeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *typeNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *lineImageView;

@property (nonatomic,strong)goodsTypeModel *goodsTypeModel;

@property (nonatomic,strong)keywordsModel *keyWordsModel;

@end
