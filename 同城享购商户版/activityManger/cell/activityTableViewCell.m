//
//  activityTableViewCell.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/7.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "activityTableViewCell.h"

@implementation activityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.delBtn.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (void)setModel:(activityModel *)model{
    _model = model;
    if (model.typeName.length == 0) {
         self.typeNameLabel.text = @"全品类";
    }else{
        self.typeNameLabel.text = model.typeName;
    }
    
    switch ([model.cate intValue]) {
        case 0:
            self.activityNameLabel.text = @"满减";
            self.activityContentLabel.text = [NSString stringWithFormat:@"%@类满%@元减%@元",model.typeName,model.richMoney,model.releaseMoney];
            break;
        case 1:
            self.activityNameLabel.text = @"折扣";
            self.activityContentLabel.text = [NSString stringWithFormat:@"%@类%0.1f折",model.typeName,[model.discount floatValue]/10];
            break;
        case 2:
            self.activityNameLabel.text = @"半价";
            self.activityContentLabel.text = [NSString stringWithFormat:@"%@类第二件半价",model.typeName];
            break;
        default:
            break;
    }
    self.appTakeFeeLabel.text = [NSString stringWithFormat:@"平台承担%@元",model.appTake];
    self.beginTimeLabel.text = [NSString stringWithFormat:@"开始时间:%@",model.beginTime];
    self.endTimeLabel.text = [NSString stringWithFormat:@"结束时间:%@",model.endTime];
    
}
- (IBAction)delActPress:(UIButton *)sender {
    
    _delActivity(self.model.id);
    
}

@end
