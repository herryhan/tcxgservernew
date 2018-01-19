//
//  attrsLeftTableViewCell.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/12.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "attrsLeftTableViewCell.h"

@implementation attrsLeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = UIColorFromRGBA(244, 245, 247, 1);
    
    // self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIColor *color =  [[UIColor alloc]initWithRed:255 green:255 blue:255 alpha:1];
    //通过RGB来定义自己的颜色
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = color;
    
    self.attrsTypeName.textColor = UIColorFromRGBA(68, 195, 34, 1);
   self.lineIamge.image =  [self imageWithLineWithImageView:self.lineIamge];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    if (selected) {
        
        self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        
    }
    
}
- (IBAction)delAttrs:(UIButton *)sender {
    _delAttrsType(self.model.attrId);
}

- (void)setModel:(attrsTypeModel *)model{
    _model = model;
    self.attrsTypeName.text = model.attrName;
   
}
@end
