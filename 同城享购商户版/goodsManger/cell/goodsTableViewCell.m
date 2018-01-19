//
//  goodsTableViewCell.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/27.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "goodsTableViewCell.h"

@implementation goodsTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self uiconfig];
    
}
- (void)uiconfig{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.editBtn.layer.borderWidth = 0.5;
    self.editBtn.layer.borderColor = UIColorFromRGBA(68, 195, 34, 1).CGColor;
    [self.editBtn setTitleColor:UIColorFromRGBA(68, 195, 34, 1) forState:UIControlStateNormal];
    self.attrsBtn.layer.borderWidth = 0.5;
    [self.attrsBtn setTitleColor:UIColorFromRGBA(68, 195, 34, 1) forState:UIControlStateNormal];
    self.attrsBtn.layer.borderColor = UIColorFromRGBA(68, 195, 34, 1).CGColor;
    self.cutDownBtn.layer.borderWidth = 0.5;
    [self.cutDownBtn setTitleColor:UIColorFromRGBA(68, 195, 34, 1) forState:UIControlStateNormal];
    
    self.cutDownBtn.layer.borderColor = UIColorFromRGBA(68, 195, 34, 1).CGColor;
}
- (void)setGoodsInfoModel:(goodsModel *)goodsInfoModel{
    NSLog(@"%@",goodsInfoModel.stock);
    _goodsInfoModel = goodsInfoModel;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodsInfoModel.logoBig] placeholderImage:[UIImage imageNamed:@"bgImage"]];
    self.goodsNameLabel.text = goodsInfoModel.name;
    self.goodsPriceLabel.text = [NSString stringWithFormat:@"¥%0.2lf",[goodsInfoModel.price floatValue]];
    if ([self.goodsInfoModel.state integerValue] == 3) {
        self.goodsLibLabel.text =[NSString stringWithFormat:@"整改原因:%@",self.goodsInfoModel.reason];
    }else{
         self.goodsLibLabel.text = [NSString stringWithFormat:@"库存：%@ | 月售：%@",goodsInfoModel.stock,goodsInfoModel.stock];
    }

    switch ([self.goodsInfoModel.state integerValue]) {
        case 0:
            [self.stateImageView setImage:[UIImage imageNamed:@"p_s_0"]];
            
            [self.cutDownBtn setTitle:@"下架" forState:UIControlStateNormal];
            self.isUp = 0;
            break;
        case 1:
            [self.stateImageView setImage:[UIImage imageNamed:@"p_s_1"]];
            [self.cutDownBtn setTitle:@"上架" forState:UIControlStateNormal];
            self.isUp = 1;
            
            break;
        case 2:
            [self.stateImageView setImage:[UIImage imageNamed:@"p_s_2"]];
            self.cutDownBtn.hidden = YES;
            break;
        case 3:
            [self.stateImageView setImage:[UIImage imageNamed:@"p_s_3"]];
            
            self.cutDownBtn.hidden = YES;
            break;
        default:
            break;
    }
}

- (IBAction)editing:(UIButton *)sender {
    _isEditing(_goodsInfoModel);
}
- (IBAction)upDownPress:(UIButton *)sender {
    _upDown(self.isUp);
}
- (IBAction)attrsPress:(UIButton *)sender {
    _editedAttrs(_goodsInfoModel.id);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
