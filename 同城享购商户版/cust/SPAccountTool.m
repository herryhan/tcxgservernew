//
//  SPAccountTool.m
//  ZTMall
//
//  Created by 庄园 on 17/1/22.
//  Copyright © 2017年 ztsm. All rights reserved.
//

#import "SPAccountTool.h"


#define DBAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"acccount.data"]
#define DBShenheFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"shenhe.data"]

@implementation SPAccountTool

+ (void)saveAccount:(SPAccount *)account {
    [NSKeyedArchiver archiveRootObject:account toFile:DBAccountFile];
}

+ (SPAccount *)account {
    //取出账号
    SPAccount *account =  [NSKeyedUnarchiver unarchiveObjectWithFile:DBAccountFile];
    return account;
}
@end
