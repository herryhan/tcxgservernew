//
//  SPAccount.m
//  ZTMall
//
//  Created by 庄园 on 17/1/22.
//  Copyright © 2017年 ztsm. All rights reserved.
//

#import "SPAccount.h"

@implementation SPAccount

+(instancetype)accountWithDict:(NSDictionary *)dict {
    return [[self alloc]initWithDict:dict];
    
}
-(instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [self init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"md5pwd"]) {
        return;
    }
}

/**
 *  从文件中解析对象时调用
 *
 */
//

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.code =  [decoder decodeObjectForKey:@"code"];
        
        self.count =  [decoder decodeInt64ForKey:@"count"];
        self.money =  [decoder decodeFloatForKey:@"money"];
        self.seller =  [decoder decodeObjectForKey:@"seller"];
        self.unTakeCash =  [decoder decodeFloatForKey:@"unTakeCash"];
        self.uuid = [decoder decodeObjectForKey:@"uuid"];
        self.state = [decoder decodeObjectForKey:@"state"];
        self.channelId = [decoder decodeObjectForKey:@"channelId"];
        self.sellerTel = [decoder decodeObjectForKey:@"sellerTel"];
        self.shopId = [decoder decodeInt64ForKey:@"shopId"];
        self.beginTime = [decoder decodeObjectForKey:@"beginTime"];
        self.endTime = [decoder decodeObjectForKey:@"endTime"];
        self.stop = [decoder decodeObjectForKey:@"stop"];
        self.notice = [decoder decodeObjectForKey:@"notice"];
        
    }
    return self;
}
/**
 *  将对象写入文件时调用
 *
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.code forKey:@"code"];
    [aCoder encodeInt64:self.count forKey:@"count"];
    [aCoder encodeFloat:self.money forKey:@"money"];
    [aCoder encodeObject:self.seller forKey:@"seller"];
    [aCoder encodeFloat:self.unTakeCash forKey:@"unTakeCash"];
    [aCoder encodeObject:self.uuid forKey:@"uuid"];
    [aCoder encodeObject:self.state forKey:@"state"];
    [aCoder encodeObject:self.channelId forKey:@"channelId"];
    [aCoder encodeObject:self.sellerTel forKey:@"sellerTel"];
    [aCoder encodeInt64:self.shopId forKey:@"shopId"];
    [aCoder encodeObject:self.beginTime forKey:@"beginTime"];
    [aCoder encodeObject:self.endTime forKey:@"endTime"];
    [aCoder encodeObject:self.stop forKey:@"stop"];
    [aCoder encodeObject:self.notice forKey:@"notice"];
    
}
@end

