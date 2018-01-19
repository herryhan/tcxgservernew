//
//  cityShoppingTool.h
//  同城享购
//
//  Created by 庄园 on 2017/11/8.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cityShoppingTool : NSObject

+ (NSDictionary *)jsonConvertToDic:(id)responseObject;
+ (NSArray *)jsonConvertToArray:(id)responseObject;
+ (UIImage*)createImageWithColor:(UIColor*)color andSize:(CGSize)size;

@end
