//
//  imageLiaryCollectionViewCell.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/14.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "imageLiaryCollectionViewCell.h"

@implementation imageLiaryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self uiconfig];
    
}
- (void)uiconfig{
    self.isSelectedImage.hidden = YES;
}

- (void)setModel:(imagesLibraryModel *)model{
    _model = model;
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@"239色块"]];
    if (model.isSelected) {
        self.isSelectedImage.hidden = NO;
    }else{
        self.isSelectedImage.hidden = YES;
    }
}

-(void)UpdateCellWithState:(BOOL)select{
    
    _isSelected = select;
    
}

@end
