//
//  keywordCollectionViewCell.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/1.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "keywordCollectionViewCell.h"

@implementation keywordCollectionViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 15;
    self.layer.masksToBounds = YES;
    self.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
    
}
- (IBAction)subClick:(UIButton *)sender {
    _subPress(YES);
}

@end
