//
//  productView.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/5.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderModel.h"

@interface productView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

- (void)setValueWithDic:(NSMutableDictionary *)dic;

@end
