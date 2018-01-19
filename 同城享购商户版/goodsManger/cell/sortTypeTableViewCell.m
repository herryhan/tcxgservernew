//
//  sortTypeTableViewCell.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/27.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "sortTypeTableViewCell.h"

@implementation sortTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self uiconfig];
}
- (void)uiconfig{
    
    self.delBtn.layer.borderWidth = 0.5;
    self.editBtn.layer.borderWidth = 0.5;
    self.delBtn.layer.borderColor = UIColorFromRGBA(68, 195, 34, 1).CGColor;
    self.editBtn.layer.borderColor = UIColorFromRGBA(68, 195, 34, 1).CGColor;
    [self.delBtn setTitleColor:UIColorFromRGBA(68, 195, 34, 1) forState:UIControlStateNormal];
    [self.editBtn setTitleColor:UIColorFromRGBA(68, 195, 34, 1) forState:UIControlStateNormal];
    
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 102) {
        _eidting(YES);
    }else{
        _eidting(NO);
    }
}

- (void)setModel:(goodsTypeModel *)model{
    
    _model = model;
    self.typeNameLabel.text = model.typeName;
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
