//
//  orderModel.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/5.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface orderModel : NSObject

@property (nonatomic,strong) NSString *beginTime;
@property (nonatomic,strong) NSString *creatTime;
@property (nonatomic,strong) NSNumber *discountMoney;
@property (nonatomic,strong) NSNumber *distance;
@property (nonatomic,strong) NSString *expectTime;
@property (nonatomic,strong) NSNumber *fee;
@property (nonatomic,strong) NSNumber *funState;
@property (nonatomic,strong) NSNumber *id;
@property (nonatomic,strong) NSString *no;
@property (nonatomic,strong) NSNumber *payMoney;
@property (nonatomic,strong) NSArray *products;
@property (nonatomic,strong) NSString *realname;
@property (nonatomic,strong) NSNumber *state;
@property (nonatomic,strong) NSString *stateDes;
@property (nonatomic,strong) NSNumber *tel;
@property (nonatomic,strong) NSNumber *weight;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *userTel;
@property (nonatomic,strong) NSString *userAddress;
@property (nonatomic,strong) NSString *driverName;
@property (nonatomic,strong) NSString *driverTel;
@property (nonatomic,copy) NSNumber *canConnectDriver;
@property (nonatomic,copy) NSNumber* canConnectUser;
@property (nonatomic,copy) NSNumber* canRefund;
@property (nonatomic,copy) NSNumber* canRefuse;
@property (nonatomic,copy) NSNumber* canTake;
@property (nonatomic,copy) NSNumber* showDriver;

@end


