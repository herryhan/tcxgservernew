//
//  keepData.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/15.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "keepData.h"

@implementation keepData

+ (void)keepLocateId:(NSNumber *)locateId{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:locateId forKey:@"locateId"];
    [defaults synchronize];
}
+ (void)removeLocateId{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"locateId"];
    [defaults synchronize];

}
+ (NSNumber *)getLocateId;
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *locateId = [defaults objectForKey:@"locateId"];
    return locateId;
}

+ (void)keepLocateName:(NSString *)locateName{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:locateName forKey:@"locateName"];
    [defaults synchronize];
    
}
+ (void)removeLocateName{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"locateName"];
    [defaults synchronize];
}
+ (NSString *)getLocateName{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *locateName = [defaults objectForKey:@"locateName"];
    return locateName;
}

+ (void)keepLocateUrl:(NSString *)locateUrl{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:locateUrl forKey:@"locateUrl"];
    [defaults synchronize];
    
}
+ (void)removeLocateUrl{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"locateUrl"];
    [defaults synchronize];
}
+ (NSString *)getLocateUrl{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *locateUrl = [defaults objectForKey:@"locateUrl"];
    return locateUrl;
    
}


//+ (void)keepLocateModel:(NSData *)modelData{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:modelData forKey:@"localModel"];
//    [defaults synchronize];
//}
//+ (void)removeLocateModel{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults removeObjectForKey:@"localModel"];
//    [defaults synchronize];
//}
//+ (NSData *)getLocateModel{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSData *model = [defaults objectForKey:@"localModel"];
//    return model;
//}

+ (void)keepUUID:(NSString *)uuid{
   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:uuid forKey:@"uuid"];
    [defaults synchronize];
}
+ (void)keepChannelid:(NSString *)channelid{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:channelid forKey:@"channelId"];
    [defaults synchronize];
}
+ (void)keepUser:(NSString *)userString{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userString forKey:@"user"];
    [defaults synchronize];
}
+ (void)keepPwd:(NSString *)pwdString{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:pwdString forKey:@"pwd"];
    [defaults synchronize];
}
+ (void)keepUrl:(NSString *)url{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:url forKey:@"url"];
    [defaults synchronize];
}
+ (void)removeUrl{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"url"];
    [defaults synchronize];
}
+ (void)removeUser{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"user"];
    [defaults synchronize];
}

+ (void)removePwd{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"pwd"];
    [defaults synchronize];
}

+(NSString *)getUUID{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uuid = [defaults objectForKey:@"uuid"];
    return uuid;
}

+ (NSString *)getchannelid{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *channelId = [defaults objectForKey:@"channelId"];
    return channelId;
}

+ (void)removeUUID{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"uuid"];
    [defaults synchronize];
}

+ (void)removeChannelId{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"channelId"];
    [defaults synchronize];
}

+ (NSString *)getUser{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *user = [defaults objectForKey:@"user"];
    return user;
}
+ (NSString *)getPwd{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *pwd = [defaults objectForKey:@"pwd"];
    return pwd;
}

+ (NSString *)currentUrl{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *url = [defaults objectForKey:@"url"];
    return url;
}

+ (void)keepLoginState:(BOOL)isLogin{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:isLogin forKey:@"LoginState"];
    [defaults synchronize];
}

+ (void)removeLoginState{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"LoginState"];
    [defaults synchronize];
}

+ (BOOL)getLoginState{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL loginState =[defaults boolForKey:@"LoginState"];
    return loginState;
}

@end
