//
//  sendTableViewCell.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/5.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderModel.h"


@interface sendTableViewCell : UITableViewCell
@property (nonatomic,strong) orderModel *model;
@property (nonatomic,assign) NSInteger index;

@end

@interface orderProductView: UIView
@property (nonatomic,strong) NSMutableArray *productsArray;


@end

