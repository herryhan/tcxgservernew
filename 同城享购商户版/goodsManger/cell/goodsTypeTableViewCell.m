//
//  goodsTypeTableViewCell.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/27.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "goodsTypeTableViewCell.h"

@implementation goodsTypeTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = UIColorFromRGBA(244, 245, 247, 1);
    
    // self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIColor *color =  [[UIColor alloc]initWithRed:255 green:255 blue:255 alpha:1];
    //通过RGB来定义自己的颜色
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = color;
     self.lineImageView.image =  [self imageWithLineWithImageView:self.lineImageView];
}

- (void)setGoodsTypeModel:(goodsTypeModel *)goodsTypeModel{
    
    _goodsTypeModel = goodsTypeModel;
    
    self.typeNameLabel.text = goodsTypeModel.typeName;
    
    if (self.selected) {
        //self.backgroundColor = [UIColor whiteColor];
    }else{
        //self.backgroundColor = [UIColor lightGrayColor];
    }
    
}
- (void)setKeyWordsModel:(keywordsModel *)keyWordsModel{
    
    _keyWordsModel = keyWordsModel;
    
    self.typeNameLabel.text = keyWordsModel.typeName;
    
    if (self.selected) {
        //self.backgroundColor = [UIColor whiteColor];
    }else{
        //self.backgroundColor = [UIColor lightGrayColor];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    if (selected) {
        
        self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        
    }
    
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
@end
