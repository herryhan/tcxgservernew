//
//  keepData.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/15.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "locateModel.h"

@interface keepData : NSObject

//获取缓存的城市列表
//+ (void)keepLocateModel:(NSData *)modelDic;
//+ (void)removeLocateModel;
//+ (NSData *)getLocateModel;

+ (void)keepLocateId:(NSNumber *)locateId;
+ (void)removeLocateId;
+ (NSNumber *)getLocateId;

+ (void)keepLocateName:(NSString *)locateName;
+ (void)removeLocateName;
+ (NSString *)getLocateName;

+ (void)keepLocateUrl:(NSString *)locateUrl;
+ (void)removeLocateUrl;
+ (NSString *)getLocateUrl;

//uuid
+ (void)keepUUID:(NSString *)uuid;
+ (void)removeUUID;
+ (NSString *)getUUID;

//channelid
+ (void)keepChannelid:(NSString *)channelid;
+ (void)removeChannelId;
+ (NSString *)getchannelid;

//用户名
+ (void)keepUser:(NSString *)userString;
+ (void)removeUser;
+ (NSString *)getUser;

//密码
+ (void)keepPwd:(NSString *)pwdString;
+ (void)removePwd;
+ (NSString *)getPwd;

//记录当前的登陆状态
+ (void)keepLoginState:(BOOL)isLogin;
+ (void)removeLoginState;
+ (BOOL)getLoginState;

@end
