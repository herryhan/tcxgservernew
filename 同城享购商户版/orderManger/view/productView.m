//
//  productView.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/5.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "productView.h"

@implementation productView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"productView" owner:self options:nil];
        if (arrayObjectViews.count <1) {
            return nil;
        }else{
            for (id obj in arrayObjectViews) {
                self = obj;
                self.frame = frame;
                [self uiconfig];
            }
        }
    }
    return self;
    
}

- (void)uiconfig{
    self.goodsImageView.layer.cornerRadius = 5;
    self.goodsImageView.layer.masksToBounds = YES;
}
- (void)setValueWithDic:(NSMutableDictionary *)dic{
   
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"logo"]] placeholderImage:[UIImage imageNamed:@"bgImage"]];
    self.goodsNameLabel.text = dic[@"name"];
    if ([dic[@"attrlval"] isEqual:[NSNull null]]) {
        self.priceLabel.text = [NSString stringWithFormat:@"¥%@×%@个",dic[@"price"],dic[@"count"]];
    }else{
         self.priceLabel.text = [NSString stringWithFormat:@"¥%@×%@个 | %@",dic[@"price"],dic[@"count"],dic[@"attrlval"]];
    }
    
}

@end
