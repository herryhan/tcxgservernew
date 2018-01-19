//
//  cashModel.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/11.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cashModel : NSObject
@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) NSNumber *bankNo;
@property (nonatomic,strong) NSString *bankRealname;
@property (nonatomic,strong) NSString *creatTime;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSNumber *money;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSNumber *orderFee;
@property (nonatomic,strong) NSArray *orderList;
@property (nonatomic,strong) NSNumber *points;
@property (nonatomic,strong) NSString *username;

@end


