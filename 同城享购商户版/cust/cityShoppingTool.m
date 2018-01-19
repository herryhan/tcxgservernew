//
//  cityShoppingTool.m
//  同城享购
//
//  Created by 庄园 on 2017/11/8.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "cityShoppingTool.h"

@implementation cityShoppingTool

+(NSDictionary *)jsonConvertToDic:(id)responseObject{
    
    NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
    NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"%@",jsonDict);
    return jsonDict;
}
+(NSArray *)jsonConvertToArray:(id)responseObject{
    
    NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
    NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"%@",jsonArray);
    return jsonArray;
}

+(UIImage*)createImageWithColor:(UIColor*)color andSize:(CGSize)size{
    
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
    
}
@end
