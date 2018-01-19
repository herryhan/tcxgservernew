//
//  SPAccountTool.h
//  ZTMall
//
//  Created by 庄园 on 17/1/22.
//  Copyright © 2017年 ztsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPAccount.h"

@interface SPAccountTool : NSObject


/**
 *  存储账号信息
 *
 *  @param account 需要存储的账号
 */
+(void)saveAccount:(SPAccount *)account;
/**
 *  返回存储的账号信息
 *
 *
 */
+(SPAccount *)account;


@end
