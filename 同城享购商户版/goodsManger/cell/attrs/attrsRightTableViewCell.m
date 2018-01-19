//
//  attrsRightTableViewCell.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/12.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "attrsRightTableViewCell.h"

@implementation attrsRightTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self uiconfig];
}
- (void)uiconfig{
    self.delBtn.layer.cornerRadius = 5;
    self.delBtn.layer.borderWidth = 0.5;
    [self.delBtn setTitleColor: UIColorFromRGBA(68, 195, 34, 1) forState:UIControlStateNormal];
    self.delBtn.layer.borderColor = UIColorFromRGBA(68, 195, 34, 1).CGColor;
    
    self.editedBtn.layer.cornerRadius = 5;
    self.editedBtn.layer.borderWidth = 0.5;
    [self.editedBtn setTitleColor: UIColorFromRGBA(68, 195, 34, 1) forState:UIControlStateNormal];
    self.editedBtn.layer.borderColor = UIColorFromRGBA(68, 195, 34, 1).CGColor;
    self.lineImage.image =  [self imageWithLineWithImageView:self.lineImage];
}
- (void)setModel:(attrsValModel *)model{
    _model = model;
    self.attrsName.text =[NSString stringWithFormat:@"属性名称：%@",model.valName];
    self.combineLabel.text = [NSString stringWithFormat:@"组合价：¥%@元",model.price_order];
    self.singlePrice.text = [NSString stringWithFormat:@"单点价：¥%@元",model.valprice];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (UIImage *)imageWithLineWithImageView:(UIImageView *)imageView{
    CGFloat width = imageView.frame.size.width;
    CGFloat height = imageView.frame.size.height;
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, width, height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGFloat lengths[] = {10,5};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, UIColorFromRGBA(68, 195, 34, 1).CGColor);
    CGContextSetLineDash(line, 0, lengths, 1);
    CGContextMoveToPoint(line, 0, 1);
    CGContextAddLineToPoint(line, width-10, 1);
    CGContextStrokePath(line);
    return  UIGraphicsGetImageFromCurrentImageContext();
}

- (IBAction)buttonPress:(UIButton *)sender {
    if (sender.tag == 101) {
        NSLog(@"修改");
        _editAttrsVals(self.model);
    }else if(sender.tag == 102){
        NSLog(@"删除");
        NSLog(@"%@",self.model);
        _delAttrsVals(self.model);
    }
}

@end
