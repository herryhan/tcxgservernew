//
//  attrsRightTableViewCell.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/12.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "attrsValModel.h"

@interface attrsRightTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *attrsName;
@property (weak, nonatomic) IBOutlet UILabel *combineLabel;
@property (weak, nonatomic) IBOutlet UILabel *singlePrice;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (weak, nonatomic) IBOutlet UIButton *editedBtn;

@property (nonatomic,strong) attrsValModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *lineImage;

@property (nonatomic,strong) void(^delAttrsVals)(attrsValModel *attrModel);

@property (nonatomic,strong) void(^editAttrsVals)(attrsValModel *attrModel);

@end


