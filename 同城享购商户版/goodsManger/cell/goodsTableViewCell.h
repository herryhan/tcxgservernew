//
//  goodsTableViewCell.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/27.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "goodsModel.h"

@interface goodsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsLibLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *attrsBtn;
@property (weak, nonatomic) IBOutlet UIButton *cutDownBtn;

@property (nonatomic,strong)goodsModel *goodsInfoModel;

@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;

@property (nonatomic,strong) void (^isEditing)(goodsModel *model);

//上架下架
@property (nonatomic,assign) BOOL isUp;

@property (nonatomic,strong) void (^upDown)(BOOL needUp);

//属性
@property (nonatomic,strong) void (^editedAttrs)(NSNumber *goodsId);


@end
