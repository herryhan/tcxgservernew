//
//  SPAccount.h
//  ZTMall
//
//  Created by 庄园 on 17/1/22.
//  Copyright © 2017年 ztsm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPAccount : NSObject <NSCoding>

@property(nonatomic,copy) NSString *code;
@property(nonatomic,assign) int64_t count;
@property(nonatomic,assign) float money;
@property(nonatomic,copy) NSString *seller;
@property(nonatomic,assign) float unTakeCash;
@property(nonatomic,copy) NSString *uuid;
@property(nonatomic,copy) NSString *channelId;
@property(nonatomic,copy) NSString *state;
@property(nonatomic,copy) NSString *sellerTel;
@property(nonatomic,assign) int64_t shopId;
@property(nonatomic,copy) NSString *beginTime;
@property(nonatomic,copy) NSString *endTime;
@property (nonatomic,copy) NSString *stop;
@property (nonatomic,copy) NSString *notice;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

