//
//  sortTyopeViewController.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/27.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "baseViewController.h"
#import "goodsTypeModel.h"

@interface sortTyopeViewController : baseViewController

@property (nonatomic,strong)NSMutableArray *typeArray;

@property(nonatomic,strong) void(^type)(NSArray *typeNewArray);

@property BOOL isSingle;

@end
