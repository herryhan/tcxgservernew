//
//  goodsTypeModel.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/27.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface goodsTypeModel : NSObject

@property (nonatomic,strong) NSString *typeId;
@property (nonatomic,strong) NSString *typeName;
@property (nonatomic,strong) NSNumber *rank;
@property (nonatomic,strong) NSNumber *specialShopTypeId;
@property (nonatomic,strong) NSString *specialShopTypeName;

@end
